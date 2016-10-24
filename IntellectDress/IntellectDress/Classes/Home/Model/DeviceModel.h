//
//  DeviceModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/20.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceModel : NSObject
@property (copy,nonatomic) NSString *alias;
@property (copy,nonatomic) NSString *imei;
@property (copy,nonatomic) NSString *online;
-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) DeviceModelWithDict:(NSDictionary *)dict;
@end
