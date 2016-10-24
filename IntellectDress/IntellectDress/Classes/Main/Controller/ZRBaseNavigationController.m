//
//  ZRBaseNavigationController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/2.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRBaseNavigationController.h"

@interface ZRBaseNavigationController ()

@end

@implementation ZRBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//这个方法是在类第一次创建对象的时候调用
// 先调用父类的initialize 然后再调用自己的initialize
+(void)initialize{
    
    if (self == [ZRBaseNavigationController self]) {
        //获得整个项目中的navigationBar对象
        UINavigationBar *navigationBar = [UINavigationBar appearance];
        //设置导航控制器的背景色
        navigationBar.barTintColor = defaultColor;
        //设置字体颜色-修改title的颜色 + 字体大小
        NSDictionary *dict = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"MicrosoftYaHei" size:18.0f]};
        [navigationBar setTitleTextAttributes:dict];
        //设置返回按钮的箭头颜色 -- 也能修改返回按钮的字体颜色
        navigationBar.tintColor = [UIColor whiteColor];
        //设置返回按钮的图片
        UIBarButtonItem* barItem=    [UIBarButtonItem appearance];
        UIImage *backButtonImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [barItem setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
    }
//    NSLog(@"%s",__func__);
    
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    [super pushViewController:viewController animated:YES];
//    
//    if ([viewController.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
//    {
//        viewController.navigationController.interactivePopGestureRecognizer.enabled = YES;
//        viewController.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }
//    
//    if (self.viewControllers.count >1) {
//        
//        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
////        [btn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"("] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//        CGSize size =btn.currentBackgroundImage.size;
//        btn.frame =CGRectMake(0, 0, size.width, size.height-5);
//        viewController.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:btn];
//        
//    }
////    self.navigationBar.barTintColor =[UIColor colorWithRed:103/255.0 green:182/255.0 blue:237/255.0 alpha:1.0f];
////    
//    NSLog(@"----->%@",viewController);
//    
//}
//- (void)click
//{
//    [self popViewControllerAnimated:YES];
//}
@end
