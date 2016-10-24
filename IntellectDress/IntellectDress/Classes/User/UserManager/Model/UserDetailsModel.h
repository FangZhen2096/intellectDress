//
//  UserDetailsModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetailsModel : NSObject
@property (copy,nonatomic) NSString *typeId;
@property (copy,nonatomic) NSString *username;
@property (copy,nonatomic) NSString *nickname;
@property (copy,nonatomic) NSString *sex;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *email;
@property (copy,nonatomic) NSString *img;
@property (copy,nonatomic) NSString *type;
@property (copy,nonatomic) NSString *ID;
@property (copy,nonatomic) NSString *shops;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) UserDetailsModelWithDict:(NSDictionary *)dict;
@end
