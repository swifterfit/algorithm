//
//  WCDBManager_Example.h
//  WCDB 数据库管理器示例
//
//  展示如何正确使用 WCDB 进行数据库操作
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>
#import "WCDBModel_Example.h"

NS_ASSUME_NONNULL_BEGIN

@interface WCDBManager : NSObject

+ (instancetype)sharedManager;

// 数据库初始化
- (BOOL)setupDatabase;

// 用户相关操作
- (BOOL)insertUser:(UserModel *)user;
- (BOOL)updateUser:(UserModel *)user;
- (BOOL)deleteUserWithId:(long long)userId;
- (UserModel * _Nullable)getUserWithId:(long long)userId;
- (NSArray<UserModel *> *)getAllUsers;

// 消息相关操作
- (BOOL)insertMessage:(MessageModel *)message;
- (NSArray<MessageModel *> *)getMessagesForSender:(long long)senderId;
- (NSArray<MessageModel *> *)getRecentMessages:(NSInteger)limit;

// 数据库维护
- (void)closeDatabase;
- (BOOL)isDatabaseCorrupted;

@end

NS_ASSUME_NONNULL_END