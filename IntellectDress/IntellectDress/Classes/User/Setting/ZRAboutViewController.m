//
//  ZRAboutViewController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/5.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRAboutViewController.h"

@interface ZRAboutViewController ()

@end

@implementation ZRAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    [self initView];
}



- (void)initView{
    UINavigationBar* navigationBar = [UINavigationBar appearance];
    navigationBar.barTintColor = GlobalTintColor;
    navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem* barItem=    [UIBarButtonItem appearance];
    UIImage *backButtonImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [barItem setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    [navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    NSDictionary *dict = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"MicrosoftYaHei" size:18.0f]};
    [navigationBar setTitleTextAttributes:dict];
    
}

@end
