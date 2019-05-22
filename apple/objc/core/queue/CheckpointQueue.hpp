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

#include <WCDB/AsyncQueue.hpp>
#include <WCDB/TimedQueue.hpp>
#include <WCDB/WINQ.h>
#include <set>

namespace WCDB {

class CheckpointQueueEvent {
public:
    virtual ~CheckpointQueueEvent() = 0;

protected:
    virtual bool databaseShouldCheckpoint(const String& path, int frames) = 0;
    friend class CheckpointQueue;
};

class CheckpointQueue final : public AsyncQueue {
public:
    CheckpointQueue(const String& name, CheckpointQueueEvent* event);

    void put(const String& path, int frames);
    void remove(const String& path);

    void register_(const String& path);
    void unregister(const String& path);

protected:
    void put(const String& path, double delay, int frames);
    bool onTimed(const String& path, const int& frames);
    void loop() override final;

    TimedQueue<String, int> m_timedQueue;
    CheckpointQueueEvent* m_event;

    SharedLock m_lock;
    std::map<String, int> m_records;
};

} // namespace WCDB
