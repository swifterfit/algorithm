//
//  WCDBManager_Example.mm
//  WCDB 数据库管理器实现示例
//
//  注意：文件扩展名必须是 .mm（Objective-C++）
//

#import "WCDBManager_Example.h"

// 表名常量
static NSString * const kTableNameUser = @"user_table";
static NSString * const kTableNameMessage = @"message_table";

@interface WCDBManager ()
@property (nonatomic, strong) WCTDatabase *database;
@end

@implementation WCDBManager

+ (instancetype)sharedManager {
    static WCDBManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WCDBManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupDatabase];
    }
    return self;
}

#pragma mark - Database Setup

- (BOOL)setupDatabase {
    // 获取数据库路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"app_database.db"];
    
    // 初始化数据库
    self.database = [[WCTDatabase alloc] initWithPath:dbPath];
    
    if (!self.database) {
        NSLog(@"Failed to initialize database");
        return NO;
    }
    
    // 创建表
    BOOL success = YES;
    success &= [self.database createTableAndIndexesOfName:kTableNameUser withClass:UserModel.class];
    success &= [self.database createTableAndIndexesOfName:kTableNameMessage withClass:MessageModel.class];
    
    if (!success) {
        NSLog(@"Failed to create tables");
        return NO;
    }
    
    NSLog(@"Database setup completed successfully at path: %@", dbPath);
    return YES;
}

#pragma mark - User Operations

- (BOOL)insertUser:(UserModel *)user {
    if (!user || !self.database) {
        return NO;
    }
    
    return [self.database insertObject:user into:kTableNameUser];
}

- (BOOL)updateUser:(UserModel *)user {
    if (!user || !self.database) {
        return NO;
    }
    
    return [self.database updateRowsInTable:kTableNameUser
                                 onProperty:UserModel.AllProperties
                                 withObject:user
                                      where:UserModel.userId == user.userId];
}

- (BOOL)deleteUserWithId:(long long)userId {
    if (!self.database) {
        return NO;
    }
    
    return [self.database deleteFromTable:kTableNameUser
                                    where:UserModel.userId == userId];
}

- (UserModel *)getUserWithId:(long long)userId {
    if (!self.database) {
        return nil;
    }
    
    return [self.database getObjectOfClass:UserModel.class
                                 fromTable:kTableNameUser
                                     where:UserModel.userId == userId];
}

- (NSArray<UserModel *> *)getAllUsers {
    if (!self.database) {
        return @[];
    }
    
    return [self.database getObjectsOfClass:UserModel.class
                                  fromTable:kTableNameUser
                                   orderBy:UserModel.createTime.order(WCTOrderedDescending)];
}

#pragma mark - Message Operations

- (BOOL)insertMessage:(MessageModel *)message {
    if (!message || !self.database) {
        return NO;
    }
    
    return [self.database insertObject:message into:kTableNameMessage];
}

- (NSArray<MessageModel *> *)getMessagesForSender:(long long)senderId {
    if (!self.database) {
        return @[];
    }
    
    return [self.database getObjectsOfClass:MessageModel.class
                                  fromTable:kTableNameMessage
                                      where:MessageModel.senderId == senderId
                                   orderBy:MessageModel.sendTime.order(WCTOrderedDescending)];
}

- (NSArray<MessageModel *> *)getRecentMessages:(NSInteger)limit {
    if (!self.database) {
        return @[];
    }
    
    return [self.database getObjectsOfClass:MessageModel.class
                                  fromTable:kTableNameMessage
                                   orderBy:MessageModel.sendTime.order(WCTOrderedDescending)
                                     limit:limit];
}

#pragma mark - Database Maintenance

- (void)closeDatabase {
    if (self.database) {
        [self.database close];
        self.database = nil;
    }
}

- (BOOL)isDatabaseCorrupted {
    if (!self.database) {
        return YES;
    }
    
    return [self.database isCorrupted];
}

- (void)dealloc {
    [self closeDatabase];
}

@end