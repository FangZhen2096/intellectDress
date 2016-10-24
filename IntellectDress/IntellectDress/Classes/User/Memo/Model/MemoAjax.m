//
//  MemoAjax.m
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "MemoAjax.h"

@implementation MemoAjax
+ (void)MemoListWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *token = [UserBiz token];
    NSString *userid = [UserBiz userId];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"book/my?userid=%@&page=1&pagesize=10&token=%@",userid,token) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        NSLog(@"备忘录列表请求成功  json:%@",responseObject);
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (void)MemoDetailsWithBid:(NSString *)bid Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *token = [UserBiz token];
    NSString *userid = [UserBiz userId];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"book/info?userid=%@&bid=%@&token=%@",userid,bid,token) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        NSLog(@"备忘录详情请求成功  json:%@",responseObject);
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (void)DelMemoDetailsWithBid:(NSString *)bid Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *token = [UserBiz token];
    NSString *userid = [UserBiz userId];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"book/del?userid=%@&bid=%@&token=%@",userid,bid,token) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD showInfoWithStatus:responseObject[@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }

        NSLog(@"删除备忘录 请求成功  ---json:%@",responseObject);
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"删除备忘录 请求失败 --- error:%@",error);
        failed(error);
    }];
}
+ (void)addNewMemoDetailsWithStart:(NSString *)start end:(NSString *)end info:(NSString *)info mark:(NSString *)mark Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *token = [UserBiz token];
    NSString *userid = [UserBiz userId];
    NSString *shopid = [UserBiz shopId];
    [[ZRNetWorkTool sharedNetworkTool] POST:FORMAT(@"book/add?userid=%@&shopid=1&token=%@",userid,token) parameters:@{@"end":end,@"info":info,@"mark":mark,@"shopid":shopid,@"start":start,@"userid":userid} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD showInfoWithStatus:responseObject[@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        NSLog(@"添加备忘录 请求成功  ---json:%@",responseObject);
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"添加备忘录 请求失败  ---error:%@",error);
        failed(error);
      }];
}
+ (void)SaveMemoDetailsWithBid:(NSString *)bid Info:(NSString *)info mark:(NSString *)mark  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *token = [UserBiz token];
    NSString *userid = [UserBiz userId];
    [[ZRNetWorkTool sharedNetworkTool] POST:FORMAT(@"book/edit?userid=%@&bid=%@&token=%@",userid,bid,token) parameters:@{@"bid":bid,@"info":info,@"mark":mark,@"userid":userid} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        if ([responseObject[@"status"] boolValue]) {
           [SVProgressHUD showInfoWithStatus:responseObject[@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        NSLog(@"保存备忘录 请求成功  ---json:%@",responseObject);
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"保存备忘录 请求失败  ---error:%@",error);
        failed(error);
    }];
}
+ (void)DelsMemoDetailsWithBid:(NSString *)bids Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *token = [UserBiz token];
    NSString *userid = [UserBiz userId];
    [[ZRNetWorkTool sharedNetworkTool] POST:FORMAT(@"book/dels?userid=%@&token=%@",userid,token) parameters:@{@"userid":userid,@"ids":bids} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD showInfoWithStatus:responseObject[@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        NSLog(@"删除备忘录 请求成功  ---json:%@",responseObject);
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"删除备忘录 请求失败 --- error:%@",error);
        failed(error);
    }];

}












@end
