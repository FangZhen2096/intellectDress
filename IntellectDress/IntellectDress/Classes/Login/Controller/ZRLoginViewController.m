//
//  ZRLoginViewController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/2.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRLoginViewController.h"
#import "BaseTabBarController.h"

#define kRememberBtnKey @"rememberBtnKey"
#define kAcountKey @"acountKey"
#define kPasswordKey @"passwordKey"
@interface ZRLoginViewController ()
/**
 *  登陆按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
/**
 *  忘记密码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *forgetPwdBtn;
/**
 *  账户输入栏
 */
@property (weak, nonatomic) IBOutlet UITextField *userCountTextField;
/**
 *  密码输入栏
 */
@property (weak, nonatomic) IBOutlet UITextField *userPwdTextField;
/**
 *  账户label
 */
@property (weak, nonatomic) IBOutlet UILabel *userCount;
/**
 *  显示密码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *showPwdBtn;
/**
 *  密码label
 */
@property (weak, nonatomic) IBOutlet UILabel *pwdLabel;
/**
 *  没有账户，随便看看按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *noCountBtn;

/**
 *  注册按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
/**
 *  记住密码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *rememberBtn;

@property(nonatomic)UserBiz *userBiz;

@end

@implementation ZRLoginViewController


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
}



- (IBAction)rememberBtnClick:(id)sender {
    self.rememberBtn.selected = !self.rememberBtn.selected;
    
}

- (IBAction)loginBtnClick:(id)sender {
    NSString*phone = _userCountTextField.text;
    NSString*pwd = _userPwdTextField.text;
    if ([phone isempty]) {
        [SVProgressHUD showInfoWithStatus:@"请输入手机号"];
        return;
    }
    if (![phone isPhone]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号"];
        return;
    }
    if([pwd isempty]){
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        return;
    }
    [_userBiz login:pwd user:phone callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        [UserBiz setLogined:YES];
        [UserBiz setUserInfo:json];
        NSLog(@"登录json----%@",json);
        [[NSNotificationCenter defaultCenter ] postNotificationName:@"UPDATEARTICLELIST" object:nil];
        BaseTabBarController *base =[[BaseTabBarController alloc] init];
        [self presentViewController:base  animated:YES completion:nil];
        
    }];
}
- (IBAction)noCountBtnClick:(id)sender {
    
    BaseTabBarController *base =[[BaseTabBarController alloc] init];
    [self presentViewController:base  animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化用户信息
    _userBiz = [[UserBiz alloc] init];
    self.loginBtn.enabled = NO;
    self.loginBtn.layer.cornerRadius = CornerRadius;
    self.loginBtn.layer.masksToBounds = YES;
//    self.loginBtn.layer.backgroundColor = [defaultColor CGColor];
    self.loginBtn.backgroundColor =RGB(204, 204, 204);
    [self.loginBtn setTitleColor:RGB(231, 231, 231) forState:UIControlStateDisabled];
    [self.loginBtn setTitleColor:defaultBtnTitleColor forState:UIControlStateNormal];
    self.userCountTextField.font = defaultFont;
    self.userPwdTextField.font = defaultFont;
    self.userCount.font = defaultFont;
    self.pwdLabel.font = defaultFont;
    self.forgetPwdBtn.titleLabel.font = defaultFont;
    self.noCountBtn.titleLabel.font = defaultFont;
    self.registerBtn.titleLabel.font = defaultFont;
    //已进入程序就读取记住密码的设置状态
    [self readLoginSetting];
    //监听键盘输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeValue:) name:UITextFieldTextDidChangeNotification object:nil];
    
}
- (void)textFieldDidChangeValue:(NSNotification *)notification
{
    UITextField *sender = (UITextField *)[notification object];
    if (sender.text.length == 0) {
        self.loginBtn.enabled = NO;
        [self.loginBtn setTitleColor:RGB(231, 231, 231) forState:UIControlStateDisabled];
        self.loginBtn.backgroundColor = RGB(204, 204, 204);
    }else
    {
        self.loginBtn.enabled = YES;
        self.loginBtn.backgroundColor = defaultColor;
        [self.loginBtn setTitleColor:defaultBtnTitleColor forState:UIControlStateNormal];
        
    }
}

- (IBAction)showPwdBtnClick:(id)sender {
    self.showPwdBtn.selected = !self.showPwdBtn.selected ;
    self.userPwdTextField.secureTextEntry  = !self.userPwdTextField.secureTextEntry;
    
}
//保存记住密码设置
- (void)saveLoginSetting{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:self.rememberBtn.selected forKey:kRememberBtnKey];
    //同步操作
    [userDefault synchronize];
}
//读取记住密码设置
- (void)readLoginSetting{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.rememberBtn.selected = [userDefaults boolForKey:kRememberBtnKey];
    if (self.rememberBtn.selected) {
        [self readAcountPassword];
    }
}
//保存账户密码
- (void)saveAcountPassword
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.userCountTextField.text forKey:kAcountKey];
    [userDefault setObject:self.userPwdTextField.text forKey:kPasswordKey];
    //同步操作
    [userDefault synchronize];
}

//读取账户密码
- (void)readAcountPassword
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.userCountTextField.text = [userDefault objectForKey:kAcountKey];
    if (self.rememberBtn.selected) {
        self.userPwdTextField.text = [userDefault objectForKey:kPasswordKey];
    }
    if (self.rememberBtn.selected && self.userPwdTextField.text.length) {
        [self loginBtnClick:nil];
    }
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
