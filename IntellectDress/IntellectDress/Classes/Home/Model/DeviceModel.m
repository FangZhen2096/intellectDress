//
//  DeviceModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/20.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "DeviceModel.h"

@implementation DeviceModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype) DeviceModelWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
