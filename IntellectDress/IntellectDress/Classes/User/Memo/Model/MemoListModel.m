//
//  MemoListModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "MemoListModel.h"

@implementation MemoListModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.info = dict[@"info"];
        self.mark = dict[@"mark"];
        self.times = dict[@"times"];
        self.shopid = dict[@"shopid"];
        self.userid = dict[@"userid"];
        self.time = dict[@"time"];
    }
    return self;
}

+(instancetype) memoListModelWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
