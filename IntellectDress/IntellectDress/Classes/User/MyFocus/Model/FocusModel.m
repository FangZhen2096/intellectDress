//
//  FocusModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/24.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "FocusModel.h"

@implementation FocusModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype) FocusModelWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
