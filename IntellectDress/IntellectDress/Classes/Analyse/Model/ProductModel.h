//
//  ProductModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/17.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
@property (nonatomic,copy) NSString *color;
@property (nonatomic,copy)  NSString *display;
@property (nonatomic,copy)  NSString *fitt;
@property (nonatomic,copy)  NSString *size;
@property (nonatomic,copy)  NSString *trying;
@property (nonatomic,copy) NSString *price;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) productWithDict:(NSDictionary *)dict;
@end
