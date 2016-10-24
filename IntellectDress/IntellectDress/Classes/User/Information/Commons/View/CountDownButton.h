//
//  CountDownButton.h
//  BangLi
//
//  Created by 小强 on 15/11/24.
//  Copyright © 2015年 xiaoshag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownButton : UIButton
@property (assign,atomic) NSInteger countDown;
@property (strong)CallBack callback;
-(void)startCountDown:(CallBack)callback;
@end
