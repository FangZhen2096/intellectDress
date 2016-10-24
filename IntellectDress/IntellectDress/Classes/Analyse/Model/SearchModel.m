//
//  SearchModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/18.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.title = dict[@"title"];
        self.img = dict[@"img"];
        self.number = dict[@"number"];
        self.price = dict[@"price"];
    }
    return self;
}

+(instancetype) searchWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
