//
//  NSString+Kit.h
//  GoodTeacher
//
//  Created by 小强 on 15/5/22.
//  Copyright (c) 2015年 XiaoShang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Commons)
-(NSString*)trim;
-(BOOL)isempty;
-(BOOL)contains:(NSString*) str;
-(BOOL)containsChinese;
-(BOOL)isPhone;
-(BOOL)isEmail;
- (NSString *)md5_32;
-(CGFloat)heightWithSize:(CGSize)size font:(UIFont*)font;
//-(NSString*)dicToString:(NSDictionary*)dic;
-(NSDictionary*)toDictionary;
@end
