//
//  UserBaseInfoModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserBaseInfoModel : NSObject
@property (copy,nonatomic) NSString *ID;
@property (copy,nonatomic) NSString *img;
@property (copy,nonatomic) NSString *nickname;
@property (copy,nonatomic) NSString *username;
@property (copy,nonatomic) NSString *typeID;
@property (copy,nonatomic) NSString *type;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) UserBaseInfoModelWithDict:(NSDictionary *)dict;
@end
