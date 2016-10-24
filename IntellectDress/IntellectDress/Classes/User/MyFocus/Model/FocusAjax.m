//
//  FocusAjax.m
//  IntellectDress
//
//  Created by zerom on 16/10/24.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "FocusAjax.h"

@implementation FocusAjax
+ (void)FocusListWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *token = [UserBiz token];
    NSString *userid = [UserBiz userId];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/follow?userid=%@&page=1&token=%@",userid,token) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD showInfoWithStatus:responseObject[@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        NSLog(@"我的关注列表  请求成功------json:%@",responseObject);
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"我的关注列表  请求失败------error:%@",error);
        failed(error);
    }];
}
@end
