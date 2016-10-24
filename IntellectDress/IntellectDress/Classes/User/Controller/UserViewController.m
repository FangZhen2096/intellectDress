//
//  UserViewController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/2.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "UserViewController.h"
#import "ZRLoginViewController.h"
#import "MainViewController.h"
@interface UserViewController ()
//用户头像按钮

@property (weak, nonatomic) IBOutlet UIButton *avatarBtn;

@property (weak, nonatomic) IBOutlet UIView *avatarContainerView;

@property (nonatomic) UserBiz *userBiz;
@property (nonatomic)MessageBiz *messageBiz;
//信息中心数量label
@property (weak, nonatomic) IBOutlet UILabel *messageCountLabel;
//用户昵称label
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
//手机号码label
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
//接受到的字典
@property (nonatomic)NSDictionary *data;
@property (weak, nonatomic) IBOutlet UITableViewCell *avatarCell;
@end

@implementation UserViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =  NO;
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    self.tableView.bounces = NO;
    [_avatarBtn roundWithRadius:_avatarBtn.width/2];
    [_avatarContainerView roundWithRadius:_avatarContainerView.width/2];
    _userBiz = [[UserBiz alloc] init];
    _messageBiz = [[MessageBiz alloc] init];
    _avatarCell.backgroundColor = defaultColor;
    [self loadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
     [self.tabBarController.tabBar setHidden:NO];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}
- (IBAction)settingBtnClick:(id)sender {
    
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"UserViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"ZRSettingViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}


-(void)loadData{
    [_messageBiz unread:[UserBiz userId] callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        if ([FORMAT(@"%@",json[@"results"][@"num"]) isEqualToString:@"0"]) {
            _messageCountLabel.hidden = YES;
            return;
        }
        _messageCountLabel.hidden = NO;
        _messageCountLabel.text = FORMAT(@"%@",json[@"results"][@"num"]);
    }];
    [_userBiz base:[UserBiz userId] callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        _data = json[@"results"];
        [self fill];
    }];
}

-(void)fill{
    _nickNameLabel.text = FORMAT(@"%@",_data[@"nickname"]);
    _nickNameLabel.font=[UIFont systemFontOfSize:20];
    _phoneNumberLabel.text = FORMAT(@"%@",_data[@"tel"]);
    _phoneNumberLabel.font=[UIFont systemFontOfSize:17];
    [_avatarBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:FORMAT(@"%@",_data[@"img"])] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
}


//取消返回按钮的文字
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }else if (section == 1)
    {
        return 3;
    }else if(section == 2)
    {
        return 2;
    }else if(section == 3)
    {
        return 2;
    }else
    {
        return 1;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 4  ) {
        if (indexPath.row == 0) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
            UIStoryboard*board = [UIStoryboard storyboardWithName:@"ZRInfomationViewController" bundle:[NSBundle mainBundle] ];
            UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"MainViewController"];
            [self.navigationController pushViewController:controller animated:YES];
        }
        if (indexPath.row == 1) {
            UIStoryboard*board = [UIStoryboard storyboardWithName:@"ZRInfoCenterViewController" bundle:[NSBundle mainBundle] ];
            UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"MessageCenterViewController"];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            UIStoryboard*board = [UIStoryboard storyboardWithName:@"ZRMemoController" bundle:[NSBundle mainBundle] ];
            UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"ZRMemoController"];
            [self.navigationController pushViewController:controller animated:YES];
        }else if (indexPath.row == 0){
            UIStoryboard*board = [UIStoryboard storyboardWithName:@"MyFocusViewController" bundle:[NSBundle mainBundle] ];
            UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"MyFocusViewController"];
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            
            UIStoryboard*board = [UIStoryboard storyboardWithName:@"HomeViewController" bundle:[NSBundle mainBundle] ];
            UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"DataReportingController"];
            [self.navigationController pushViewController:controller animated:YES];

        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            UIStoryboard*board = [UIStoryboard storyboardWithName:@"UserManagerController" bundle:[NSBundle mainBundle] ];
            UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"UserManagerController"];
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            UIStoryboard*board = [UIStoryboard storyboardWithName:@"HomeViewController" bundle:[NSBundle mainBundle] ];
            UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"ShopManagerViewController"];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    
}


@end
