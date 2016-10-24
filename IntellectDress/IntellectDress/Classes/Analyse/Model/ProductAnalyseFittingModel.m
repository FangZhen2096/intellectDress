//
//  ProductAnalyseFittingModel.m
//  IntellectDress
//
//  Created by zerom on 16/10/18.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ProductAnalyseFittingModel.h"

@implementation ProductAnalyseFittingModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.title = dict[@"title"];
        self.img = dict[@"img"];
        self.number = dict[@"number"];
        self.price = dict[@"price"];
        self.love = dict[@"love"];
        self.ber = dict[@"ber"];
    }
    return self;
}

+(instancetype) productAnalyseFittingModelWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
