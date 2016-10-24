//
//  ZRNetWorkTool.h
//  IntellectDress
//
//  Created by zerom on 16/10/10.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ZRNetWorkTool : AFHTTPSessionManager
+ (instancetype)sharedNetworkTool;
@end
