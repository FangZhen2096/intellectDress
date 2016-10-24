//
//  ReportHeaderModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportHeaderModel : NSObject
@property (copy,nonatomic) NSString *start;
@property (copy,nonatomic) NSString *end;
@property (copy,nonatomic) NSString *title;
-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) ReportHeaderModelWithDict:(NSDictionary *)dict;
@end
