//
//  UserTypeModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserTypeModel : NSObject
@property (copy,nonatomic) NSString *ID;
@property (copy,nonatomic) NSString *typeId;
@property (copy,nonatomic) NSString *nickname;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) UserTypeModelWithDict:(NSDictionary *)dict;
@end
