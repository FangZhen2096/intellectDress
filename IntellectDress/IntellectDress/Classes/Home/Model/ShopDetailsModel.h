//
//  ShopDetailsModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/20.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopDetailsModel : NSObject
@property (copy,nonatomic) NSString *ID;
@property (copy,nonatomic) NSString *classid;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *info;
@property (copy,nonatomic) NSString *weatherid;
@property (copy,nonatomic) NSString *city;
@property (copy,nonatomic) NSString *address;
@property (copy,nonatomic) NSString *contact;
@property (copy,nonatomic) NSString *admin;
@property (copy,nonatomic) NSString *opens;
@property (copy,nonatomic) NSString *closed;
@property (copy,nonatomic) NSString *tel;
@property (copy,nonatomic) NSString *code;
@property (copy,nonatomic) NSString *flag;
@property (copy,nonatomic) NSString *time;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) ShopDetailsModelWithDict:(NSDictionary *)dict;

@end
