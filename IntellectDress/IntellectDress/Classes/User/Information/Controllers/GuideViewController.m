//
//  GuideViewController.m
//  clothesnews
//
//  Created by 小强 on 16/5/21.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)gomian:(id)sender{
    UINavigationController*mainNavgation = [self.storyboard instantiateViewControllerWithIdentifier:@"MainNavigationViewController"];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainNavgation;
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
