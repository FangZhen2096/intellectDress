//
//  FocusModel.h
//  IntellectDress
//
//  Created by zerom on 16/10/24.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FocusModel : NSObject
@property (nonatomic,copy)  NSString *img;
@property (nonatomic,copy)  NSString *title;
@property (nonatomic,copy)  NSString *number;
@property (nonatomic,copy)  NSString *display;
@property (nonatomic,copy)  NSString *piece;
@property (nonatomic,copy)  NSString *jacket;
@property (nonatomic,copy)  NSString *trying;
@property (nonatomic,copy)  NSString *num;
@property (nonatomic,copy)  NSString *first;
@property (nonatomic,copy)  NSString *fitt;
@property (nonatomic,copy)  NSString *ber;
@property (nonatomic,copy)  NSString *next;
@property (nonatomic,copy)  NSString *price;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype) FocusModelWithDict:(NSDictionary *)dict;
@end
