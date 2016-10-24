//
//  DullSaleListModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/18.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DullSaleListModel : NSObject
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *color;
@property (copy,nonatomic) NSString *percent;
@property (copy,nonatomic) NSString *hold;
-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) dullSaleListWithDict:(NSDictionary *)dict;
@end
