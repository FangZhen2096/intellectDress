//
//  ProductInfoModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/17.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductInfoModel : NSObject
@property (nonatomic,copy) NSString *piece;
@property (nonatomic,copy)  NSString *display;
@property (nonatomic,copy)  NSString *trying;
@property (nonatomic,copy)  NSString *num;
@property (nonatomic,copy)  NSString *fitt;
@property (nonatomic,copy) NSString *ber;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *love;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *number;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) productInfoWithDict:(NSDictionary *)dict;
@end
