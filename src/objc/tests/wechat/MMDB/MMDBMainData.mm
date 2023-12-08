//
//  MMDBMainData.m
//  MicroMessenger
//
//  Created by alantao on 3/18/15.
//  Copyright (c) 2015 Tencent. All rights reserved.
//

#import "MMDBMainData.h"

#pragma mark -
#pragma mark # Contact #
#pragma mark -

#pragma mark - Contact

#define FRIEND_VERSION 1

#define CONTACT_COL_VERSION TableVer
#define CONTACT_COL_USR_NAME UsrName
#define CONTACT_COL_NICK_NAME NickName
#define CONTACT_COL_UIN Uin
#define CONTACT_COL_EMAIL Email
#define CONTACT_COL_MOBILE Mobile
#define CONTACT_COL_SEX Sex
#define CONTACT_COL_FULL_PY FullPY
#define CONTACT_COL_SHORT_PY ShortPY
#define CONTACT_COL_IMG Img
#define CONTACT_COL_TYPE Type
#define CONTACT_COL_RESERVE_INT LastChatTime
#define CONTACT_COL_DRAFT Draft

@interface DBContact ()
@property (nonatomic, assign) UInt32 CONTACT_COL_RESERVE_INT;
WCDB_PROPERTY(CONTACT_COL_RESERVE_INT);
@end

@implementation DBContact

WCDB_IMPLEMENTATION(DBContact)
WCDB_SYNTHESIZE_COLUMN(version, WCDB_STRINGIFY(CONTACT_COL_VERSION))
WCDB_SYNTHESIZE_COLUMN(userName, WCDB_STRINGIFY(CONTACT_COL_USR_NAME))
WCDB_SYNTHESIZE_COLUMN(nickName, WCDB_STRINGIFY(CONTACT_COL_NICK_NAME))
WCDB_SYNTHESIZE_COLUMN(uin, WCDB_STRINGIFY(CONTACT_COL_UIN))
WCDB_SYNTHESIZE_COLUMN(email, WCDB_STRINGIFY(CONTACT_COL_EMAIL))
WCDB_SYNTHESIZE_COLUMN(mobile, WCDB_STRINGIFY(CONTACT_COL_MOBILE))
WCDB_SYNTHESIZE_COLUMN(sex, WCDB_STRINGIFY(CONTACT_COL_SEX))
WCDB_SYNTHESIZE_COLUMN(fullPinYin, WCDB_STRINGIFY(CONTACT_COL_FULL_PY))
WCDB_SYNTHESIZE_COLUMN(extent, WCDB_STRINGIFY(CONTACT_COL_SHORT_PY))
WCDB_SYNTHESIZE_COLUMN(image, WCDB_STRINGIFY(CONTACT_COL_IMG))
WCDB_SYNTHESIZE_COLUMN(type, WCDB_STRINGIFY(CONTACT_COL_TYPE))
WCDB_SYNTHESIZE(CONTACT_COL_RESERVE_INT)
WCDB_SYNTHESIZE_COLUMN(draft, WCDB_STRINGIFY(CONTACT_COL_DRAFT))

WCDB_NOT_NULL(userName)
WCDB_PRIMARY(userName)

WCDB_DEFAULT(CONTACT_COL_RESERVE_INT, 0)
WCDB_DEFAULT(version, FRIEND_VERSION)
WCDB_DEFAULT(uin, 0)
WCDB_DEFAULT(sex, 0)
WCDB_DEFAULT(type, 0)

@end

#pragma mark - ContactExt

#define CONTACTEXT_COL_USR_NAME UsrName
#define CONTACTEXT_COL_TYPE ConType
#define CONTACTEXT_COL_REMARK ConRemark
#define CONTACTEXT_COL_REMARK_PYSHORT ConRemark_PYShort
#define CONTACTEXT_COL_REMARK_PYFULL ConRemark_PYFull
#define CONTACTEXT_COL_QQMBLOG ConQQMBlog
#define CONTACTEXT_COL_SMBLOG ConSMBlog
#define CONTACTEXT_COL_CHATROOM_MEM ConChatRoomMem
#define CONTACTEXT_COL_CHAT_STATUS ConIntRes1
#define CONTACTEXT_COL_INTRES2 ConIntRes2
#define CONTACTEXT_COL_INTRES3 ConIntRes3
#define CONTACTEXT_COL_DOMAINLIST ConStrRes1
#define CONTACTEXT_COL_STRRES2 ConStrRes2
#define CONTACTEXT_COL_STRRES3 ConStrRes3

@interface DBContactExt ()
@property (nonatomic, assign) UInt32 CONTACTEXT_COL_INTRES2;
@property (nonatomic, assign) UInt32 CONTACTEXT_COL_INTRES3;
@property (nonatomic, retain) NSString* CONTACTEXT_COL_STRRES3;
WCDB_PROPERTY(CONTACTEXT_COL_INTRES2);
WCDB_PROPERTY(CONTACTEXT_COL_INTRES3);
WCDB_PROPERTY(CONTACTEXT_COL_STRRES3);
@end

@implementation DBContactExt

WCDB_IMPLEMENTATION(DBContactExt)
WCDB_SYNTHESIZE_COLUMN(userName, WCDB_STRINGIFY(CONTACTEXT_COL_USR_NAME))
WCDB_SYNTHESIZE_COLUMN(type, WCDB_STRINGIFY(CONTACTEXT_COL_TYPE))
WCDB_SYNTHESIZE_COLUMN(remark, WCDB_STRINGIFY(CONTACTEXT_COL_REMARK))
WCDB_SYNTHESIZE_COLUMN(remarkShortPinYin, WCDB_STRINGIFY(CONTACTEXT_COL_REMARK_PYSHORT))
WCDB_SYNTHESIZE_COLUMN(remarkFullPinYin, WCDB_STRINGIFY(CONTACTEXT_COL_REMARK_PYFULL))
WCDB_SYNTHESIZE_COLUMN(QQMBlog, WCDB_STRINGIFY(CONTACTEXT_COL_QQMBLOG))
WCDB_SYNTHESIZE_COLUMN(SMBlog, WCDB_STRINGIFY(CONTACTEXT_COL_SMBLOG))
WCDB_SYNTHESIZE_COLUMN(chatRoomMember, WCDB_STRINGIFY(CONTACTEXT_COL_CHATROOM_MEM))
WCDB_SYNTHESIZE_COLUMN(chatStatus, WCDB_STRINGIFY(CONTACTEXT_COL_CHAT_STATUS))
WCDB_SYNTHESIZE(CONTACTEXT_COL_INTRES2)
WCDB_SYNTHESIZE(CONTACTEXT_COL_INTRES3)
WCDB_SYNTHESIZE_COLUMN(domainList, WCDB_STRINGIFY(CONTACTEXT_COL_DOMAINLIST))
WCDB_SYNTHESIZE_COLUMN(extent, WCDB_STRINGIFY(CONTACTEXT_COL_STRRES2))
WCDB_SYNTHESIZE(CONTACTEXT_COL_STRRES3)

WCDB_NOT_NULL(userName)
WCDB_PRIMARY(userName)

WCDB_DEFAULT(CONTACTEXT_COL_INTRES2, 0)
WCDB_DEFAULT(CONTACTEXT_COL_INTRES3, 0)
WCDB_DEFAULT(type, 0)
WCDB_DEFAULT(chatStatus, 0)

@end

#pragma mark - DBContactMeta

@interface DBContactMeta ()
@property (nonatomic, assign) UInt32 intCon2;
@property (nonatomic, assign) UInt32 intCon3;
@property (nonatomic, retain) NSString* strCon1;
@property (nonatomic, retain) NSString* strCon2;
@property (nonatomic, retain) NSString* strCon3;
WCDB_PROPERTY(intCon2)
WCDB_PROPERTY(intCon3)
WCDB_PROPERTY(strCon1)
WCDB_PROPERTY(strCon2)
WCDB_PROPERTY(strCon3)
@end

@implementation DBContactMeta

WCDB_IMPLEMENTATION(DBContactMeta)
WCDB_SYNTHESIZE(username)
WCDB_SYNTHESIZE(lastUpdate)
WCDB_SYNTHESIZE_COLUMN(flag, WCDB_STRINGIFY(intCon1))
WCDB_SYNTHESIZE(intCon2)
WCDB_SYNTHESIZE(intCon3)
WCDB_SYNTHESIZE(strCon1)
WCDB_SYNTHESIZE(strCon2)
WCDB_SYNTHESIZE(strCon3)

WCDB_PRIMARY(username)

@end

#pragma mark -
#pragma mark # Message #
#pragma mark -

#pragma mark - Message

#define CHAT_VERSION 1

#define MSG_COL_VERSION TableVer
#define MSG_COL_MES_LOCAL_ID MesLocalID
#define MSG_COL_MES_SVR_ID MesSvrID
#define MSG_COL_CREATE_TIME CreateTime
#define MSG_COL_MESSAGE Message
#define MSG_COL_STATUS Status
#define MSG_COL_IMG_STATUS ImgStatus
#define MSG_COL_TYPE Type
#define MSG_COL_DES Des

@implementation DBMessage

WCDB_IMPLEMENTATION(DBMessage)
WCDB_SYNTHESIZE_COLUMN(version, WCDB_STRINGIFY(MSG_COL_VERSION))
WCDB_SYNTHESIZE_COLUMN(msgLocalId, WCDB_STRINGIFY(MSG_COL_MES_LOCAL_ID))
WCDB_SYNTHESIZE_COLUMN(msgServerId, WCDB_STRINGIFY(MSG_COL_MES_SVR_ID))
WCDB_SYNTHESIZE_COLUMN(createTime, WCDB_STRINGIFY(MSG_COL_CREATE_TIME))
WCDB_SYNTHESIZE_COLUMN(message, WCDB_STRINGIFY(MSG_COL_MESSAGE))
WCDB_SYNTHESIZE_COLUMN(status, WCDB_STRINGIFY(MSG_COL_STATUS))
WCDB_SYNTHESIZE_COLUMN(imageStatus, WCDB_STRINGIFY(MSG_COL_IMG_STATUS))
WCDB_SYNTHESIZE_COLUMN(type, WCDB_STRINGIFY(MSG_COL_TYPE))
WCDB_SYNTHESIZE_COLUMN(des, WCDB_STRINGIFY(MSG_COL_DES))

WCDB_PRIMARY_AUTO_INCREMENT(msgLocalId)
@synthesize lastInsertedRowID;
WCDB_INDEX("_Index", msgServerId)
WCDB_INDEX("_Index2", createTime)
WCDB_INDEX("_Index3", status)

WCDB_INDEX_FOR_NEWLY_CREATED_TABLE_ONLY("_index6")
WCDB_INDEX("_index6", status)
WCDB_INDEX("_index6", des)
WCDB_INDEX("_index6", type)
WCDB_INDEX("_index6", imageStatus)

WCDB_DEFAULT(version, CHAT_VERSION)
WCDB_DEFAULT(msgServerId, 0)
WCDB_DEFAULT(createTime, 0)
WCDB_DEFAULT(status, 0)
WCDB_DEFAULT(imageStatus, 0)

@end

@implementation DBMessageBlob

WCDB_IMPLEMENTATION(DBMessageBlob)
WCDB_SYNTHESIZE_COLUMN(version, WCDB_STRINGIFY(MSG_COL_VERSION))
WCDB_SYNTHESIZE_COLUMN(msgLocalId, WCDB_STRINGIFY(MSG_COL_MES_LOCAL_ID))
WCDB_SYNTHESIZE_COLUMN(msgServerId, WCDB_STRINGIFY(MSG_COL_MES_SVR_ID))
WCDB_SYNTHESIZE_COLUMN(createTime, WCDB_STRINGIFY(MSG_COL_CREATE_TIME))
WCDB_SYNTHESIZE_COLUMN(message, WCDB_STRINGIFY(MSG_COL_MESSAGE))
WCDB_SYNTHESIZE_COLUMN(status, WCDB_STRINGIFY(MSG_COL_STATUS))
WCDB_SYNTHESIZE_COLUMN(imageStatus, WCDB_STRINGIFY(MSG_COL_IMG_STATUS))
WCDB_SYNTHESIZE_COLUMN(type, WCDB_STRINGIFY(MSG_COL_TYPE))
WCDB_SYNTHESIZE_COLUMN(des, WCDB_STRINGIFY(MSG_COL_DES))

- (instancetype)initFromDBMessage:(DBMessage*)msg
{
    if (self = [super init]) {
        _version = msg.version;
        _msgLocalId = msg.msgLocalId;
        _msgServerId = msg.msgServerId;
        _createTime = msg.createTime;
        _status = msg.status;
        _imageStatus = msg.imageStatus;
        _type = msg.type;
        _des = msg.des;
    }
    return self;
}

WCDB_PRIMARY_AUTO_INCREMENT(msgLocalId)
@synthesize lastInsertedRowID;
WCDB_INDEX("_Index", msgServerId)
WCDB_INDEX("_Index2", createTime)
WCDB_INDEX("_Index3", status)

WCDB_INDEX_FOR_NEWLY_CREATED_TABLE_ONLY("_index6")
WCDB_INDEX("_index6", status)
WCDB_INDEX("_index6", des)
WCDB_INDEX("_index6", type)
WCDB_INDEX("_index6", imageStatus)

WCDB_DEFAULT(version, CHAT_VERSION)
WCDB_DEFAULT(msgServerId, 0)
WCDB_DEFAULT(createTime, 0)
WCDB_DEFAULT(status, 0)
WCDB_DEFAULT(imageStatus, 0)

@end

#pragma mark - DBMessageExt

#define MSG_EXT_COL_MES_LOCAL_ID MesLocalID
#define MSG_EXT_COL_MES_FLAG msgFlag
#define MSG_EXT_COL_INTRES1 ConIntRes1
#define MSG_EXT_COL_INTRES2 ConIntRes2
#define MSG_EXT_COL_INTRES3 ConIntRes3
#define MSG_EXT_COL_MSG_SOURCE MsgSource
#define MSG_EXT_COL_MSG_IDENTIFY MsgIdentify
#define MSG_EXT_COL_STRRES1 ConStrRes1
#define MSG_EXT_COL_STRRES2 ConStrRes2
#define MSG_EXT_COL_STRRES3 ConStrRes3

@interface DBMessageExt ()

@property (nonatomic, assign) UInt32 MSG_EXT_COL_INTRES1;
@property (nonatomic, assign) UInt32 MSG_EXT_COL_INTRES2;
@property (nonatomic, assign) UInt32 MSG_EXT_COL_INTRES3;
@property (nonatomic, retain) NSString* MSG_EXT_COL_STRRES1;
@property (nonatomic, retain) NSString* MSG_EXT_COL_STRRES2;
@property (nonatomic, retain) NSString* MSG_EXT_COL_STRRES3;

WCDB_PROPERTY(MSG_EXT_COL_INTRES1)
WCDB_PROPERTY(MSG_EXT_COL_INTRES2)
WCDB_PROPERTY(MSG_EXT_COL_INTRES3)
WCDB_PROPERTY(MSG_EXT_COL_STRRES1)
WCDB_PROPERTY(MSG_EXT_COL_STRRES2)
WCDB_PROPERTY(MSG_EXT_COL_STRRES3)
@end

@implementation DBMessageExt

WCDB_IMPLEMENTATION(DBMessageExt)
WCDB_SYNTHESIZE_COLUMN(msgLocalId, WCDB_STRINGIFY(MSG_EXT_COL_MES_LOCAL_ID))
WCDB_SYNTHESIZE(MSG_EXT_COL_MES_FLAG)
WCDB_SYNTHESIZE(MSG_EXT_COL_INTRES2)
WCDB_SYNTHESIZE(MSG_EXT_COL_INTRES3)
WCDB_SYNTHESIZE_COLUMN(msgSource, WCDB_STRINGIFY(MSG_EXT_COL_MSG_SOURCE))
WCDB_SYNTHESIZE_COLUMN(msgIdentify, WCDB_STRINGIFY(MSG_EXT_COL_MSG_IDENTIFY))
WCDB_SYNTHESIZE(MSG_EXT_COL_STRRES1)
WCDB_SYNTHESIZE(MSG_EXT_COL_STRRES2)
WCDB_SYNTHESIZE(MSG_EXT_COL_STRRES3)
WCDB_SYNTHESIZE(MSG_EXT_COL_INTRES1)

WCDB_PRIMARY(msgLocalId)
WCDB_INDEX("_Index", msgIdentify)

WCDB_DEFAULT(MSG_EXT_COL_MES_FLAG, 0)
WCDB_DEFAULT(MSG_EXT_COL_INTRES2, 0)
WCDB_DEFAULT(MSG_EXT_COL_INTRES3, 0)
WCDB_DEFAULT(MSG_EXT_COL_INTRES1, 0)

@end

@interface DBMessageExtBlob ()

@property (nonatomic, assign) UInt32 MSG_EXT_COL_INTRES1;
@property (nonatomic, assign) UInt32 MSG_EXT_COL_INTRES2;
@property (nonatomic, assign) UInt32 MSG_EXT_COL_INTRES3;
@property (nonatomic, retain) NSString* MSG_EXT_COL_STRRES1;
@property (nonatomic, retain) NSString* MSG_EXT_COL_STRRES2;
@property (nonatomic, retain) NSString* MSG_EXT_COL_STRRES3;

WCDB_PROPERTY(MSG_EXT_COL_INTRES1)
WCDB_PROPERTY(MSG_EXT_COL_INTRES2)
WCDB_PROPERTY(MSG_EXT_COL_INTRES3)
WCDB_PROPERTY(MSG_EXT_COL_STRRES1)
WCDB_PROPERTY(MSG_EXT_COL_STRRES2)
WCDB_PROPERTY(MSG_EXT_COL_STRRES3)
@end

@implementation DBMessageExtBlob

WCDB_IMPLEMENTATION(DBMessageExtBlob)
WCDB_SYNTHESIZE_COLUMN(msgLocalId, WCDB_STRINGIFY(MSG_EXT_COL_MES_LOCAL_ID))
WCDB_SYNTHESIZE(MSG_EXT_COL_MES_FLAG)
WCDB_SYNTHESIZE(MSG_EXT_COL_INTRES2)
WCDB_SYNTHESIZE(MSG_EXT_COL_INTRES3)
WCDB_SYNTHESIZE_COLUMN(msgSource, WCDB_STRINGIFY(MSG_EXT_COL_MSG_SOURCE))
WCDB_SYNTHESIZE_COLUMN(msgIdentify, WCDB_STRINGIFY(MSG_EXT_COL_MSG_IDENTIFY))
WCDB_SYNTHESIZE(MSG_EXT_COL_STRRES1)
WCDB_SYNTHESIZE(MSG_EXT_COL_STRRES2)
WCDB_SYNTHESIZE(MSG_EXT_COL_STRRES3)
WCDB_SYNTHESIZE(MSG_EXT_COL_INTRES1)

- (instancetype)initFromDBMessageExt:(DBMessageExt*)msg
{
    if (self = [super init]) {
        _msgLocalId = msg.msgLocalId;
        _msgIdentify = msg.msgIdentify;
        _msgFlag = msg.msgFlag;
    }
    return self;
}

WCDB_PRIMARY(msgLocalId)
WCDB_INDEX("_Index", msgIdentify)

WCDB_DEFAULT(MSG_EXT_COL_MES_FLAG, 0)
WCDB_DEFAULT(MSG_EXT_COL_INTRES2, 0)
WCDB_DEFAULT(MSG_EXT_COL_INTRES3, 0)
WCDB_DEFAULT(MSG_EXT_COL_INTRES1, 0)

@end

@interface DBMessageBizExt ()

@property (nonatomic, assign) UInt32 msgExtColInt1;
@property (nonatomic, assign) UInt32 msgExtColInt2;
@property (nonatomic, retain) NSString* msgExtColString1;
@property (nonatomic, retain) NSString* msgExtColString2;

WCDB_PROPERTY(msgExtColInt1)
WCDB_PROPERTY(msgExtColInt2)
WCDB_PROPERTY(msgExtColString1)
WCDB_PROPERTY(msgExtColString2)

@end

@implementation DBMessageBizExt

WCDB_IMPLEMENTATION(DBMessageBizExt)
WCDB_SYNTHESIZE(chatUsername)
WCDB_SYNTHESIZE(msgLocalId)
WCDB_SYNTHESIZE(msgType)
WCDB_SYNTHESIZE(msgInnerType)
WCDB_SYNTHESIZE(bizId)
WCDB_SYNTHESIZE(msgExtColInt1)
WCDB_SYNTHESIZE(msgExtColInt2)
WCDB_SYNTHESIZE(msgExtColString1)
WCDB_SYNTHESIZE(msgExtColString2)

@end

@interface DBMessageNewBizExt ()

@property (nonatomic, assign) UInt32 msgExtColInt1;
@property (nonatomic, assign) UInt32 msgExtColInt2;
@property (nonatomic, retain) NSString* msgExtColString1;
@property (nonatomic, retain) NSString* msgExtColString2;

WCDB_PROPERTY(msgExtColInt1)
WCDB_PROPERTY(msgExtColInt2)
WCDB_PROPERTY(msgExtColString1)
WCDB_PROPERTY(msgExtColString2)

@end

@implementation DBMessageNewBizExt

WCDB_IMPLEMENTATION(DBMessageNewBizExt)
WCDB_SYNTHESIZE(chatUsername)
WCDB_SYNTHESIZE(msgLocalId)
WCDB_SYNTHESIZE(msgType)
WCDB_SYNTHESIZE(msgInnerType)
WCDB_SYNTHESIZE(bizId)
WCDB_SYNTHESIZE(status)
WCDB_SYNTHESIZE(invalidTime)
WCDB_SYNTHESIZE(msgExtColInt1)
WCDB_SYNTHESIZE(msgExtColInt2)
WCDB_SYNTHESIZE(msgExtColString1)
WCDB_SYNTHESIZE(msgExtColString2)

WCDB_INDEX("_Index", chatUsername)
WCDB_INDEX("_Index", msgLocalId)

@end

#pragma mark - SendMessage

#define SEND_MES_VERSION 1

#define SENDMSG_COL_VERSION TableVer
#define SENDMSG_COL_USR_NAME UsrName
#define SENDMSG_COL_MES_LOCAL_ID MesLocalID
#define SENDMSG_COL_MES_SVR_ID MesSvrID
#define SENDMSG_COL_CREATE_TIME CreateTime
#define SENDMSG_COL_MESSAGE Message
#define SENDMSG_COL_STATUS Status
#define SENDMSG_COL_IMG_STATUS ImgStatus
#define SENDMSG_COL_TYPE Type
#define SENDMSG_COL_DES Des

/*
#pragma mark - DBDuplicateMsg

#define DUPLICATE_MSG_COL_MES_SVR_ID MesSvrID
#define DUPLICATE_MSG_COL_CREATE_TIME CreateTime
#define DUPLICATE_MSG_COL_INTRES1 ConIntRes1
#define DUPLICATE_MSG_COL_INTRES2 ConIntRes2
#define DUPLICATE_MSG_COL_INTRES3 ConIntRes3
#define DUPLICATE_MSG_COL_STRRES1 ConStrRes1
#define DUPLICATE_MSG_COL_STRRES2 ConStrRes2
#define DUPLICATE_MSG_COL_STRRES3 ConStrRes3

@interface DBDuplicateMsg ()
WCDB_PROPERTY(DUPLICATE_MSG_COL_INTRES1)
WCDB_PROPERTY(DUPLICATE_MSG_COL_INTRES2)
WCDB_PROPERTY(DUPLICATE_MSG_COL_INTRES3)
WCDB_PROPERTY(DUPLICATE_MSG_COL_STRRES1)
WCDB_PROPERTY(DUPLICATE_MSG_COL_STRRES2)
WCDB_PROPERTY(DUPLICATE_MSG_COL_STRRES3)
@end

@implementation DBDuplicateMsg

WCDB_IMPLEMENTATION(DBDuplicateMsg)
    WCDB_INT64_PROPERTY_EX(DBDuplicateMsg, NO, msgServerId, DUPLICATE_MSG_COL_MES_SVR_ID, 1)
WCDB_SYNTHESIZE_COLUMN(createTime, WCDB_STRINGIFY(DUPLICATE_MSG_COL_CREATE_TIME), 0)

WCDB_SYNTHESIZE(DUPLICATE_MSG_COL_INTRES1)
WCDB_SYNTHESIZE(DUPLICATE_MSG_COL_INTRES2)
WCDB_SYNTHESIZE(DUPLICATE_MSG_COL_INTRES3)
WCDB_SYNTHESIZE(DUPLICATE_MSG_COL_STRRES1)
WCDB_SYNTHESIZE(DUPLICATE_MSG_COL_STRRES2)
WCDB_SYNTHESIZE(DUPLICATE_MSG_COL_STRRES3)

WCDB_CREATE_PRIMARY_KEY_EX(DUPLICATE_MSG_COL_MES_SVR_ID, WCDB_ORDER_NOTSET, false, false)
WCDB_CREATE_INDEX_EX(DUPLICATE_MSG_COL_CREATE_TIME, WCDB_ORDER_NOTSET, DuplicateMsgTable_Index)
 
WCDB_DEFAULT(DUPLICATE_MSG_COL_INTRES1, 0)
WCDB_DEFAULT(DUPLICATE_MSG_COL_INTRES2, 0)
WCDB_DEFAULT(DUPLICATE_MSG_COL_INTRES3, 0)

@end
*/

#pragma mark - Hello

#define HELLO_VERSION 1

#define HELLO_COL_VERSION TableVer
#define HELLO_COL_MES_LOCAL_ID MesLocalID
#define HELLO_COL_MES_SVR_ID MesSvrID
#define HELLO_COL_CREATE_TIME CreateTime
#define HELLO_COL_MESSAGE Message
#define HELLO_COL_STATUS Status
#define HELLO_COL_IMG_STATUS ImgStatus
#define HELLO_COL_TYPE Type
#define HELLO_COL_DES Des
#define HELLO_COL_USR_NAME UsrName
#define HELLO_COL_OPCODE OpCode
#define HELLO_COL_INTRES1 ConIntRes1
#define HELLO_COL_INTRES2 ConIntRes2
#define HELLO_COL_INTRES3 ConIntRes3
#define HELLO_COL_STRRES1 ConStrRes1
#define HELLO_COL_STRRES2 ConStrRes2
#define HELLO_COL_STRRES3 ConStrRes3

@interface DBHello ()

@property (nonatomic, assign) UInt32 HELLO_COL_INTRES2;
@property (nonatomic, assign) UInt32 HELLO_COL_INTRES3;
@property (nonatomic, retain) NSString* HELLO_COL_STRRES1;
@property (nonatomic, retain) NSString* HELLO_COL_STRRES2;
@property (nonatomic, retain) NSString* HELLO_COL_STRRES3;

WCDB_PROPERTY(HELLO_COL_INTRES2)
WCDB_PROPERTY(HELLO_COL_INTRES3)
WCDB_PROPERTY(HELLO_COL_STRRES1)
WCDB_PROPERTY(HELLO_COL_STRRES2)
WCDB_PROPERTY(HELLO_COL_STRRES3)
@end

@implementation DBHello

WCDB_IMPLEMENTATION(DBHello)
WCDB_SYNTHESIZE_COLUMN(version, WCDB_STRINGIFY(HELLO_COL_VERSION))
WCDB_SYNTHESIZE_COLUMN(msgLocalId, WCDB_STRINGIFY(HELLO_COL_MES_LOCAL_ID))
WCDB_SYNTHESIZE_COLUMN(msgServerId, WCDB_STRINGIFY(HELLO_COL_MES_SVR_ID))
WCDB_SYNTHESIZE_COLUMN(createTime, WCDB_STRINGIFY(HELLO_COL_CREATE_TIME))
WCDB_SYNTHESIZE_COLUMN(message, WCDB_STRINGIFY(HELLO_COL_MESSAGE))
WCDB_SYNTHESIZE_COLUMN(status, WCDB_STRINGIFY(HELLO_COL_STATUS))
WCDB_SYNTHESIZE_COLUMN(imageStatus, WCDB_STRINGIFY(HELLO_COL_IMG_STATUS))
WCDB_SYNTHESIZE_COLUMN(type, WCDB_STRINGIFY(HELLO_COL_TYPE))
WCDB_SYNTHESIZE_COLUMN(des, WCDB_STRINGIFY(HELLO_COL_DES))
WCDB_SYNTHESIZE_COLUMN(userName, WCDB_STRINGIFY(HELLO_COL_USR_NAME))
WCDB_SYNTHESIZE_COLUMN(opCode, WCDB_STRINGIFY(HELLO_COL_OPCODE))

WCDB_SYNTHESIZE_COLUMN(sayHelloStatus, WCDB_STRINGIFY(HELLO_COL_INTRES1))
WCDB_SYNTHESIZE(HELLO_COL_INTRES2)
WCDB_SYNTHESIZE(HELLO_COL_INTRES3)
WCDB_SYNTHESIZE(HELLO_COL_STRRES1)
WCDB_SYNTHESIZE(HELLO_COL_STRRES2)
WCDB_SYNTHESIZE(HELLO_COL_STRRES3)

WCDB_PRIMARY_AUTO_INCREMENT(msgLocalId)
@synthesize lastInsertedRowID;
WCDB_INDEX("_Index2", createTime)
WCDB_INDEX("_Index3", status)
WCDB_INDEX("_Index4", userName)

WCDB_DEFAULT(version, HELLO_VERSION)
WCDB_DEFAULT(msgServerId, 0)
WCDB_DEFAULT(createTime, 0)
WCDB_DEFAULT(status, 0)
WCDB_DEFAULT(imageStatus, 0)
WCDB_DEFAULT(opCode, 0)
WCDB_DEFAULT(sayHelloStatus, 0)
WCDB_DEFAULT(HELLO_COL_INTRES2, 0)
WCDB_DEFAULT(HELLO_COL_INTRES3, 0)

@end

#pragma mark -
#pragma mark # Emoticon #
#pragma mark -

#pragma mark - Emoticon

#define EMOTICON_COL_MD5 MD5
#define EMOTICON_COL_MESSAGE Message
#define EMOTICON_COL_TYPE Type
#define EMOTICON_COL_CREATE_TIME CreateTime
#define EMOTICON_COL_LEN Len
#define EMOTICON_COL_STATUS Status
#define EMOTICON_COL_CATALOG Catalog
#define EMOTICON_COL_CATALOG_ID CatelogID
#define EMOTICON_COL_DRAFT Draft
#define EMOTICON_COL_INTRES1 ConIntRes1
#define EMOTICON_COL_INTRES2 ConIntRes2
#define EMOTICON_COL_INTRES3 ConIntRes3
#define EMOTICON_COL_STRRES1 ConStrRes1
#define EMOTICON_COL_STRRES2 ConStrRes2
#define EMOTICON_COL_STRRES3 ConStrRes3

@interface DBEmoticon ()

@property (nonatomic, retain) NSString* EMOTICON_COL_STRRES3;

WCDB_PROPERTY(EMOTICON_COL_STRRES3);
@end

@implementation DBEmoticon

WCDB_IMPLEMENTATION(DBEmoticon)
WCDB_SYNTHESIZE_COLUMN(md5, WCDB_STRINGIFY(EMOTICON_COL_MD5))
WCDB_SYNTHESIZE_COLUMN(message, WCDB_STRINGIFY(EMOTICON_COL_MESSAGE))
WCDB_SYNTHESIZE_COLUMN(type, WCDB_STRINGIFY(EMOTICON_COL_TYPE))
WCDB_SYNTHESIZE_COLUMN(createTime, WCDB_STRINGIFY(EMOTICON_COL_CREATE_TIME))
WCDB_SYNTHESIZE_COLUMN(length, WCDB_STRINGIFY(EMOTICON_COL_LEN))
WCDB_SYNTHESIZE_COLUMN(status, WCDB_STRINGIFY(EMOTICON_COL_STATUS))
WCDB_SYNTHESIZE_COLUMN(catalog, WCDB_STRINGIFY(EMOTICON_COL_CATALOG))
WCDB_SYNTHESIZE_COLUMN(catalogId, WCDB_STRINGIFY(EMOTICON_COL_CATALOG_ID))
WCDB_SYNTHESIZE_COLUMN(draft, WCDB_STRINGIFY(EMOTICON_COL_DRAFT))

WCDB_SYNTHESIZE_COLUMN(lastUsedTime, WCDB_STRINGIFY(EMOTICON_COL_INTRES1))
WCDB_SYNTHESIZE_COLUMN(extFlag, WCDB_STRINGIFY(EMOTICON_COL_INTRES2))
WCDB_SYNTHESIZE_COLUMN(indexInPack, WCDB_STRINGIFY(EMOTICON_COL_INTRES3))
WCDB_SYNTHESIZE_COLUMN(extInfo, WCDB_STRINGIFY(EMOTICON_COL_STRRES1))
WCDB_SYNTHESIZE_COLUMN(packageId, WCDB_STRINGIFY(EMOTICON_COL_STRRES2))
WCDB_SYNTHESIZE(EMOTICON_COL_STRRES3)

WCDB_DEFAULT(type, 0)
WCDB_DEFAULT(createTime, 0)
WCDB_DEFAULT(length, 0)
WCDB_DEFAULT(status, 0)
WCDB_DEFAULT(catalogId, 0)
WCDB_DEFAULT(lastUsedTime, 0)
WCDB_DEFAULT(extFlag, 0)
WCDB_DEFAULT(indexInPack, 0)

WCDB_INDEX("_Index", packageId)

@end

#pragma mark - EmoticonUpload

#define EMOTICON_UPLOAD_COL_USR_NAME UsrName
#define EMOTICON_UPLOAD_COL_MES_LOCAL_ID MesLocalID
#define EMOTICON_UPLOAD_COL_MD5 MD5
#define EMOTICON_UPLOAD_COL_TYPE Type
#define EMOTICON_UPLOAD_COL_MESSAGE Message
#define EMOTICON_UPLOAD_COL_CREATE_TIME CreateTime
#define EMOTICON_UPLOAD_COL_SEND_TIME SendTime
#define EMOTICON_UPLOAD_COL_OFFSET Offset
#define EMOTICON_UPLOAD_COL_LEN Len
#define EMOTICON_UPLOAD_COL_STATUS Status
#define EMOTICON_UPLOAD_COL_CATALOG Catalog
#define EMOTICON_UPLOAD_COL_CATALOG_ID CatelogID
#define EMOTICON_UPLOAD_COL_DRAFT Draft
#define EMOTICON_UPLOAD_COL_INTRES1 ConIntRes1
#define EMOTICON_UPLOAD_COL_INTRES2 ConIntRes2
#define EMOTICON_UPLOAD_COL_INTRES3 ConIntRes3
#define EMOTICON_UPLOAD_COL_STRRES1 ConStrRes1
#define EMOTICON_UPLOAD_COL_STRRES2 ConStrRes2
#define EMOTICON_UPLOAD_COL_STRRES3 ConStrRes3

#pragma mark -
#pragma mark # Bottle #
#pragma mark -

#pragma mark - Bottle

#define BOTTLE_COL_LOCAL_ID BottleLocalID
#define BOTTLE_COL_SVR_ID BottleSvrID
#define BOTTLE_COL_ENCRYPT_USRNAME BottleEncryptUsrName
#define BOTTLE_COL_BOTTLEID BottleID
#define BOTTLE_COL_EXT BottleExt

@implementation DBBottle

WCDB_IMPLEMENTATION(DBBottle)
WCDB_SYNTHESIZE_COLUMN(localId, WCDB_STRINGIFY(BOTTLE_COL_LOCAL_ID))
WCDB_SYNTHESIZE_COLUMN(serverId, WCDB_STRINGIFY(BOTTLE_COL_SVR_ID))
WCDB_SYNTHESIZE_COLUMN(encryptUserName, WCDB_STRINGIFY(BOTTLE_COL_ENCRYPT_USRNAME))
WCDB_SYNTHESIZE_COLUMN(bottleId, WCDB_STRINGIFY(BOTTLE_COL_BOTTLEID))
WCDB_SYNTHESIZE_COLUMN(ext, WCDB_STRINGIFY(BOTTLE_COL_EXT))

WCDB_PRIMARY_AUTO_INCREMENT(localId)
@synthesize lastInsertedRowID;

WCDB_DEFAULT(serverId, 0)

@end

#pragma mark - BottleContact

#define BOTTLE_CONTACT_COL_USRNAME BottleContactUsrName
#define BOTTLE_CONTACT_COL_NICKNAME BottleContactNickName
#define BOTTLE_CONTACT_COL_SEX BottleContactSex
#define BOTTLE_CONTACT_COL_IMGSTATUS BottleContactImgStatus
#define BOTTLE_CONTACT_COL_HD_IMGSTATUS BottleContactHDImgStatus
#define BOTTLE_CONTACT_COL_PROVINCE BottleContactProvince
#define BOTTLE_CONTACT_COL_CITY BottleContactCity
#define BOTTLE_CONTACT_COL_SIGN BottleContactSign
#define BOTTLE_CONTACT_COL_IMGKEY BottleContactImgKey
#define BOTTLE_CONTACT_COL_IMGKEY_LAST BottleContactImgKeyLast
#define BOTTLE_CONTACT_COL_EXTKEY BottleContactExtKey
#define BOTTLE_CONTACT_COL_EXTKEY_LAST BottleContactExtKeyLast
#define BOTTLE_CONTACT_COL_INTRES1 BottleContactINTRES1
#define BOTTLE_CONTACT_COL_INTRES2 BottleContactINTRES2
#define BOTTLE_CONTACT_COL_INTRES3 BottleContactINTRES3
#define BOTTLE_CONTACT_COL_TEXTRES1 BottleContactTEXTRES1
#define BOTTLE_CONTACT_COL_TEXTRES2 BottleContactTEXTRES2
#define BOTTLE_CONTACT_COL_TEXTRES3 BottleContactTEXTRES3

@interface DBBottleContact ()

@property (nonatomic, assign) UInt32 BOTTLE_CONTACT_COL_INTRES1;
@property (nonatomic, assign) UInt32 BOTTLE_CONTACT_COL_INTRES2;
@property (nonatomic, assign) UInt32 BOTTLE_CONTACT_COL_INTRES3;
@property (nonatomic, retain) NSString* BOTTLE_CONTACT_COL_TEXTRES2;
@property (nonatomic, retain) NSString* BOTTLE_CONTACT_COL_TEXTRES3;

WCDB_PROPERTY(BOTTLE_CONTACT_COL_INTRES1)
WCDB_PROPERTY(BOTTLE_CONTACT_COL_INTRES2)
WCDB_PROPERTY(BOTTLE_CONTACT_COL_INTRES3)

WCDB_PROPERTY(BOTTLE_CONTACT_COL_TEXTRES2)
WCDB_PROPERTY(BOTTLE_CONTACT_COL_TEXTRES3)
@end

@implementation DBBottleContact

WCDB_IMPLEMENTATION(DBBottleContact)
WCDB_SYNTHESIZE_COLUMN(userName, WCDB_STRINGIFY(BOTTLE_CONTACT_COL_USRNAME))
WCDB_SYNTHESIZE_COLUMN(nickName, WCDB_STRINGIFY(BOTTLE_CONTACT_COL_NICKNAME))
WCDB_SYNTHESIZE_COLUMN(sex, WCDB_STRINGIFY(BOTTLE_CONTACT_COL_SEX))
WCDB_SYNTHESIZE_COLUMN(imageStatus, WCDB_STRINGIFY(BOTTLE_CONTACT_COL_IMGSTATUS))
WCDB_SYNTHESIZE_COLUMN(hdImageStatus, WCDB_STRINGIFY(BOTTLE_CONTACT_COL_HD_IMGSTATUS))
WCDB_SYNTHESIZE_COLUMN(province, WCDB_STRINGIFY(BOTTLE_CONTACT_COL_PROVINCE))
WCDB_SYNTHESIZE_COLUMN(city, WCDB_STRINGIFY(BOTTLE_CONTACT_COL_CITY))
WCDB_SYNTHESIZE_COLUMN(sign, WCDB_STRINGIFY(BOTTLE_CONTACT_COL_SIGN))
WCDB_SYNTHESIZE_COLUMN(imageKey, WCDB_STRINGIFY(BOTTLE_CONTACT_COL_IMGKEY))
WCDB_SYNTHESIZE_COLUMN(imageKeyLast, WCDB_STRINGIFY(BOTTLE_CONTACT_COL_IMGKEY_LAST))
WCDB_SYNTHESIZE_COLUMN(extKey, WCDB_STRINGIFY(BOTTLE_CONTACT_COL_EXTKEY))
WCDB_SYNTHESIZE_COLUMN(extKeyLast, WCDB_STRINGIFY(BOTTLE_CONTACT_COL_EXTKEY_LAST))

WCDB_SYNTHESIZE(BOTTLE_CONTACT_COL_INTRES1)
WCDB_SYNTHESIZE(BOTTLE_CONTACT_COL_INTRES2)
WCDB_SYNTHESIZE(BOTTLE_CONTACT_COL_INTRES3)
WCDB_SYNTHESIZE_COLUMN(ext, WCDB_STRINGIFY(BOTTLE_CONTACT_COL_TEXTRES1))
WCDB_SYNTHESIZE(BOTTLE_CONTACT_COL_TEXTRES2)
WCDB_SYNTHESIZE(BOTTLE_CONTACT_COL_TEXTRES3)

WCDB_NOT_NULL(userName)

WCDB_DEFAULT(sex, 0)
WCDB_DEFAULT(imageKey, 0)
WCDB_DEFAULT(imageKeyLast, 0)
WCDB_DEFAULT(extKey, 0)
WCDB_DEFAULT(extKeyLast, 0)
WCDB_DEFAULT(BOTTLE_CONTACT_COL_INTRES1, 0)
WCDB_DEFAULT(BOTTLE_CONTACT_COL_INTRES2, 0)
WCDB_DEFAULT(BOTTLE_CONTACT_COL_INTRES3, 0)

+ (void)additionalObjectRelationalMapping:(WCTBinding&)binding
{
    WCDB::ColumnConstraint columnConstraint = WCDB::ColumnConstraint().primaryKey().conflict(WCDB::Conflict::Replace);
    binding.getColumnDef(self.userName)->constraint(columnConstraint);
}

@end
