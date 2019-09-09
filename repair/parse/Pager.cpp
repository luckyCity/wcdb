//
// Created by sanhuazhang on 2018/05/19
//

/*
 * Tencent is pleased to support the open source community by making
 * WCDB available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <WCDB/Assertion.hpp>
#include <WCDB/CoreConst.h>
#include <WCDB/FileManager.hpp>
#include <WCDB/Notifier.hpp>
#include <WCDB/Pager.hpp>
#include <WCDB/Serialization.hpp>
#include <WCDB/StringView.hpp>
#include <WCDB/ThreadedErrors.hpp>

#warning TODO - support cipher database
namespace WCDB {

namespace Repair {

#pragma mark - Initialize
Pager::Pager(const UnsafeStringView &path)
: m_fileHandle(path)
, m_pageSize(-1)
, m_reservedBytes(-1)
, m_numberOfPages(0)
, m_wal(this)
, m_fileSize(0)
, m_walImportance(true)
{
}

Pager::~Pager() = default;

void Pager::setPageSize(int pageSize)
{
    WCTAssert(!isInitialized());
    m_pageSize = pageSize;
}

void Pager::setReservedBytes(int reservedBytes)
{
    WCTAssert(!isInitialized());
    m_reservedBytes = reservedBytes;
}

const StringView &Pager::getPath() const
{
    return m_fileHandle.path;
}

#pragma mark - Page
int Pager::getNumberOfPages() const
{
    WCTAssert(isInitialized());
    return std::max(m_wal.getMaxPageno(), m_numberOfPages);
}

int Pager::getUsableSize() const
{
    WCTAssert(isInitialized() || isInitializing());
    return m_pageSize - m_reservedBytes;
}

int Pager::getPageSize() const
{
    WCTAssert(isInitialized() || isInitializing());
    return m_pageSize;
}

int Pager::getReservedBytes() const
{
    WCTAssert(isInitialized());
    return m_reservedBytes;
}

MappedData Pager::acquirePageData(int number)
{
    return acquirePageData(number, 0, m_pageSize);
}

MappedData Pager::acquirePageData(int number, off_t offset, size_t size)
{
    WCTAssert(isInitialized());
    WCTAssert(number > 0);
    WCTAssert(offset + size <= m_pageSize);
    MappedData data;
    if (m_wal.containsPage(number)) {
        data = m_wal.acquirePageData(number, offset, size);
    } else if (number > m_numberOfPages) {
        markAsCorrupted(
        number,
        StringView::formatted(
        "Acquired page number: %d exceeds the page count: %d.", number, m_numberOfPages));
        return MappedData::null();
    } else {
        data = m_fileHandle.mapPage(number, offset, size);
    }
    if (data.size() != size) {
        if (data.size() > 0) {
            //short read
            markAsCorrupted((int) (offset / m_pageSize + 1),
                            StringView::formatted("Acquired page data with size: %d is less than the expected size: %d.",
                                                  data.size(),
                                                  size));
        } else {
            assignWithSharedThreadedError();
        }
        return MappedData::null();
    }
    return data;
}

MappedData Pager::acquireData(off_t offset, size_t size)
{
    WCTAssert(m_fileHandle.isOpened());
    MappedData data = m_fileHandle.map(offset, size);
    if (data.size() != size) {
        if (data.size() > 0) {
            markAsCorrupted((int) (offset / m_pageSize + 1),
                            StringView::formatted("Acquired data with size: %d is less than the expected size: %d.",
                                                  data.size(),
                                                  size));
        } else {
            assignWithSharedThreadedError();
        }
        return MappedData::null();
    }
    return data;
}

#pragma mark - Wal
void Pager::setWalImportance(bool flag)
{
    m_walImportance = flag;
    m_wal.setShmLegality(flag);
}

void Pager::setMaxWalFrame(int maxWalFrame)
{
    m_wal.setMaxAllowedFrame(maxWalFrame);
}

int Pager::getDisposedWalPages() const
{
    return m_wal.getDisposedPages();
}

void Pager::disposeWal()
{
    m_wal.dispose();
}

const std::pair<uint32_t, uint32_t> &Pager::getWalSalt() const
{
    return m_wal.getSalt();
}

int Pager::getNumberOfWalFrames() const
{
    return m_wal.getNumberOfFrames();
}

#pragma mark - Error
void Pager::markAsCorrupted(int page, const UnsafeStringView &message)
{
    Error error(Error::Code::Corrupt, Error::Level::Ignore, message);
    error.infos.insert_or_assign(ErrorStringKeySource, ErrorSourceRepair);
    error.infos.insert_or_assign(ErrorStringKeyPath, getPath());
    error.infos.insert_or_assign("Page", page);
    Notifier::shared().notify(error);
    setError(std::move(error));
}

void Pager::markAsError(Error::Code code)
{
    Error error(code, Error::Level::Ignore);
    error.infos.insert_or_assign(ErrorStringKeySource, ErrorSourceRepair);
    error.infos.insert_or_assign(ErrorStringKeyPath, getPath());
    Notifier::shared().notify(error);
    setError(std::move(error));
}

#pragma mark - Initializeable
bool Pager::doInitialize()
{
    auto fileSize = FileManager::getFileSize(getPath());
    ;
    if (!fileSize.has_value()) {
        assignWithSharedThreadedError();
        return false;
    }
    m_fileSize = fileSize.value();
    if (m_fileSize == 0) {
        markAsError(Error::Code::Empty);
        return false;
    }

    if (!m_fileHandle.open(FileHandle::Mode::ReadOnly)) {
        assignWithSharedThreadedError();
        return false;
    }
    FileManager::setFileProtectionCompleteUntilFirstUserAuthenticationIfNeeded(getPath());
    if (m_pageSize == -1 || m_reservedBytes == -1) {
        MappedData data = acquireData(0, 100);
        if (data.empty()) {
            assignWithSharedThreadedError();
            return false;
        }
        if (memcmp(data.buffer(), "SQLite format 3\000", 16) != 0) {
            markAsError(Error::Code::NotADatabase);
            return false;
        }
        Deserialization deserialization(data);
        //parse page size
        if (m_pageSize == -1) {
            deserialization.seek(16);
            WCTAssert(deserialization.canAdvance(2));
            m_pageSize = deserialization.advance2BytesInt();
        }
        //parse reserved bytes
        if (m_reservedBytes == -1) {
            deserialization.seek(20);
            WCTAssert(deserialization.canAdvance(1));
            m_reservedBytes = deserialization.advance1ByteInt();
        }
    }
    if (((m_pageSize - 1) & m_pageSize) != 0 || m_pageSize < 512 || m_pageSize > 65536) {
        markAsCorrupted(
        1, StringView::formatted("Page size: %d is not aligned or not too small.", m_pageSize));
        return false;
    }
    if (m_reservedBytes < 0 || m_reservedBytes > 255) {
        markAsCorrupted(
        1, StringView::formatted("Reversed bytes: %d is illegal.", m_reservedBytes));
        return false;
    }

    m_fileHandle.setPageSize(m_pageSize);

    m_numberOfPages = (int) ((m_fileSize + m_pageSize - 1) / m_pageSize);

    if (m_wal.initialize()) {
        return true;
    }
    if (m_walImportance || !m_error.isCorruption()) {
        return false;
    }
    disposeWal();
    return true;
}

} //namespace Repair

} //namespace WCDB
