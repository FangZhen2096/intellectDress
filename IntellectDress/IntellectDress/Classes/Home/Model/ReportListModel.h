//
//  ReportListModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/20.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportListModel : NSObject
@property (copy,nonatomic) NSString *ID;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *info;
@property (copy,nonatomic) NSString *read;
-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) ReportListModelWithDict:(NSDictionary *)dict;
@end
