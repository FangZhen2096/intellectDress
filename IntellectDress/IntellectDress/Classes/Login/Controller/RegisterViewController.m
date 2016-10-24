//
//  RegisterViewController.m
//  clothesnews
//
//  Created by 小强 on 16/5/18.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "RegisterViewController.h"
#import "CountDownButton.h"
#import "WebViewController.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet CountDownButton *countDownBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (nonatomic)UserBiz*userBiz;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_registBtn roundWithRadius:6];
    _userBiz = [[UserBiz alloc] init];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)countdownBtnClick:(id)sender {
    NSString*phone = _phoneTextField.text;
    if (![phone isPhone]) {
        [SVProgressHUD showInfoWithStatus:@"输入正确的手机号"];
        return;
    }
    [_userBiz send:phone callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",json[@"info"])];
        [_countDownBtn startCountDown:^(BOOL isError, NSDictionary *json) {
        }];
    }];
}
- (IBAction)protocolBtnClick:(id)sender {
    WebViewController*webController = [[WebViewController alloc] init];
    webController.navTitle = @"智能经营宝协议";
    webController.url = @"http://m.ba-mgt.com/protocol";
    [self.navigationController pushViewController:webController animated:YES];
}

- (IBAction)eyepwdBtn:(UIButton*)sender {
    sender.selected = !sender.selected;
    _pwdTextField.secureTextEntry =!sender.selected;
}
- (IBAction)eyerepwdBtnClick:(UIButton*)sender {
    sender.selected = !sender.selected;
    _rePwdTextField.secureTextEntry =!sender.selected;
}
- (IBAction)submitBtnClick:(id)sender {
    NSString*userName = _userNameTextField.text;
    if ([userName isempty]) {
        [SVProgressHUD showInfoWithStatus:@"输入你的名称"];
        return;
    }
    NSString*phone = _phoneTextField.text;
    if (![phone isPhone]) {
        [SVProgressHUD showInfoWithStatus:@"输入正确的手机号"];
        return;
    }
    NSString*pwd = _pwdTextField.text;
    NSString*repwd = _rePwdTextField.text;
    if ([pwd isempty]) {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        return;
    }
    if([repwd isempty]){
        [SVProgressHUD showInfoWithStatus:@"重复输入密码"];
        return;
    }
    if (![pwd isEqualToString:repwd]) {
        [SVProgressHUD showInfoWithStatus:@"两次密码不一致"];
        return;
    }
    
    NSString*code = _codeTextField.text;
    if ([code isempty]) {
        [SVProgressHUD showInfoWithStatus:@"请输入短信验证码"];
        return;
    }
    [_userBiz reg:code name:userName pwd:pwd repwd:repwd user:phone callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        [SVProgressHUD showSuccessWithStatus:FORMAT(@"%@",json[@"info"])];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}


@end
