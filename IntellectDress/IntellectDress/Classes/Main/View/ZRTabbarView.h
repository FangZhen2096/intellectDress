//
//  ZRTabbarView.h
//  IntellectDress
//
//  Created by 房 臻 on 16/9/2.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZRTabbarView;

@protocol ZRTabBarViewDelegate <NSObject>

- (void)tabBar:(ZRTabbarView *)tabBar clickBtn:(UIButton *)selectedBtn;

@end
@interface ZRTabbarView : UIView

@property (nonatomic,weak) id<ZRTabBarViewDelegate> myDelegate;

- (void)addBtn:(NSString *)normalImage withSelectedImage:(NSString *)selectedImage withIndex:(NSInteger)index;
@end
