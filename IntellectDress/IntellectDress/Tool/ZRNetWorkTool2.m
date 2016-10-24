//
//  ZRNetWorkTool2.m
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRNetWorkTool2.h"

@implementation ZRNetWorkTool2
+ (instancetype)sharedNetworkTool {
    static ZRNetWorkTool2 *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://a.ba-mgt.com/api/"];
        instance = [[self alloc] initWithBaseURL:baseURL];
        // 修改响应解析器能够接受的数据类型
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return instance;
}
@end
