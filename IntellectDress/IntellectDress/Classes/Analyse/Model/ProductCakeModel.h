//
//  ProductCakeModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/18.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductCakeModel : NSObject
@property (copy,nonatomic) NSString *pre;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *color;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) productCakeWithDict:(NSDictionary *)dict;
@end
