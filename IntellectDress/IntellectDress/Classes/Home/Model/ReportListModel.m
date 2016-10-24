//
//  ReportListModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/20.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ReportListModel.h"

@implementation ReportListModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.info = dict[@"info"];
        self.title = dict[@"title"];
        self.read = dict[@"read"];
    }
    return self;
}

+(instancetype) ReportListModelWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
