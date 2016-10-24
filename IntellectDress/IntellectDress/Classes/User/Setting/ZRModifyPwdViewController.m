//
//  ZRModifyPwdViewController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/2.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRModifyPwdViewController.h"

@interface ZRModifyPwdViewController ()
/**
 *  显示密码
 */
@property (weak, nonatomic) IBOutlet UIButton *showPwdBtn;
/**
 *  清空密码按钮1
 */
@property (weak, nonatomic) IBOutlet UIButton *clearPwdBtn1;
/**
 *  清空密码按钮2
 */
@property (weak, nonatomic) IBOutlet UIButton *clearPwdBtn2;
/**
 *  清空密码按钮3
 */
@property (weak, nonatomic) IBOutlet UIButton *clearPwdBtn3;
/**
 *  完成按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
/**
 *  原始密码
 */
@property (weak, nonatomic) IBOutlet UITextField *oldPwd;
/**
 *  新密码1
 */
@property (weak, nonatomic) IBOutlet UITextField *NewPwd1;
/**
 *  新密码2
 */
@property (weak, nonatomic) IBOutlet UITextField *NewPwd2;
/**
 *  用户手机label
 */
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (nonatomic)UserBiz*biz;
@end

@implementation ZRModifyPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    _downBtn.layer.cornerRadius = CornerRadius;
    _downBtn.layer.masksToBounds = YES;
    _biz = [[UserBiz alloc] init];
    [_biz base:[UserBiz userId] callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        _phoneLabel.text = FORMAT(@"%@",json[@"results"][@"tel"]);
    }];

    [self initView];
}
- (IBAction)showPwdBtnClick:(id)sender {
    _showPwdBtn.selected = !_showPwdBtn.selected;
    [self showPwd:_showPwdBtn.selected];
}
//完成按钮点击事件
- (IBAction)submitBtnClick:(id)sender {
    NSString*oldPwd = _oldPwd.text;
    if([oldPwd isempty]){
        [SVProgressHUD showInfoWithStatus:@"请输入原始密码"];
        return;
    }
    NSString*newPwd =_NewPwd1.text;
    if ([newPwd isempty]) {
        [SVProgressHUD showInfoWithStatus:@"请输入新密码"];
        return;
    }
    NSString*rePwd = _NewPwd2.text;
    
    if ([rePwd isempty]) {
        [SVProgressHUD showInfoWithStatus:@"请重复输入密码"];
        return;
    }
    if (![rePwd isEqualToString:newPwd]) {
        [SVProgressHUD showInfoWithStatus:@"两次密码不一致"];
        return;
    }
    [_biz editpwd:newPwd repwd:rePwd oldpwd:oldPwd callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        ALERT(FORMAT(@"%@",json[@"info"]));
        [self.navigationController popViewControllerAnimated:YES];
        
    }];

}

/**
 *  显示所有密码为明文或者暗文
 */
- (void)showPwd:(BOOL)showPwdBtnSelected{
    if (showPwdBtnSelected) {
        _oldPwd.secureTextEntry = NO;
        _NewPwd1.secureTextEntry = NO;
        _NewPwd2.secureTextEntry = NO;
    }else{
        _oldPwd.secureTextEntry = YES;
        _NewPwd1.secureTextEntry = YES;
        _NewPwd2.secureTextEntry = YES;
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
