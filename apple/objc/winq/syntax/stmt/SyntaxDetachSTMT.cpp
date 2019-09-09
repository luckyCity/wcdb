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

namespace WCDB {

namespace Syntax {

DetachSTMT::~DetachSTMT() = default;

bool DetachSTMT::isValid() const
{
    return schema.isValid() && !schema.isMain();
}

#pragma mark - Identifier
Identifier::Type DetachSTMT::getType() const
{
    return type;
}

bool DetachSTMT::describle(std::ostringstream& stream) const
{
    stream << "DETACH " << schema;
    return true;
}

void DetachSTMT::iterate(const Iterator& iterator, bool& stop)
{
    Identifier::iterate(iterator, stop);
    recursiveIterate(schema, iterator, stop);
}

} // namespace Syntax

} // namespace WCDB
