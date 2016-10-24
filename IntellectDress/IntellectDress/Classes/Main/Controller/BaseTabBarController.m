//
//  BaseTabBarController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/2.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "BaseTabBarController.h"
#import "ZRTabbarView.h"
#import "ZRBaseNavigationController.h"
#import "HomeViewController.h"
#import "ReportViewController.h"
#import "AnalyseViewController.h"
#import "UserViewController.h"
@interface BaseTabBarController ()<ZRTabBarViewDelegate>
@property (nonatomic,weak) ZRTabbarView *tabBarView;
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  添加子控制器
     */
    [self setBaseController:@"HomeViewController"];
    [self setBaseController:@"ReportViewController"];
    [self setBaseController:@"AnalyseViewController"];
    [self setBaseController:@"UserViewController"];
    
    
    //创建自定义的tabBar
    ZRTabbarView *tabBar = [[ZRTabbarView alloc] init];
    tabBar.frame  = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    self.tabBarView = tabBar;
    
    //设置图片
    //作用:就是要创建多少个子控制器,提供背景图片
    for (int i = 0; i < self.childViewControllers.count; i++) {

        NSString *imageName = [NSString stringWithFormat:@"TabBar%d",i+1];
        NSString *imageNameSelected = [NSString stringWithFormat:@"TabBar%dSel",i+1];
        [tabBar addBtn:imageName withSelectedImage:imageNameSelected withIndex:i];
    }
    
    //设置代理
    tabBar.myDelegate = self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //把某个子View提到顶部位置
    [self.tabBar bringSubviewToFront:self.tabBarView];
}

//方法就是用来添加子控制器的
- (void)setBaseController:(NSString *)sbName{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    //直接在sb中嵌入navigation可以使在加载完成后只加载第一个控制器的导航条,跳转时才再加载
        UIViewController *sbVc =  sb.instantiateInitialViewController;
        [self addChildViewController:sbVc];
    
    
}

- (void)tabBar:(ZRTabbarView *)tabBar clickBtn:(UIButton *)selectedBtn{
    //选中当前的子控制器
    self.selectedIndex = selectedBtn.tag;
    //一样
    //    self.selectedViewController = self.childViewControllers[selectedBtn.tag];
}

@end
