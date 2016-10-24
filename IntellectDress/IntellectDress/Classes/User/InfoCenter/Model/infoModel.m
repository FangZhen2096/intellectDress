//
//  infoModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "infoModel.h"

@implementation infoModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.title = dict[@"title"];
        self.classid = dict[@"classid"];
        self.info = dict[@"info"];
        self.time = dict[@"time"];
        self.see = dict[@"see"];
        self.type = dict[@"type"];
    }
    return self;
}

+(instancetype) infoModelWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
