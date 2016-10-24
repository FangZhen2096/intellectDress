//
//  UIView+Kit.m
//  GoodTeacher
//
//  Created by 小强 on 15/5/22.
//  Copyright (c) 2015年 XiaoShang. All rights reserved.
//

#import "UIView+Commons.h"

@implementation UIView (Commons)

- (void)awakeFromNib{
    [super awakeFromNib];
    [self layoutIfNeeded];
}
-(CGFloat)x{
    return self.frame.origin.x;
}
-(CGFloat)centerX{
    return self.center.x;
}
-(CGFloat)centerY{
    return self.center.y;
}
-(CGFloat)y{
    return self.frame.origin.y;
}
-(CGSize)size{
    return self.frame.size;
}
-(CGFloat)width{
    return self.frame.size.width;
}
-(CGFloat)height{
    return self.frame.size.height;
}
-(CGPoint)origin{
    return self.frame.origin;
}
-(void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(void)setOrigin:(CGPoint)origin{
        CGRect frame = self.frame;
        frame.origin = origin;
        self.frame = frame;
}
-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(void)roundWithRadius:(CGFloat) radius{
    CALayer* layer = [self layer];
    layer.cornerRadius = radius;
    layer.masksToBounds = YES;

}
-(void)addBorder{
    CALayer* layer = [self layer];
    layer.borderWidth = 0.5;
    layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

-(void)toRightOf:(UIView*)view distance:(CGFloat)distance{
     CGFloat maxx= CGRectGetMaxX(view.frame);
    self.x = maxx+distance;
}
-(void)toLeftOf:(UIView*)view distance:(CGFloat)distance{
    CGFloat x = view.x;
    self.x=x-self.width-distance;
}
-(void)toTopOf:(UIView*)view distance:(CGFloat)distance{
    self.y=view.y-self.height-distance;
}
-(void)toBottomOf:(UIView*)view distance:(CGFloat)distance{
    self.y =view.y+view.height+distance;
}
-(void)setCenterX:(CGFloat)centerX{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}
-(void)setCenterY:(CGFloat)centerY{
    CGPoint point =self.center;
    point.y = centerY;
    self.center = point;
}
-(void)alignBottomOf:(UIView*)view distance:(CGFloat) distance{
    self.y=view.height-self.height-distance;
}
//add
-(void)roundView{
    [self roundWithRadius:self.width/2];
}
-(void)avatarRound{
    CALayer*layer = [self layer];
    layer.borderColor = [[UIColor whiteColor] CGColor];
    layer.borderWidth = 1;
    [self roundView];
    
}

@end
