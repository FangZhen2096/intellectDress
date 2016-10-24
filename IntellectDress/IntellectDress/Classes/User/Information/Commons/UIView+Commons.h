//
//  UIView+Kit.h
//  GoodTeacher
//
//  Created by 小强 on 15/5/22.
//  Copyright (c) 2015年 XiaoShang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Commons)
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
-(void)roundWithRadius:(CGFloat) radius;
-(void)addBorder;
-(void)toRightOf:(UIView*)view distance:(CGFloat) distance;
-(void)toLeftOf:(UIView*)view distance:(CGFloat) distance;
-(void)toTopOf:(UIView*)view distance:(CGFloat) distance;
-(void)toBottomOf:(UIView*)view distance:(CGFloat) distance;
-(void)alignBottomOf:(UIView*)view distance:(CGFloat) distance;
-(void)roundView;
-(void)avatarRound;

@end
