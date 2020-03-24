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

#import <WCDB/WCTDatabase.h>
#import <WCDB/WCTOptional.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCTDatabase (File)

/**
 @brief Remove all database-related files.
 @warning You should call it on a closed database. Otherwise you will get a warning.
 @return YES if all files are removed.
 */
- (BOOL)removeFiles;

/**
 @brief This interface is equivalent to [database moveFilesToDirectory:directory withExtraFiles:nil andError:error].
 @param directory destination
 @return YES if all files are moved.
 */
- (BOOL)moveFilesToDirectory:(NSString *)directory;

/**
 @brief Paths to all database-related files.
 @return paths
 */
- (NSArray<NSString *> *)paths;

/**
 @brief Get the space used by the database files.
 @warning You should call it on a closed database. Otherwise you will get a warning.
 @return The sum of files size in bytes.
 */
- (WCTOptionalSize)getFilesSize;

/**
@brief Set the default directory for temporary database files. If not set, an existing directory will be selected as the temporary database files directory in the following order:
    1. TMPDIR environment value;
    2. /Var/tmp;
    3. /usr/tmp;
    4. /tmp;
    5. the current directory;
*/
+ (BOOL)setDefaultTemporaryDatabaseFileDirectory:(NSString*)dir;

@end

NS_ASSUME_NONNULL_END
