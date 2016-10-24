//
//  FK.h
//  FK
//
//  Created by 小强 on 15/12/4.
//  Copyright © 2015年 xiaoshag. All rights reserved.
//

#ifndef FK_h
#define FK_h
#ifdef __OBJC__

#import <Foundation/Foundation.h>
typedef void (^CallBack) (BOOL isError,NSDictionary* json);
#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "Config_.h"
#import "NSString+Commons.h"
#import "NSObject+Commons.h"
#import "UIView+Commons.h"
#import "Ajax.h"

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
#endif
#define SCREENWIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT    [UIScreen mainScreen].bounds.size.height
#define ALERT(msg) [[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
#define FORMAT(fmt,...)[NSString stringWithFormat:fmt,##__VA_ARGS__]
#define array(array,index) ((array && index>=0 && index<array.count) ? array[index] : nil)
#define UICOLORHEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UICOLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#endif /* FK_h */
