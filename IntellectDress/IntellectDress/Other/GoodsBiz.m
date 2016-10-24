//
//  GoodsBiz.m
//  IntellectDress
//
//  Created by zerom on 16/10/17.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "GoodsBiz.h"

@implementation GoodsBiz
+(NSDictionary*)goodsInfo{
    NSString*goodsInfo =[Config_ get:@"goodsInfo"];
    return [goodsInfo toDictionary];
}

+(void)setGoodsInfo:(NSDictionary*)dic{
    [Config_ set:@"goodsInfo" value:[dic toString]];
}
+ (NSString *)gid:(NSInteger)i{
    if (![UserBiz logined]) {
        return @"";
    }
    NSDictionary *goodsInfo = [GoodsBiz goodsInfo];
    NSDictionary*results =goodsInfo[@"results"];
    NSArray *list = results[@"list"];
    NSDictionary *listSub = [list objectAtIndex:i];
    return  FORMAT(@"%@",listSub[@"id"]);
}
@end
