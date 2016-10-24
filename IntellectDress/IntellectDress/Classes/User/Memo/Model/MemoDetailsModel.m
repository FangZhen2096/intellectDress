//
//  MemoDetailsModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "MemoDetailsModel.h"

@implementation MemoDetailsModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.shopid = dict[@"shopid"];
        self.userid = dict[@"userid"];
        self.info = dict[@"info"];
        self.mark = dict[@"mark"];
        self.start = dict[@"start"];
        self.end = dict[@"end"];
        self.disabled = dict[@"disabled"];
        self.time = dict[@"time"];
        self.edittime = dict[@"edittime"];
        self.flag = dict[@"flag"];
        self.ago = dict[@"ago"];
        self.starts = dict[@"starts"];
        self.ends = dict[@"ends"];
    }
    return self;
}

+(instancetype) memoDetailsWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
