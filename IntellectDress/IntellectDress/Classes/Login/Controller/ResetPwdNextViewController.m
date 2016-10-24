//
//  ResetPwdNextViewController.m
//  clothesnews
//
//  Created by 小强 on 16/5/18.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "ResetPwdNextViewController.h"
#import "CountDownButton.h"
#import "ResetFinalViewController.h"
@interface ResetPwdNextViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet CountDownButton *countDownBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (nonatomic)UserBiz*userBiz;
@property (nonatomic)NSDictionary*tempUserToken;
@end

@implementation ResetPwdNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userBiz = [[UserBiz alloc] init];
    [_countDownBtn startCountDown:^(BOOL isError, NSDictionary *json) {
        
    }];
    [_nextBtn roundWithRadius:6];
    _phoneLabel.text = FORMAT(@"%@****%@",[_phone substringToIndex:4],[_phone substringWithRange:NSMakeRange(_phone.length-4, 4)]);
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextBtnClick:(id)sender {
    NSString*code = _codeTextField.text;
    if ([code isempty]) {
        [SVProgressHUD showInfoWithStatus:@"请输入检验码"];
        return;
    }
    [_userBiz verify:code user:_phone callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        _tempUserToken = json[@"results"];
        [self performSegueWithIdentifier:@"resetpwdnext-resetfinal" sender:nil];
    }];
}

- (IBAction)countDownBtnClick:(id)sender {
    [_userBiz send:_phone callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",json[@"info"])];
        [_countDownBtn startCountDown:^(BOOL isError, NSDictionary *json) {
        }];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"resetpwdnext-resetfinal"]) {
        ResetFinalViewController*resetFinal = segue.destinationViewController;
        resetFinal.data = _tempUserToken;
        resetFinal.phone = _phone;
    }
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
