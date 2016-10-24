//
//  ZRNetWorkTool2.h
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ZRNetWorkTool2 : AFHTTPSessionManager
+ (instancetype)sharedNetworkTool;
@end
