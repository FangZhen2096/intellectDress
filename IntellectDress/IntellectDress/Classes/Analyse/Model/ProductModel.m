//
//  ProductModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/17.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype) productWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
