//
//  ViewController.m
//  clothesnews
//
//  Created by 小强 on 16/5/16.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "MainViewController.h"
#import "FDSlideBar.h"
#import "ArticleBiz.h"
#import "ChildViewController.h"
#import "NewsDetailViewController.h"
@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIView *sildeBarContainer;
@property (nonatomic)FDSlideBar*bar;
@property (nonatomic)ArticleBiz*biz;
@property (nonatomic)NSArray*titles;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic)NSMutableArray*controllers;
@property (nonatomic)BOOL loaded;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewWidth;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic)NSDictionary*detailData;

@end

@implementation MainViewController
//取消右滑返回手势
-(void)viewDidAppear:(BOOL)animated{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //取消tableview默认向下偏移量
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = NO;


    [Config_ set:@"Uesd" value:@(YES)];
    _controllers = [[NSMutableArray alloc] init];
    _bar = [[FDSlideBar alloc] init];
    [_sildeBarContainer addSubview:_bar];
    _biz = [[ArticleBiz alloc] init];
    _bar.backgroundColor = UICOLOR(246, 246, 246, 0);
    _bar.itemColor = UICOLOR(144, 144, 144, 1);
    _bar.itemSelectedColor = GlobalTintColor;
    _bar.sliderColor = GlobalTintColor;
    [_bar slideBarItemSelectedCallback:^(NSUInteger idx) {
        [_scrollView setContentOffset:CGPointMake(idx*SCREENWIDTH, 0) animated:YES];
        ChildViewController*child = _controllers[idx];
        if (!child.loaded) {
            [child reloadData];
        }
    }];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleToDetail:) name:@"ToDetail" object:nil];
    [self initTheme];
    
}


-(void)initTheme{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    UINavigationBar* navigationBar = [UINavigationBar appearance];
    navigationBar.barTintColor = GlobalTintColor;
    navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem* barItem=    [UIBarButtonItem appearance];
    UIImage *backButtonImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [barItem setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    [navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

-(void)handleToDetail:(NSNotification*)notification{
    _detailData = notification.object;
    [self performSegueWithIdentifier:@"home-newsdetail" sender:nil];
}

- (IBAction)searchBtnClick:(id)sender {
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView==_scrollView) {
        NSInteger index=   (NSInteger)(scrollView.contentOffset.x/SCREENWIDTH);
        [_bar selectSlideBarItemAtIndex:index];
        ChildViewController*child = _controllers[index];
        if (!child.loaded) {
            [child reloadData];
        }
        
    }
}
-(void)loadData{
    [_biz type:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        _titles = json[@"results"];
        NSMutableArray*titleStrs = [[NSMutableArray alloc] init];
        //        _scrollView.contentSize = CGSizeMake(SCREENWIDTH*_titles.count, _scrollView.height);
        _containerViewWidth.constant =SCREENWIDTH*_titles.count;
        for (NSInteger i =0 ;i < _titles.count;i++) {
            NSDictionary*item  = _titles[i];
            ChildViewController*child = [self.storyboard instantiateViewControllerWithIdentifier:@"ChildViewController"];
            UIView*childView = child.view;
            [_containerView addSubview:childView];
            [childView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_containerView);
                make.bottom.equalTo(_containerView);
                make.left.equalTo(@(i*SCREENWIDTH));
                make.width.equalTo(@(SCREENWIDTH));
            }];
            child.typeId = FORMAT(@"%@",item[@"id"]);
            if (_loaded) {
                return;
            }else{
                [self addChildViewController:child];
                [_controllers addObject:child];
            }
            
            [titleStrs addObject:FORMAT(@"%@",item[@"title"])];
        }
        _bar.itemsTitle =titleStrs;
        _bar.itemColor = UICOLOR(144, 144, 144, 1);
        _bar.itemSelectedColor = GlobalTintColor;
        _bar.sliderColor = GlobalTintColor;
        _loaded  = YES;
        ChildViewController*child = _controllers[0];
        [child reloadData];
        
    }];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"home-newsdetail"]) {
        NewsDetailViewController*detail = segue.destinationViewController;
        detail.data = _detailData;
    }

}

-(void)dealloc{
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
