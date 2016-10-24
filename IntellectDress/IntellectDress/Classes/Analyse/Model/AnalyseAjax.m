//
//  AnalyseAjax.m
//  IntellectDress
//
//  Created by zerom on 16/10/14.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "AnalyseAjax.h"

@implementation AnalyseAjax
+ (void)HotRankWithTime:(NSString *)time Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    [SVProgressHUD show];
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/heat?userid=%@&shopid=%@&time=%@&token=%@",userid,shopid,time,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"热度排行请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"HotRank  error_____%@",error);
        failed(error);
        
    }];
}

+ (void)ProductDetailsWithGid:(NSString *)gid Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    [SVProgressHUD show];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/details?gid=%@&token=%@",gid,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"商品明细请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"商品明细请求失败  error_____%@",error);
        failed(error);
        
    }];
}

+ (void)ProductInfoWithType:(NSString *)type wearid:(NSString *)wearid  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    [SVProgressHUD show];
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/news?userid=%@&shopid=%@&type=%@&wearid=%@&page=1&sort=1&token=%@",userid,shopid,type,wearid,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"商品信息请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"商品信息请求失败error_____%@",error);
        failed(error);
        
    }];
}

+(void)productCategoryWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    [SVProgressHUD show];
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/menu?userid=%@&shopid=%@&token=%@",userid,shopid,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"商品分类请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"商品分类请求失败error_____%@",error);
        failed(error);
        
    }];

}

+(void)productListWithClassId:(NSString *)classID  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    [SVProgressHUD show];
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/wear?userid=%@&shopid=%@&classid=%@&token=%@",userid,shopid,classID,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"商品目录请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"商品目录请求失败error_____%@",error);
        failed(error);
        
    }];
}

+(void)searchProductWithSearch:(NSString *)search Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    [SVProgressHUD show];
    NSString *token = [UserBiz token];
    search = [search stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/search?search=%@&page=1&token=%@",search,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"搜索商品请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"搜索商品请求失败error_____%@",error);
        failed(error);
        
    }];
}

+(void)productAnalyseSuggestWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    [SVProgressHUD show];
    NSString *token = [UserBiz token];
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/goods?userid=%@&shopid=%@&token=%@",userid,shopid,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"商品分析经营建议请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"商品分析经营建议请求失败error_____%@",error);
        failed(error);
        
    }];
}

+(void)productAnalyseTryOnWithStartTime:(NSString *)startTime endtime:(NSString*)endtime  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/atry?userid=%@&shopid=%@&starttime=%@&endtime=%@&token=%@",userid,shopid,startTime,endtime,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"商品分析试穿 请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"商品分析试穿 请求失败error_____%@",error);
        failed(error);
        
    }];
}
+(void)productAnalyseFittingWithStartTime:(NSString *)startTime endtime:(NSString*)endtime  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/afitting?userid=%@&shopid=%@&starttime=%@&endtime=%@&token=%@",userid,shopid,startTime,endtime,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"商品分析试衣 请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"商品分析试衣 请求失败error_____%@",error);
        failed(error);
        
    }];
}

+(void)productAnalyseFittMoreWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/fittmore?userid=%@&shopid=%@&page=1&token=%@",userid,shopid,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"试衣更多 请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"试衣更多 请求失败error_____%@",error);
        failed(error);
        
    }];

}
+(void)productAnalyseTryOnMoreWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/dismore?userid=%@&shopid=%@&page=1&token=%@",userid,shopid,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"试穿更多 请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"试穿更多 请求失败error_____%@",error);
        failed(error);
        
    }];
}

+(void)productAnalyseFittCakeWithStartTime:(NSString *)startTime endtime:(NSString*)endtime  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/fittcake?userid=%@&shopid=%@&starttime=%@&endtime=%@&token=%@",userid,shopid,startTime,endtime,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"商品分析试衣饼图 请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"商品分析试衣饼图 请求失败error_____%@",error);
        failed(error);
        
    }];

}
+(void)productAnalyseTryCakeCakeWithStartTime:(NSString *)startTime endtime:(NSString*)endtime  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/trycake?userid=%@&shopid=%@&starttime=%@&endtime=%@&token=%@",userid,shopid,startTime,endtime,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"商品分析试穿饼图 请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"商品分析试穿饼图 请求失败error_____%@",error);
        failed(error);
    }];
}

+(void)productDullSaleWithStartTime:(NSString *)startTime endtime:(NSString*)endtime  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    [SVProgressHUD show];
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/drug?userid=%@&shopid=%@&starttime=%@&endtime=%@&token=%@",userid,shopid,startTime,endtime,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"滞销分析 请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"滞销分析 请求失败error_____%@",error);
        failed(error);
    }];

}

+(void)productDisplayWithStartTime:(NSString *)startTime endtime:(NSString*)endtime  Success:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/display?userid=%@&shopid=%@&starttime=%@&endtime=%@&sort=1&token=%@",userid,shopid,startTime,endtime,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"滞销分析商品陈列 请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"滞销分析商品陈列  请求失败error_____%@",error);
        failed(error);
    }];

}

+(void)productDisplayMoreWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed{
    [SVProgressHUD show];
    NSString *shopid = [UserBiz shopId];
    NSString *userid = [UserBiz userId];
    NSString *token = [UserBiz token];
    [[ZRNetWorkTool sharedNetworkTool] GET:FORMAT(@"analysis/dismore?userid=%@&shopid=%@&page=1&token=%@",userid,shopid,token)  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        NSLog(@"滞销分析商品陈列更多 请求成功-----json:%@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            success(responseObject.copy);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",responseObject[@"info"])];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"滞销分析商品陈列更多  请求失败error_____%@",error);
        failed(error);
    }];
}
@end
