//
//  UserBiz.m
//  clothesnews
//
//  Created by 小强 on 16/5/16.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "UserBiz.h"
#import "AppAjax.h"
@interface UserBiz()
@property (nonatomic) AppAjax*ajax;
@end
@implementation UserBiz
-(instancetype)init{
    self = [super init];
    if (self) {
        _ajax = [[AppAjax alloc] init];
    }
    return  self;
}
+(NSString*)userId{
    if (![UserBiz logined]) {
        return @"";
    }
    NSDictionary*userInfo= [UserBiz userInfo];
    NSDictionary*results =userInfo[@"results"];
    return  FORMAT(@"%@",results[@"userid"]);
}
+ (NSString *)cityId
{
    if (![UserBiz logined]) {
        return @"";
    }
    NSDictionary *userInfo = [UserBiz userInfo];
    NSDictionary*results =userInfo[@"results"];
    return  FORMAT(@"%@",results[@"cityid"]);
}

+ (NSString *)shopId{
    if (![UserBiz logined]) {
        return @"";
    }
    NSDictionary *userInfo = [UserBiz userInfo];
    NSDictionary*results =userInfo[@"results"];
    return  FORMAT(@"%@",results[@"shopid"]);
}

+(NSString *)token{
    if (![UserBiz logined]) {
        return @"";
    }
    NSDictionary *userInfo = [UserBiz userInfo];
    NSString*token =userInfo[@"token"];
    return  token;
}
+(void)setUserInfo:(NSDictionary*)dic{
    [Config_ set:@"userInfo" value:[dic toString]];
}
+(NSDictionary*)userInfo{
    NSString*userInfo =[Config_ get:@"userInfo"];
    return [userInfo toDictionary];
}
+(BOOL)logined{
    return   [[Config_ get:@"logined"] boolValue];
}
+(void)setLogined:(BOOL)logined{
    [Config_ set:@"logined" value:@(logined)];
}
+(void)goLogin{
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"ZRInfomationViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
    UIViewController*root =[UIApplication sharedApplication].keyWindow.rootViewController;
    [root presentViewController:controller animated:YES completion:nil];
}
-(void)send:(NSString*)mobile callback:(CallBack) callback{
    [_ajax dicWithUrl:@"sms/send" params:@{@"mobile":mobile} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:YES];
}
-(void)reg:(NSString*)code name:(NSString*)name pwd:(NSString*)pwd repwd:(NSString*)repwd  user:(NSString*)user callback:(CallBack) callback{
    [_ajax dicWithUrl:@"user/reg" params:@{@"code":code,@"name":name,@"pwd":pwd,@"repwd":repwd,@"source":@"客户端",@"user":user} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:YES];
}
-(void)login:(NSString*)pwd user:(NSString*)user callback:(CallBack) callback{
    [_ajax dicWithUrl:@"user/login" params:@{@"pwd":pwd,@"user":user} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:YES];
}
-(void)editInfo:(NSString*)email nickname:(NSString*)nickname sex:(NSString*)sex callback:(CallBack) callback{
    NSDictionary*userInfo = [UserBiz userInfo];
    NSString*token=FORMAT(@"%@",userInfo[@"token"]);
    [_ajax dicWithUrl:FORMAT(@"user/editInfo?token=%@&userid=%@",token,[UserBiz userId]) params:@{@"email":email,@"nickname":nickname,@"sex":sex} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:YES];
}

-(void)repwd:(NSString*)pwd repwd:(NSString*)repwd user:(NSString*)user  token:(NSString*)token userid:(NSString*)userid callback:(CallBack)callback{
    [_ajax dicWithUrl:FORMAT(@"user/repwd?token=%@&userid=%@",token,userid) params:@{@"pwd":pwd,@"repwd":repwd,@"user":user} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:YES];
}
-(void)upavatar:(UIImage*)image userid:(NSString*)userid callback:(CallBack) callback{
    NSDictionary*userInfo = [UserBiz userInfo];
    NSString*token=FORMAT(@"%@",userInfo[@"token"]);
    [_ajax uploadImages:FORMAT(@"user/upavatar?token=%@&userid=%@",token,userid) images:@[image] params:@{@"userid":userid} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    }];
}
//-(void)upavatar:(NSString*)avatar userid:(NSString*)userid callback:(CallBack) callback{
//    NSDictionary*userInfo = [UserBiz userInfo];
//    NSString*token=FORMAT(@"%@",userInfo[@"token"]);
//    [_ajax dicWithUrl:FORMAT(@"user/upavatar?token=%@&userid=%@",token,userid) params:@{@"avatar":avatar,@"userid":userid} callback:^(BOOL isError, NSDictionary *json) {
//        callback(isError,json);
//    } post:YES];
//}
-(void)editpwd:(NSString*)pwd repwd:(NSString*)repwd oldpwd:(NSString*)oldpwd callback:(CallBack) callback{
    NSDictionary*userInfo = [UserBiz userInfo];
    NSString*token=FORMAT(@"%@",userInfo[@"token"]);
    [_ajax dicWithUrl:FORMAT(@"user/editpwd?token=%@&userid=%@",token,[UserBiz userId]) params:@{@"pwd":pwd,@"repwd":repwd,@"oldpwd":oldpwd} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:YES];
}
-(void)verify:(NSString*)code user:(NSString*)user callback:(CallBack) callback{
    [_ajax dicWithUrl:@"user/verify" params:@{@"code":code,@"user":user} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:YES];
}
-(void)base:(NSString*) userid callback:(CallBack)callback{
    [_ajax dicWithUrl:@"user/base" params:@{@"userid":userid} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:NO];
}
-(void)feedback:(NSString*)userid info:(NSString*)info callback:(CallBack)callback{
    NSDictionary*userInfo = [UserBiz userInfo];
    NSString*token=FORMAT(@"%@",userInfo[@"token"]);
    [_ajax dicWithUrl:FORMAT(@"feedback/add?token=%@&userid=%@",token,userid) params:@{@"userid":userid,@"info":info} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:YES];
}
@end
