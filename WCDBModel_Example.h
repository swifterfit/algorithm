//
//  WCDBModel_Example.h
//  WCDB 模型示例
//
//  正确的头文件引入和模型定义示例
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject <WCTTableCoding>

@property (nonatomic, assign) long long userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSDate *createTime;

@end

@interface MessageModel : NSObject <WCTTableCoding>

@property (nonatomic, assign) long long messageId;
@property (nonatomic, assign) long long senderId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger messageType;
@property (nonatomic, strong) NSDate *sendTime;

@end

NS_ASSUME_NONNULL_END