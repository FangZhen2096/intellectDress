//
//  WeatherModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/10.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "WeatherModel.h"
#import "UserBiz.h"
#import "AppAjax.h"
#import "Ajax.h"
@interface WeatherModel ()
@property (strong,nonatomic) UserBiz *userBiz;
@property (nonatomic) AppAjax*ajax;
@end


@implementation WeatherModel

+(instancetype)weatherWithDict:(NSDictionary *)dict{
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}


+ (void)weatherWithCityID:(NSString *)cityId Success:(void (^)(NSDictionary *))success failed:(void (^)(NSError *))failed{
    NSString *cityid = [UserBiz cityId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"weather/now?cityid=%@&token=%@",cityId,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        
        NSLog(@"天气请求成功-responseObject---------%@",responseObject);
        success(responseObject.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
}

@end
