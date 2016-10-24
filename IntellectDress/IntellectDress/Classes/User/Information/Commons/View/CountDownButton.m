//
//  CountDownButton.m
//  BangLi
//
//  Created by 小强 on 15/11/24.
//  Copyright © 2015年 xiaoshag. All rights reserved.
//

#import "CountDownButton.h"
@interface CountDownButton()
@property  NSTimer*timer;
@end
@implementation CountDownButton

-(void)startCountDown:(CallBack)callback{
    self.callback=  callback;
    self.userInteractionEnabled = NO;
    self.countDown = 120;
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(cacluateCountDown) userInfo:nil repeats:YES];
    }
    [self.timer fire];
}
-(void)cacluateCountDown{
    if (self.countDown>1) {
        self.countDown--;
        [self setTitle:[NSString stringWithFormat:@"%ld秒后重发",(long)self.countDown] forState:UIControlStateNormal];
    }else{
        if (self.callback) {
            _callback(NO,@{});
        }
        [self setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        self.countDown = 120;
        [self.timer invalidate];
    }
}
-(void)removeFromSuperview{
    [super removeFromSuperview];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
