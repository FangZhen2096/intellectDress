//
//  UserManagerAjax.h
//  IntellectDress
//
//  Created by zerom on 16/10/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManagerAjax : NSObject
+ (void)UserListWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+ (void)UserBaseInfoWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+ (void)UserManagerDetailsInfoWithUserid:(NSString *)userid Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;
+ (void)DelUserWithDelId:(NSString *)delId Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+ (void)AddUserWithIds:(NSString *)ids typeid:(NSString *)typeId userTel:(NSString *)userTel Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;
@end
