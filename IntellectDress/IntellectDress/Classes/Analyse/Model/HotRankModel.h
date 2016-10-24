//
//  HotRankModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/17.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotRankModel : NSObject
@property (copy,nonatomic) NSString *ber;
@property (copy,nonatomic) NSString *img;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *number;
@property (copy,nonatomic) NSString *price;
@property (copy,nonatomic) NSString *rate;
@property (copy,nonatomic) NSString *unit;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype) hotRankModelWithDict:(NSDictionary *)dict;
@end
