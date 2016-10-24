//
//  StoreModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject
@property (copy,nonatomic) NSString *ID;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *version;
@property (copy,nonatomic) NSString *weatherid;
@property (copy,nonatomic) NSString *Default;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) storeModelWithDict:(NSDictionary *)dict;

@end
