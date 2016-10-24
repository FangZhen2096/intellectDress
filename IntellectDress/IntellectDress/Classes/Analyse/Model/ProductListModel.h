//
//  ProductListModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/18.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductListModel : NSObject
@property (copy,nonatomic) NSString *ID;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *total;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) productListWithDict:(NSDictionary *)dict;
@end
