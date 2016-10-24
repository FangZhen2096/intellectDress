//
//  UserTypeModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "UserTypeModel.h"

@implementation UserTypeModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.typeId = dict[@"typeid"];
        self.nickname = dict[@"nickname"];
    }
    return self;
}

+(instancetype) UserTypeModelWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
