//
//  ZRTabbarView.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/2.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRTabbarView.h"

@interface ZRTabbarView ()
@property (nonatomic,weak)UIButton *selectedBtn;
@end


@implementation ZRTabbarView

- (void)addBtn:(NSString *)normalImage withSelectedImage:(NSString *)selectedImage withIndex:(NSInteger)index{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
//    [button setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [self addSubview:button];
    //添加事件
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //设置tag值
    button.tag = index;
    
}
//布局按钮
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonW = self.frame.size.width / 4.0;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    for (int i = 0; i< self.subviews.count; i++) {
        CGFloat buttonX =  (i * buttonW);
        UIButton *button = self.subviews[i];
        button.frame = CGRectMake(buttonX, buttonY, buttonW,buttonH);
        //默认选中按钮
        if (i == 0) {
            [self btnClick:button];
        }
    }
}

#pragma mark --按钮的点击
- (void)btnClick:(UIButton *)button{
    //先取消选中
    self.selectedBtn.selected = NO;
    //选中
    button.selected = YES;
    //重新赋值
    self.selectedBtn = button;
    
    //切换控制器
    if ([self.myDelegate respondsToSelector:@selector(tabBar:clickBtn:)]) {
        [self.myDelegate tabBar:self clickBtn:button];
    }
    
}

@end
