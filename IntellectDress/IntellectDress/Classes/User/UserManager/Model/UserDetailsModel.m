//
//  UserDetailsModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "UserDetailsModel.h"

@implementation UserDetailsModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.typeId = dict[@"typeid"];
        self.username = dict[@"username"];
        self.nickname = dict[@"nickname"];
        self.sex = dict[@"sex"];
        self.name = dict[@"name"];
        self.email = dict[@"email"];
        self.img = dict[@"img"];
        self.type = dict[@"type"];
        self.ID = dict[@"id"];
    }
    return self;
}

+(instancetype) UserDetailsModelWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
