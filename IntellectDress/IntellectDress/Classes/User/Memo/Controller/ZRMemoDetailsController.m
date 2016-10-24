//
//  ZRMemoDetailsController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/23.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRMemoDetailsController.h"
#import "ZRMemoController.h"
@interface ZRMemoDetailsController ()<ZRMemoControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *markBtn;
@property (copy,nonatomic) NSString *mark;
@property (weak, nonatomic) IBOutlet UILabel *ago;
@property (weak, nonatomic) IBOutlet UILabel *edittime;
@property (weak, nonatomic) IBOutlet UIButton *startAndEndBtn;
@end

@implementation ZRMemoDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    _navigationView.backgroundColor = defaultColor;
    ZRMemoController *memoVc = [[ZRMemoController alloc] init];
    memoVc.delegate = self;
    NSLog(@"bid-----%@",_bid);
    _mark = @"0";
    [self setMemoDetails];
}


- (void)passTrendValues:(NSString *)bid{
    _bid = bid;
    NSLog(@"bid-----%@",_bid);
    [self setMemoDetails];
}

- (void)setMemoDetails{
    [MemoAjax MemoDetailsWithBid:_bid Success:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        [self.textView setText:FORMAT(@"%@",results[@"info"])];
        [self.ago setText:results[@"ago"]];
        [self.edittime setText:results[@"edittime"]];
        [self.startAndEndBtn setTitle:FORMAT(@"汇报时间:%@~%@",results[@"start"],results[@"end"]) forState:UIControlStateNormal];
        
    } failed:^(NSError *error) {
        
    }];
}
#pragma mark --按钮点击action
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)menuBtnClick:(id)sender {
    YCXMenuItem *menuTitle = [YCXMenuItem menuItem:@"清除内容" image:[UIImage imageNamed:@"清除"] target:self action:@selector(clearContent)];
    menuTitle.foreColor = [UIColor blackColor];
    

    YCXMenuItem *logoutItem = [YCXMenuItem menuItem:@"删除备忘录" image:[UIImage imageNamed:@"删除2"] target:self action:@selector(delMemoClick)];
    logoutItem.foreColor = [UIColor blackColor];
    logoutItem.alignment = NSTextAlignmentCenter;
    
    NSArray *items = @[menuTitle,
                       
                       logoutItem
                       ];
    [YCXMenu setTintColor:[UIColor whiteColor]];
    [YCXMenu showMenuInView:self.view fromRect:CGRectMake(_menuBtn.frame.origin.x, _menuBtn.frame.origin.y, 20, 20) menuItems:items selected:^(NSInteger index, YCXMenuItem *item) {
        NSLog(@"%@",item);
    }];
}
//保存备忘录
- (IBAction)saveBtnClick:(id)sender {
   [MemoAjax SaveMemoDetailsWithBid:_bid Info:_textView.text mark:_mark Success:^(NSDictionary *dict) {
       
   } failed:^(NSError *error) {
       
   }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)markBtnClick:(id)sender {
}
//清空文本内容
- (void)clearContent{
    [self.textView setText:@""];
}
//删除备忘录
- (void)delMemoClick{
    [MemoAjax DelMemoDetailsWithBid:_bid Success:^(NSDictionary *dict) {
        
    } failed:^(NSError *error) {
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
