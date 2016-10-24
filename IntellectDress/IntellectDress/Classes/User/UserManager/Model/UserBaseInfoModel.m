//
//  UserBaseInfoModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "UserBaseInfoModel.h"

@implementation UserBaseInfoModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.img = dict[@"img"];
        self.nickname = dict[@"nickname"];
        self.username = dict[@"username"];
        self.typeID = dict[@"typeid"];
        self.type = dict[@"type"];
    }
    return self;
}

+(instancetype) UserBaseInfoModelWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
