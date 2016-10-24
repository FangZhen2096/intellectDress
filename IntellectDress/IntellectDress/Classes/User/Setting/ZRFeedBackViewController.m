//
//  ZRFeedBackViewController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/5.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRFeedBackViewController.h"

@interface ZRFeedBackViewController ()
/**
 *  反馈信息textView
 */
@property (weak, nonatomic) IBOutlet UITextView *feedBackTextView;
/**
 *  昵称label
 */
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
/**
 *  手机label
 */
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
/**
 *  发送Btn
 */
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
/**
 *  placeholderLabel
 */
@property (nonatomic,strong) UILabel *placeHolderLabel;
@property (nonatomic)UserBiz *biz;
@end

@implementation ZRFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    [self initView];
    [_sendBtn roundWithRadius:6];
    _biz = [[UserBiz alloc] init];
    [_biz base:[UserBiz userId] callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        _nickNameLabel.text = FORMAT(@"%@",json[@"results"][@"nickname"]);
        _phoneLabel.text = FORMAT(@"%@",json[@"results"][@"tel"]);
        
    }];
    [self initPlaceHolderView];

}

- (IBAction)sendBtnClick:(id)sender {
    NSString*text = _feedBackTextView.text;
    if ([text isempty]) {
        [SVProgressHUD showInfoWithStatus:@"请输入反馈内容"];
        return ;
    }
    [_biz feedback:[UserBiz userId] info:text callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        ALERT(FORMAT(@"%@",json[@"info"]));
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)initPlaceHolderView{
    _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 0, 20)];
    _placeHolderLabel.textAlignment = NSTextAlignmentLeft;
    _placeHolderLabel.font = [UIFont systemFontOfSize:14];
    _placeHolderLabel.textColor = [UIColor blackColor];
    _placeHolderLabel.text = @"请输入内容";
    [_feedBackTextView addSubview:_placeHolderLabel];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0 )
    {
        _placeHolderLabel.text = @"请输入内容";
    }
    else
    {
        _placeHolderLabel.text = @"";
    }
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
