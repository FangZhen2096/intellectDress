//
//  ReportAjax.h
//  IntellectDress
//
//  Created by zerom on 16/10/14.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportAjax : NSObject
+ (void)reportSuccessWithStartTime:(NSString *)startTime  endTime:(NSString *)endTime success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+ (void)reportChartSuccessWithStartTime:(NSString *)startTime  endTime:(NSString *)endTime type:(NSString *)type success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;



@end
