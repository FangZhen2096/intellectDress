//
//  HomeAjax.h
//  IntellectDress
//
//  Created by zerom on 16/10/11.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeAjax : NSObject

/**
 客流回调

 @param success 成功回调
 @param failed  失败回调
 */
+ (void)passengerFlowWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

/**
 试衣回调

 @param success 成功回调
 @param failed  失败回调
 */
+ (void)tryClothesWithSuccess:(void(^)(NSDictionary *json))success failed:(void(^)(NSError *error))failed;

/**
 试穿回调

 @param success 成功回调
 @param failed  失败回调
 */
+ (void)tryOnWithSuccess:(void(^)(NSDictionary *json))success failed:(void(^)(NSError *error))failed;


+ (void)storeManagerWithSuccess:(void(^)(NSDictionary *json))success failed:(void(^)(NSError *error))failed;

+(void)shopDetailsWithShopId:(NSString *)shopID Success:(void(^)(NSDictionary *json))success failed:(void(^)(NSError *error))failed;

+(void)shopDetailsEditWithOpens:(NSString *)opens closed:(NSString *)closed info:(NSString *)info contact:(NSString *)contact shopid:(NSString *)shopid Success:(void(^)(NSDictionary *json))success failed:(void(^)(NSError *error))failed;

+(void)DeviceListWithShopId:(NSString *)shopID Success:(void(^)(NSDictionary *json))success failed:(void(^)(NSError *error))failed;

+ (void)reportListWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;






@end
