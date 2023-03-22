//
// Created by 陈秋文 on 2022/8/29.
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

#include "CPPDeclaration.h"
#include "Error.hpp"
#include "Recyclable.hpp"

namespace WCDB {

class BaseChainCall {
public:
    BaseChainCall() = delete;
    BaseChainCall(const BaseChainCall &);
    BaseChainCall &operator=(const BaseChainCall &);
    BaseChainCall(BaseChainCall &&other);
    virtual ~BaseChainCall() = 0;

    /**
     @brief The error generated by current statement.
     Since it is too cumbersome to get the error after every operation, it‘s better to use monitoring interfaces to obtain errors and print them to the log.
     @see   `static Database::globalTraceError()`
     @see   `Database::traceError()`
     @return WCDB::Error
     */
    const Error &getError();

protected:
    void assertError(const UnsafeStringView &message);
    BaseChainCall(Recyclable<InnerDatabase *> databaseHolder);
    std::shared_ptr<Handle> m_handle;
};

template<class StatementType>
class ChainCall : public BaseChainCall {
    static_assert(std::is_base_of<Statement, StatementType>::value, "");

public:
    /**
     @brief The statement that `ChainCall` will execute.
     You can cunstomize this statement directly to implement the capabilities not provided by `ChainCall`.
     */
    StatementType &getStatement() { return m_statement; }

protected:
    ChainCall(Recyclable<InnerDatabase *> databaseHolder)
    : BaseChainCall(databaseHolder)
    {
    }
    virtual ~ChainCall() override = default;

    StatementType m_statement;
};

} //namespace WCDB