//
//  UITabBar+badge.h
//  BangLi
//
//  Created by 小强 on 16/1/12.
//  Copyright © 2016年 xiaoshag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
- (void)showBadgeOnItemIndex:(NSInteger)index value:(NSString*)value tabCount:(NSInteger) tabCount;

- (void)hideBadgeOnItemIndex:(NSInteger)index;
@end
