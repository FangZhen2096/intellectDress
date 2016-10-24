//
//  ResetPwdViewController.m
//  clothesnews
//
//  Created by 小强 on 16/5/18.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "ResetPwdNextViewController.h"
@interface ResetPwdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (nonatomic)UserBiz*biz;
@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_nextBtn roundWithRadius:6];
    _biz = [[UserBiz alloc] init];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextBtnClick:(id)sender {
    NSString*phone = _phoneTextField.text;
    if (![phone isPhone]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号"];
        return;
    }
    [_biz send:phone callback:^(BOOL isError, NSDictionary *json) {
        if(isError){
            return ;
        }
        [self performSegueWithIdentifier:@"resetpwd-resetpwdnext" sender:nil];
    }];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"resetpwd-resetpwdnext"]) {
        ResetPwdNextViewController*next=segue.destinationViewController;
        next.phone = _phoneTextField.text;
    }
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
