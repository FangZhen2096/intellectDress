//
//  UserManagerAjax.m
//  IntellectDress
//
//  Created by zerom on 16/10/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "UserManagerAjax.h"

@implementation UserManagerAjax
+ (void)UserListWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    
    NSString *userID = [UserBiz userId];
    NSString *token = [UserBiz token];
    NSString *shopid = [UserBiz shopId];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"user/userlist?userid=%@&shopid=%@&token=%@",userID,shopid,token)   parameters:@{@"userid":userID,@"shopid":shopid} progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary* responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            
            NSLog(@"商家用户列表请求成功 ----json:%@",responseObject);
            success(responseObject.copy);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"商家用户列表请求失败 ----error:%@",error);
    }];
}

+ (void)UserBaseInfoWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *userID = [UserBiz userId];
    NSString *token = [UserBiz token];

    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"user/base?userid=%@&token=%@",userID,token)   parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary* responseObject) {
            NSLog(@"商家基本信息 请求成功 ----json:%@",responseObject);
            success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"商家基本信息 请求失败 ----error:%@",error);
    }];
}

+ (void)UserManagerDetailsInfoWithUserid:(NSString *)userid Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"user/base?userid=%@&token=%@",userid,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary* responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD showInfoWithStatus:responseObject[@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        
        NSLog(@"商家详细信息 请求成功 ----json:%@",responseObject);
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"商家详细信息 请求失败 ----error:%@",error);
    }];
}

+ (void)DelUserWithDelId:(NSString *)delId Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *token = [UserBiz token];
    NSString *userID = [UserBiz userId];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"user/del?userid=%@&token=%@",userID,token)  parameters:@{@"userid":userID,@"did":delId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary* responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD showInfoWithStatus:responseObject[@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        NSLog(@"删除用户 请求成功 ----json:%@",responseObject);
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"删除用户 请求失败 ----error:%@",error);
    }];

}

+ (void)AddUserWithIds:(NSString *)ids typeid:(NSString *)typeId userTel:(NSString *)userTel Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *token = [UserBiz token];
    NSString *userID = [UserBiz userId];
    NSString *shopid = [UserBiz shopId];
    [[ZRNetWorkTool sharedNetworkTool] POST:FORMAT(@"user/adduser?userid=%@&shopid=%@&token=%@",userID,shopid,token)  parameters:@{@"ids":ids,@"typeid":typeId,@"user":userTel} progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary* responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD showInfoWithStatus:responseObject[@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        NSLog(@"添加用户 请求成功 ----json:%@",responseObject);
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"添加用户 请求失败 ----error:%@",error);
    }];
}













@end
