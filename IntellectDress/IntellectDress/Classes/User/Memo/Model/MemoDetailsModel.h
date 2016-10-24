//
//  MemoDetailsModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemoDetailsModel : NSObject
@property (copy,nonatomic) NSString *ID;
@property (copy,nonatomic) NSString *shopid;
@property (copy,nonatomic) NSString *userid;
@property (copy,nonatomic) NSString *info;
@property (copy,nonatomic) NSString *mark;
@property (copy,nonatomic) NSString *start;
@property (copy,nonatomic) NSString *end;
@property (copy,nonatomic) NSString *disabled;
@property (copy,nonatomic) NSString *time;
@property (copy,nonatomic) NSString *edittime;
@property (copy,nonatomic) NSString *flag;
@property (copy,nonatomic) NSString *ago;
@property (copy,nonatomic) NSString *starts;
@property (copy,nonatomic) NSString *ends;
-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) memoDetailsWithDict:(NSDictionary *)dict;
@end
