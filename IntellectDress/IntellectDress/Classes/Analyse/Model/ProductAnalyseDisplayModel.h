//
//  ProductAnalyseDisplayModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/18.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductAnalyseDisplayModel : NSObject
@property (copy,nonatomic) NSString *ID;
@property (copy,nonatomic) NSString *img;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *number;
@property (copy,nonatomic) NSString *price;
@property (copy,nonatomic) NSString *love;
@property (copy,nonatomic) NSString *ber;
-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) productAnalyseDisplayModelWithDict:(NSDictionary *)dict;
@end
