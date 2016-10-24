//
//  ShopDetailsModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/20.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ShopDetailsModel.h"

@implementation ShopDetailsModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.classid = dict[@"classid"];
        self.title = dict[@"title"];
        self.info = dict[@"info"];
        self.weatherid = dict[@"weatherid"];
        self.city = dict[@"city"];
        self.address = dict[@"address"];
        self.contact = dict[@"contact"];
        self.admin = dict[@"admin"];
        self.opens = dict[@"opens"];
        self.closed = dict[@"closed"];
        self.tel = dict[@"tel"];
        self.code = dict[@"code"];
        self.flag = dict[@"flag"];
        self.time = dict[@"time"];
    }
    return self;
}

+(instancetype) ShopDetailsModelWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
