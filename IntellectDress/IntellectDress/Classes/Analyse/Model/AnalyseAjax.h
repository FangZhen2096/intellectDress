//
//  AnalyseAjax.h
//  IntellectDress
//
//  Created by zerom on 16/10/14.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnalyseAjax : NSObject
+ (void)HotRankWithTime:(NSString *)time Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;
+ (void)ProductDetailsWithGid:(NSString *)gid Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+ (void)ProductInfoWithType:(NSString *)type wearid:(NSString *)wearid Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;
+(void)productCategoryWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+(void)productListWithClassId:(NSString *)classID  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+(void)searchProductWithSearch:(NSString *)search Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+(void)productAnalyseSuggestWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+(void)productAnalyseTryOnWithStartTime:(NSString *)startTime endtime:(NSString*)endtime  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+(void)productAnalyseFittingWithStartTime:(NSString *)startTime endtime:(NSString*)endtime  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+(void)productAnalyseFittMoreWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;
+(void)productAnalyseTryOnMoreWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+(void)productAnalyseFittCakeWithStartTime:(NSString *)startTime endtime:(NSString*)endtime  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+(void)productAnalyseTryCakeCakeWithStartTime:(NSString *)startTime endtime:(NSString*)endtime  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+(void)productDullSaleWithStartTime:(NSString *)startTime endtime:(NSString*)endtime  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+(void)productDisplayWithStartTime:(NSString *)startTime endtime:(NSString*)endtime  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;

+(void)productDisplayMoreWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;
@end
