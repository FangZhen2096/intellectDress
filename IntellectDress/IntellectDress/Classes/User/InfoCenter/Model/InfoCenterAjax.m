//
//  InfoCenterAjax.m
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "InfoCenterAjax.h"

@implementation InfoCenterAjax
+ (void)infoCenterWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *userID = [UserBiz userId];
    NSString *token = [UserBiz token];
    NSInteger page = 1;
    [[ZRNetWorkTool2 sharedNetworkTool] GET:@"message/userinfo"  parameters:@{@"userid":userID,@"page":@(page),@"token":token} progress:nil success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary* responseObject) {
        NSLog(@"信息中心请求成功 ----json:%@",responseObject);
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"信息中心请求失败 ----error:%@",error);
    }];
}
@end
