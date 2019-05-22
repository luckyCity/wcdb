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

#include <WCDB/Console.hpp>
#include <WCDB/CoreConst.h>
#include <WCDB/Error.hpp>
#include <WCDB/Notifier.hpp>
#include <WCDB/Version.h>
#include <iostream>

namespace WCDB {

std::nullptr_t Console::_initialize()
{
    Console::errored(Console::report);
    return nullptr;
}

void Console::initialize()
{
    static std::nullptr_t _ = _initialize();
    WCDB_UNUSED(_);
}

std::atomic<bool>& Console::debuggableValue()
{
#if WCDB_DEBUG
    std::atomic<bool>* s_debuggable = new std::atomic<bool>(true);
#else  // WCDB_DEBUG
    std::atomic<bool>* s_debuggable = new std::atomic<bool>(false);
#endif // WCDB_DEBUG
    return *s_debuggable;
}

void Console::debug()
{
    debuggableValue().store(true);
}

void Console::release()
{
    debuggableValue().store(false);
}

bool Console::debuggable()
{
    return debuggableValue().load();
}

void Console::errored(const Notifier::Callback& callback)
{
    if (callback != nullptr) {
        Notifier::shared().setNotification(
        std::numeric_limits<int>::min(), NotifierLoggerName, callback);
    } else {
        Notifier::shared().unsetNotification(NotifierLoggerName);
    }
}

void Console::report(const Error& error)
{
    switch (error.level) {
    case Error::Level::Ignore:
        break;
    case Error::Level::Debug:
        if (!WCDB::Console::debuggable()) {
            break;
        }
        // fallthrough
    default:
        print(error.getDescription());
        break;
    }
    if (error.level == Error::Level::Fatal) {
        breakpoint();
    }
}

void Console::breakpoint()
{
}

#if WCDB_ASSERTION

void Console::fatal(const String& message, const char* file, int line, const char* function)
{
    Error error(Error::Code::Misuse, Error::Level::Fatal, message);
    error.infos.set(ErrorStringKeySource, ErrorSourceAssertion);
    error.infos.set("File", file);
    error.infos.set("Line", line);
    error.infos.set("Func", function);
    error.infos.set("Version", WCDB_VERSION);
    error.infos.set("BuildTime", WCDB_BUILD_TIME);
    error.infos.set("BuildTimestamp", WCDB_BUILD_TIMESTAMP);
    error.infos.set("CommitHash", WCDB_COMMIT_HASH);
    print(error.getDescription());
}

#else // WCDB_ASSERTION

void Console::fatal(const String& message)
{
    Error error(Error::Code::Misuse, Error::Level::Fatal, message);
    error.infos.set(ErrorStringKeySource, ErrorSourceAssertion);
    error.infos.set("Version", WCDB_VERSION);
    error.infos.set("BuildTime", WCDB_BUILD_TIME);
    error.infos.set("BuildTimestamp", WCDB_BUILD_TIMESTAMP);
    error.infos.set("CommitHash", WCDB_COMMIT_HASH);
    print(error.getDescription());
}

#endif // WCDB_ASSERTION

#if WCDB_TRACE

void Console::trace(const String& message, const char* file, int line, const char* function)
{
    Error error(Error::Code::Notice, Error::Level::Notice, message);
    error.infos.set(ErrorStringKeySource, ErrorSourceTrace);
    error.infos.set("File", file);
    error.infos.set("Line", line);
    error.infos.set("Func", function);
    constexpr const int size = 100;
    char name[size];
    memset(name, 0, size);
    pthread_getname_np(pthread_self(), name, size);
    error.infos.set("Thread", name);
    print(error.getDescription());
}

#endif

} // namespace WCDB
