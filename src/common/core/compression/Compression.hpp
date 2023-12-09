//
// Created by qiuwenchen on 2023/11/21.
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

#pragma once

#include "CompressionInfo.hpp"
#include "Lock.hpp"
#include "ThreadLocal.hpp"
#include <functional>
#include <map>
#include <set>

namespace WCDB {

class InnerHandle;

class CompressionEvent {
public:
    virtual ~CompressionEvent() = 0;

protected:
    friend class Compression;
    // parameter will be nullptr when all tables are compressed.
    virtual void didCompress(const CompressionTableBaseInfo* info) = 0;
};

class Compression final {
#pragma mark - Initialize
public:
    Compression(CompressionEvent* event);

    typedef std::function<void(CompressionTableUserInfo&)> TableFilter;
    void setTableFilter(const TableFilter& tableFilter);
    bool shouldCompress() const;

private:
    void purge();
    TableFilter m_tableFilter;

protected:
    class InfoInitializer {
        friend class Compression;

    public:
        virtual ~InfoInitializer() = 0;

    protected:
        virtual InnerHandle* getCurrentHandle() const = 0;

        bool getTargetTableInfo(const UnsafeStringView& tableName,
                                bool& exists,
                                std::list<StringView>& columns);
        bool checkCompressingColumns(CompressionTableUserInfo& info,
                                     std::list<StringView>& curColumns);
    };

    bool initInfo(InfoInitializer& initializer, const UnsafeStringView& table);
    bool hintThatTableWillBeCreated(InfoInitializer& initializer,
                                    const UnsafeStringView& table);
    void markAsNoNeedToCompress(const UnsafeStringView& table);
    void markAsCompressed(const CompressionTableInfo* info);
    Optional<const CompressionTableInfo*> getInfo(const UnsafeStringView& table);
    Optional<const CompressionTableInfo*>
    getOrInitInfo(InfoInitializer& initializer, const UnsafeStringView& table);

private:
    ThreadLocal<StringViewMap<const CompressionTableInfo*>> m_localFilted;
    std::set<const CompressionTableInfo*> m_compressings;
    StringViewMap<const CompressionTableInfo*> m_filted;
    StringViewSet m_hints;
    std::list<CompressionTableInfo> m_holder;
    mutable SharedLock m_lock;

#pragma mark - Bind
public:
    class Binder : public InfoInitializer {
        friend class Compression;

    public:
        Binder(Compression& compression);
        virtual ~Binder() override = 0;

        Optional<const CompressionTableInfo*>
        tryGetCompressionInfo(const UnsafeStringView& table);
        bool hintThatTableWillBeCreated(const UnsafeStringView& table);

    private:
        Compression& m_compression;
    };
#pragma mark - Step
public:
    class Stepper : public InfoInitializer {
        friend class Compression;

    public:
        virtual ~Stepper() override = 0;

    protected:
        virtual Optional<StringViewSet> getAllTables() = 0;
        virtual bool
        filterComplessingTables(std::set<const CompressionTableInfo*>& allTableInfos)
        = 0;
        virtual Optional<bool> compressRows(const CompressionTableInfo* info) = 0;
    };

    Optional<bool> step(Compression::Stepper& stepper);

protected:
    // worked
    Optional<bool> tryCompressRows(Compression::Stepper& stepper);
    Optional<bool> tryAcquireTables(Compression::Stepper& stepper);

private:
    bool m_tableAcquired;
    bool m_compressed;

#pragma mark - Event
public:
    bool isCompressed() const;

protected:
    CompressionEvent* m_event;
};

} //namespace WCDB
