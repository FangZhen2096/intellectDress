//
//  ReportAjax.m
//  IntellectDress
//
//  Created by zerom on 16/10/14.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ReportAjax.h"

@implementation ReportAjax
+ (void)reportSuccessWithStartTime:(NSString *)startTime  endTime:(NSString *)endTime success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    [SVProgressHUD show];
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"report/ratelist?userid=%@&shopid=%@&starttime=%@&endtime=%@&token=%@",userid,shopid,startTime,endTime,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
        NSLog(@"汇报error_____%@",error);
    }];
    
}

+ (void)reportChartSuccessWithStartTime:(NSString *)startTime  endTime:(NSString *)endTime type:(NSString *)type success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    [SVProgressHUD show];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"report/chart?userid=1&shopid=2&starttime=%@&endtime=%@&type=%@&token=%@",startTime,endTime,type,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
        NSLog(@"汇报error_____%@",error);
    }];
}


@end
