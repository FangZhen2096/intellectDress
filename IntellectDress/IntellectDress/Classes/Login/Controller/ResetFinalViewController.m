//
//  ResetFinalViewController.m
//  clothesnews
//
//  Created by 小强 on 16/5/18.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "ResetFinalViewController.h"

@interface ResetFinalViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *repwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (nonatomic)UserBiz*biz;

@end

@implementation ResetFinalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_finishBtn roundWithRadius:4];
    _phoneLabel.text = FORMAT(@"用户账号 :   %@",_phone );
    _biz= [[UserBiz alloc] init];
}
- (IBAction)showPwdBtnClick:(UIButton*)sender {
    sender.selected = !sender.selected;
    _pwdTextField.secureTextEntry = _repwdTextField.secureTextEntry = !sender.selected;
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)finishBtbClick:(id)sender {
    NSString*pwd = _pwdTextField.text;
    NSString*repwd = _repwdTextField.text;
    if ([pwd isempty]) {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        return;
    }
    if ([repwd isempty]) {
        [SVProgressHUD showInfoWithStatus:@"请重复输入密码"];
        return;
    }
    if (![repwd isEqualToString:pwd]) {
        [SVProgressHUD showInfoWithStatus:@"两次密码不一致"];
        return;
    }
    
    [_biz repwd:pwd  repwd:repwd  user:_phone token:_data[@"token"] userid:_data[@"userid"] callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        ALERT(FORMAT(@"%@",json[@"info"]));
        [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",json[@"info"])];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
