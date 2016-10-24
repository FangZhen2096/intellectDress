//
//  UserBiz.h
//  clothesnews
//
//  Created by 小强 on 16/5/16.
//  Copyright © 2016年 persona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserBiz : NSObject
+(void)setUserInfo:(NSDictionary*)dic;
+(NSDictionary*)userInfo;
+(BOOL)logined;
+(void)setLogined:(BOOL)logined;
+(void)goLogin;
+(NSString*)userId;
+ (NSString *)cityId;
+ (NSString *)shopId;
+(NSString *)token;
-(void)send:(NSString*)mobile callback:(CallBack) callback;
-(void)reg:(NSString*)code name:(NSString*)name pwd:(NSString*)pwd repwd:(NSString*)repwd  user:(NSString*)user callback:(CallBack) callback;
-(void)login:(NSString*)pwd user:(NSString*)user callback:(CallBack) callback;
-(void)editInfo:(NSString*)email nickname:(NSString*)nickname sex:(NSString*)sex callback:(CallBack) callback;
-(void)repwd:(NSString*)pwd repwd:(NSString*)repwd user:(NSString*)user  token:(NSString*)token userid:(NSString*)userid callback:(CallBack)callback;
-(void)upavatar:(UIImage*)image userid:(NSString*)userid callback:(CallBack) callback;
-(void)editpwd:(NSString*)pwd repwd:(NSString*)repwd oldpwd:(NSString*)oldpwd callback:(CallBack) callback;
-(void)verify:(NSString*)code user:(NSString*)user callback:(CallBack) callback;
-(void)base:(NSString*) userid callback:(CallBack)callback;
-(void)feedback:(NSString*)userid info:(NSString*)info callback:(CallBack)callback;
@end
