//
//  WCDBModel_Example.mm
//  WCDB 模型实现示例
//
//  注意：文件扩展名必须是 .mm（Objective-C++）
//

#import "WCDBModel_Example.h"

@implementation UserModel

// WCDB 宏定义
WCDB_IMPLEMENTATION(UserModel)

// 属性绑定
WCDB_SYNTHESIZE(UserModel, userId)
WCDB_SYNTHESIZE(UserModel, userName)
WCDB_SYNTHESIZE(UserModel, email)
WCDB_SYNTHESIZE(UserModel, age)
WCDB_SYNTHESIZE(UserModel, createTime)

// 主键定义
WCDB_PRIMARY(UserModel, userId)

// 索引定义（可选）
WCDB_INDEX(UserModel, "_index_userName", userName)

// 表约束（可选）
WCDB_UNIQUE(UserModel, email)

@end

@implementation MessageModel

// WCDB 宏定义
WCDB_IMPLEMENTATION(MessageModel)

// 属性绑定
WCDB_SYNTHESIZE(MessageModel, messageId)
WCDB_SYNTHESIZE(MessageModel, senderId)
WCDB_SYNTHESIZE(MessageModel, content)
WCDB_SYNTHESIZE(MessageModel, messageType)
WCDB_SYNTHESIZE(MessageModel, sendTime)

// 主键定义
WCDB_PRIMARY(MessageModel, messageId)

// 索引定义
WCDB_INDEX(MessageModel, "_index_senderId", senderId)
WCDB_INDEX(MessageModel, "_index_sendTime", sendTime)

@end