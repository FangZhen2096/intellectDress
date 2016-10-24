//
//  HomeAjax.m
//  IntellectDress
//
//  Created by zerom on 16/10/11.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "HomeAjax.h"

@implementation HomeAjax
//客流成功回调
+ (void)passengerFlowWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"home/report?userid=%@&shopid=%@&token=%@",userid,shopid,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
        NSLog(@"error_____%@",error);
    }];
}
//试衣成功回调
+ (void)tryClothesWithSuccess:(void(^)(NSDictionary *json))success failed:(void(^)(NSError *error))failed{
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"home/fitting?userid=%@&shopid=%@&token=%@",userid,shopid,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
        NSLog(@"试衣回调error_____%@",error);
    }];}

+ (void)tryOnWithSuccess:(void(^)(NSDictionary *json))success failed:(void(^)(NSError *error))failed{
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"home/trying?userid=%@&shopid=%@&token=%@",userid,shopid,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
        NSLog(@"试穿回调error_____%@",error);
    }];
}

+ (void)storeManagerWithSuccess:(void(^)(NSDictionary *json))success failed:(void(^)(NSError *error))failed{
    [SVProgressHUD show];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"shop/user?&userid=%@&token=%@",userid,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            NSLog(@"店铺列表请求成功----json:%@",responseObject);
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"店铺列表请求失败----error:%@",error);
        failed(error);
        
    }];

}

+(void)shopDetailsWithShopId:(NSString *)shopID Success:(void(^)(NSDictionary *json))success failed:(void(^)(NSError *error))failed{
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"shop/info?shopid=%@&token=%@",shopID,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            
            NSLog(@"店铺详情请求成功----json:%@",responseObject);
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"店铺详情请求失败----error:%@",error);
        failed(error);
        
    }];

}
+(void)shopDetailsEditWithOpens:(NSString *)opens closed:(NSString *)closed info:(NSString *)info contact:(NSString *)contact shopid:(NSString *)shopid Success:(void(^)(NSDictionary *json))success failed:(void(^)(NSError *error))failed{
    NSString *token = [UserBiz token];
    [SVProgressHUD show];
    [[ZRNetWorkTool sharedNetworkTool] POST:FORMAT(@"http://api.ba-mgt.com/shop/edit?shopid=%@&token=%@",shopid,token) parameters:@{@"opens":opens,@"closed":closed,@"info":info,@"contact":contact} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            NSLog(@"店铺详情修改 请求成功----json:%@",responseObject);
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"店铺详情修改 请求失败----error:%@",error);
    }];
}

+(void)DeviceListWithShopId:(NSString *)shopID Success:(void(^)(NSDictionary *json))success failed:(void(^)(NSError *error))failed{
    [SVProgressHUD show];
    NSString *token = [UserBiz token];
    NSString *userID = [UserBiz userId];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"dev/state?userid=%@&shopid=%@&page=1&token=%@",userID,shopID,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            NSLog(@"设备列表请求成功----json:%@",responseObject);
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"设备列表请求失败----error:%@",error);
        failed(error);
        
    }];
    
}

+ (void)reportListWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"report/infolist?userid=%@&shopid=%@&page=1&token=%@",userid,shopid,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"汇报列表请求成功----json:%@",responseObject);
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
        NSLog(@"汇报列表请求失败----error:%@",error);
    }];

}


















@end
