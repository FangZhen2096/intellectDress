//
//  ProductCategoryModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/18.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ProductCategoryModel.h"

@implementation ProductCategoryModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.ID = dict[@"id"];
        self.total = dict[@"total"];
    }
    return self;
}

+(instancetype) productCategoryWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end
