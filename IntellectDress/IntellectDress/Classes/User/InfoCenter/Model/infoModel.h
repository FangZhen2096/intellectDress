//
//  infoModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface infoModel : NSObject
@property (copy,nonatomic) NSString *ID;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *classid;
@property (copy,nonatomic) NSString *info;
@property (copy,nonatomic) NSString *time;
@property (copy,nonatomic) NSString *see;
@property (copy,nonatomic) NSString *type;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) infoModelWithDict:(NSDictionary *)dict;
@end
