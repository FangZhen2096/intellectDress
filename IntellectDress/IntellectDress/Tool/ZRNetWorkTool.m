//
//  ZRNetWorkTool.m
//  IntellectDress
//
//  Created by zerom on 16/10/10.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRNetWorkTool.h"

@implementation ZRNetWorkTool
+ (instancetype)sharedNetworkTool {
    static ZRNetWorkTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://api.ba-mgt.com/"];
        
        instance = [[self alloc] initWithBaseURL:baseURL];
        // 修改响应解析器能够接受的数据类型
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return instance;
}

@end
