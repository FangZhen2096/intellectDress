//
//  WeatherModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/10.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject
@property(nonatomic,assign) NSInteger ID;
@property (nonatomic,copy) NSString *city;
@property(nonatomic,assign) NSInteger cityid;
@property (nonatomic,copy) NSString *quality;
/**
 湿度
 */
@property (nonatomic,copy) NSString *sd;
@property (nonatomic,copy) NSString *weather;
//温度
@property (nonatomic,copy) NSString *temperature;
//天气图片
@property (nonatomic,copy) NSString *weather_pic;
//衣着建议
@property (nonatomic,copy) NSDictionary *clothes;

+(instancetype)weatherWithDict:(NSDictionary *)dict;
+ (void)weatherWithCityID:(NSString *)cityId Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *))failed;
- (void)weatherWithSuccess:(CallBack) callback;
@end
