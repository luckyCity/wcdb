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

#include <WCDB/Assembler.hpp>
#include <WCDB/Crawlable.hpp>
#include <WCDB/MasterCrawler.hpp>
#include <WCDB/Repairman.hpp>
#include <WCDB/SequenceCrawler.hpp>
#include <list>
#include <map>

namespace WCDB {

namespace Repair {

class FullCrawler final : public Repairman, public MasterCrawlerDelegate, public SequenceCrawlerDelegate {
#pragma mark - Initialize
public:
    FullCrawler(const String &source);

#pragma mark - Repair
public:
    bool work();

protected:
    std::map<String, std::list<String>> m_associatedSQLs;

#pragma mark - Crawlable
protected:
    void onCellCrawled(const Cell &cell) override final;
    bool willCrawlPage(const Page &, int) override final;

#pragma mark - Error
protected:
    void onErrorCritical() override final;

#pragma mark - MasterCrawlerDelegate
protected:
    void onMasterPageCrawled(const Page &page) override final;
    void onMasterCellCrawled(const Cell &cell, const Master &master) override final;
    void onMasterCrawlerError() override final;

    MasterCrawler m_masterCrawler;

#pragma mark - SequenceCrawlerDelegate
protected:
    void onSequencePageCrawled(const Page &page) override final;
    void onSequenceCellCrawled(const Cell &cell, const Sequence &sequence) override final;
    void onSequenceCrawlerError() override final;

    SequenceCrawler m_sequenceCrawler;
};

} //namespace Repair

} //namespace WCDB
