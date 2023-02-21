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

#include <WCDB/Assertion.hpp>
#include <WCDB/SQL.hpp>
#include <atomic>

namespace WCDB {

SQL::SQL() = default;

SQL::SQL(const SQL& other)
: m_syntax(other.m_syntax)
, m_description(other.m_hasDescription ? std::atomic_load(&other.m_description) : nullptr)
, m_hasDescription(other.m_hasDescription)
{
}

SQL::SQL(SQL&& other)
: m_syntax(std::move(other.m_syntax))
, m_description(other.m_hasDescription ? std::atomic_load(&other.m_description) : nullptr)
, m_hasDescription(other.m_hasDescription)
{
    if (other.m_hasDescription) {
        std::atomic_store(&other.m_description, std::shared_ptr<StringView>(nullptr));
        other.m_hasDescription = false;
    }
}

SQL::SQL(const Shadow<Syntax::Identifier>& syntax)
: m_syntax(syntax), m_description(nullptr), m_hasDescription(false)
{
}

SQL::SQL(Shadow<Syntax::Identifier>&& syntax)
: m_syntax(std::move(syntax)), m_description(nullptr), m_hasDescription(false)
{
}

SQL::SQL(std::shared_ptr<Syntax::Identifier>&& underlying)
: m_syntax(std::move(underlying)), m_description(nullptr), m_hasDescription(false)
{
}

SQL::~SQL() = default;

SQL& SQL::operator=(const SQL& other)
{
    m_syntax = other.m_syntax;
    if (other.m_hasDescription) {
        m_description = std::atomic_load(&other.m_description);
    } else {
        m_description = nullptr;
    }
    m_hasDescription = other.m_hasDescription;
    return *this;
}

SQL& SQL::operator=(SQL&& other)
{
    m_syntax = std::move(other.m_syntax);
    if (other.m_hasDescription) {
        m_description = std::atomic_load(&other.m_description);
    } else {
        m_description = nullptr;
    }
    m_hasDescription = other.m_hasDescription;
    if (other.m_hasDescription) {
        std::atomic_store(&other.m_description, std::shared_ptr<StringView>(nullptr));
        other.m_hasDescription = false;
    }
    return *this;
}

SQL::Type SQL::getType() const
{
    return m_syntax.get()->getType();
}

void SQL::iterate(const ConstIterator& iterator) const
{
    return m_syntax.get()->iterate(iterator);
}

void SQL::iterate(const Iterator& iterator)
{
    if (m_hasDescription) {
        std::atomic_store(&m_description, std::shared_ptr<StringView>(nullptr));
        m_hasDescription = false;
    }
    return m_syntax.get()->iterate(iterator);
}

StringView SQL::getDescription() const
{
    // class SQL is not designed for thread-safe.
    // But here, the cache of `m_description` may be accessed/modified in different threads.
    // So we must make this const function thread-safe.
    std::shared_ptr<StringView> description = std::atomic_load(&m_description);
    while (description == nullptr) {
        if (m_syntax != nullptr) {
            std::atomic_store(
            &m_description,
            std::make_shared<StringView>(m_syntax.get()->getDescription()));
            description = std::atomic_load(&m_description);
            m_hasDescription = true;
        } else {
            return StringView();
        }
    }
    return *description.get();
}

Syntax::Identifier& SQL::syntax()
{
    // Note that `syntax()` is not designed for thread-safe.
    if (m_hasDescription) {
        std::atomic_store(&m_description, std::shared_ptr<StringView>(nullptr));
        m_hasDescription = false;
    }
    return *m_syntax.get();
}

const Syntax::Identifier& SQL::syntax() const
{
    return *m_syntax.get();
}

} // namespace WCDB
