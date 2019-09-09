//
// Created by sanhuazhang on 2019/05/02
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

#include <WCDB/Syntax.h>
#include <WCDB/SyntaxAssertion.hpp>
#include <WCDB/SyntaxEnum.hpp>

namespace WCDB {

namespace Syntax {

UpdateSTMT::~UpdateSTMT() = default;

bool UpdateSTMT::isValid() const
{
    return table.isValid();
}

#pragma mark - Identifier
Identifier::Type UpdateSTMT::getType() const
{
    return type;
}

bool UpdateSTMT::describle(std::ostringstream& stream, bool skipSchema) const
{
    if (withClause.isValid()) {
        stream << withClause << space;
    }
    stream << "UPDATE ";
    if (conflictActionValid()) {
        stream << conflictAction << space;
    }
    if (!table.describle(stream, skipSchema)) {
        return false;
    }
    stream << " SET ";
    if (!columnsList.empty()) {
        WCTSyntaxRemedialAssert(columnsList.size() == expressions.size());
        auto columns = columnsList.begin();
        auto expression = expressions.begin();
        bool comma = false;
        while (columns != columnsList.end() && expression != expressions.end()) {
            if (comma) {
                stream << ", ";
            } else {
                comma = true;
            }
            if (columns->size() > 1) {
                stream << "(" << *columns << ")";
            } else {
                stream << *columns;
            }
            stream << " = " << *expression;
            ++columns;
            ++expression;
        }
        if (condition.isValid()) {
            stream << " WHERE " << condition;
        }
        if (!orderingTerms.empty()) {
            stream << " ORDER BY " << orderingTerms;
        }
        if (limit.isValid()) {
            stream << " LIMIT " << limit;
            switch (limitParameterType) {
            case LimitParameterType::NotSet:
                break;
            case LimitParameterType::Offset:
                stream << " OFFSET " << limitParameter;
                break;
            case LimitParameterType::End:
                stream << ", " << limitParameter;
                break;
            }
        }
    }
    return true;
}

bool UpdateSTMT::describle(std::ostringstream& stream) const
{
    return describle(stream, false);
}

void UpdateSTMT::iterate(const Iterator& iterator, bool& stop)
{
    Identifier::iterate(iterator, stop);
    if (withClause.isValid()) {
        recursiveIterate(withClause, iterator, stop);
    }
    recursiveIterate(table, iterator, stop);
    if (!columnsList.empty()) {
        WCTIterateRemedialAssert(columnsList.size() == expressions.size());
        auto columns = columnsList.begin();
        auto expression = expressions.begin();
        while (columns != columnsList.end() && expression != expressions.end()) {
            listIterate(*columns, iterator, stop);
            expression->iterate(iterator, stop);
            ++columns;
            ++expression;
        }
        if (condition.isValid()) {
            recursiveIterate(condition, iterator, stop);
        }
        if (!orderingTerms.empty()) {
            listIterate(orderingTerms, iterator, stop);
        }
        if (limit.isValid()) {
            recursiveIterate(limit, iterator, stop);
            switch (limitParameterType) {
            case LimitParameterType::NotSet:
                break;
            case LimitParameterType::Offset:
            case LimitParameterType::End:
                recursiveIterate(limitParameter, iterator, stop);
                break;
            }
        }
    }
}

} // namespace Syntax

} // namespace WCDB
