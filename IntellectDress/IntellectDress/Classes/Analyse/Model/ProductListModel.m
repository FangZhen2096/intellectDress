//
//  ProductListModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/18.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ProductListModel.h"

@implementation ProductListModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.total = dict[@"total"];
        self.ID = dict[@"id"];
    }
    return self;
}

+(instancetype) productListWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
