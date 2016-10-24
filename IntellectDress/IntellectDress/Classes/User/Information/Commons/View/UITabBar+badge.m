//
//  UITabBar+badge.m
//  BangLi
//
//  Created by 小强 on 16/1/12.
//  Copyright © 2016年 xiaoshag. All rights reserved.
//

#import "UITabBar+badge.h"
#define TabbarItemNums 5.0
@implementation UITabBar (badge)
- (void)showBadgeOnItemIndex:(NSInteger)index value:(NSString*)value tabCount:(NSInteger) tabCount{
    NSInteger count = [value integerValue];
    if (count>99) {
        value = @"99";
    }
    [self removeBadgeOnItemIndex:index];
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 8;
    badgeView.backgroundColor = [UIColor whiteColor];
    CGRect tabFrame = self.frame;
    float percentX = (index +0.6) / tabCount;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 16, 16);
    UILabel*badgeLabel = [[UILabel alloc] initWithFrame:badgeView.bounds];
    badgeLabel.textColor = GlobalTintColor;
    badgeLabel.text = value;
    badgeLabel.font = [UIFont systemFontOfSize:10];
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    [badgeView addSubview:badgeLabel];
    [self addSubview:badgeView];
}

- (void)hideBadgeOnItemIndex:(NSInteger)index{
    
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(NSInteger)index{
    
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
