//
//  StoreModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.title = dict[@"title"];
        self.version = dict[@"version"];
        self.weatherid = dict[@"weatherid"];
        self.Default = dict[@"default"];
    }
    return self;
}

+(instancetype) storeModelWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
