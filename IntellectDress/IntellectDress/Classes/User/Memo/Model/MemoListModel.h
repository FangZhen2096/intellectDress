//
//  MemoListModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemoListModel : NSObject
@property (copy,nonatomic) NSString *info;
@property (copy,nonatomic) NSString *mark;
@property (copy,nonatomic) NSString *times;
@property (copy,nonatomic) NSString *shopid;
@property (copy,nonatomic) NSString *userid;
@property (copy,nonatomic) NSString *ID;
@property (copy,nonatomic) NSString *time;
-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) memoListModelWithDict:(NSDictionary *)dict;
@end
