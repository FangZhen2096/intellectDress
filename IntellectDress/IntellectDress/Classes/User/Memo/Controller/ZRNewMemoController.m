//
//  ZRNewMemoController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/23.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRNewMemoController.h"

@interface ZRNewMemoController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong,nonatomic) UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UILabel *start;
@property (weak, nonatomic) IBOutlet UILabel *end;
@property (weak, nonatomic) IBOutlet UIButton *markBtn;
@property (copy,nonatomic) NSString *mark;
@property (weak, nonatomic) IBOutlet UIButton *savaBtn;
@property (strong,nonatomic) UILabel *label;

@end

@implementation ZRNewMemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    _start.text = @"开始时间：2016-10-13";
    _end.text = @"结束时间：2016-10-19";
    _mark = @"false";
    _textView.delegate = self;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, 200, 30)];
    label.enabled = NO;
    label.text = @"请填写你的备忘录";
    label.font =  [UIFont systemFontOfSize:17];
    label.textColor = [UIColor lightGrayColor];
    _label = label;
    [self.textView addSubview:label];
}
- (void)addNewMemo{
    [MemoAjax addNewMemoDetailsWithStart:_start.text end:_end.text info:_textView.text mark:_mark Success:^(NSDictionary *dict) {
        
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark -- textView代理方法
- (void) textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [_label setHidden:NO];
    }else{
        [_label setHidden:YES];
    }
}



#pragma mark --按钮点击action
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveBtnClick:(id)sender {
    [self addNewMemo];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)markBtnClick:(id)sender {
    self.markBtn.selected = !self.markBtn.selected;
    if (self.markBtn.selected == YES) {
        _mark = @"true";
    }else{
        _mark = @"false";
    }
}

- (IBAction)menuBtnClick:(id)sender {
    YCXMenuItem *menuTitle = [YCXMenuItem menuItem:@"清除内容" image:[UIImage imageNamed:@"清除"] target:self action:@selector(clearContent)];
    menuTitle.foreColor = [UIColor blackColor];
    
    
    //set logout button
    YCXMenuItem *logoutItem = [YCXMenuItem menuItem:@"删除备忘录" image:[UIImage imageNamed:@"删除2"] target:self action:nil];
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
- (void)clearContent{
    [self.textView setText:@""];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}




@end
