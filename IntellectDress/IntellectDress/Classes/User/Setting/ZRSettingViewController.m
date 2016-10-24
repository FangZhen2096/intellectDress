//
//  ZRSettingViewController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/7.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRSettingViewController.h"

@interface ZRSettingViewController ()

@end

@implementation ZRSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}
//取消右滑返回手势
-(void)viewDidAppear:(BOOL)animated{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//
//    // Configure the cell...
//
//    return cell;
//}




@end
