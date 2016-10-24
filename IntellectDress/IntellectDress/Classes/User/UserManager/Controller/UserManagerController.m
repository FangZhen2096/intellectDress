//
//  UserManagerController.m
//  IntellectDress
//
//  Created by zerom on 16/10/9.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "UserManagerController.h"
#import "ManagerCell.h"
#import "UserTypeModel.h"
#import "UserBaseInfoModel.h"
#import "UserManagerDataController.h"
@interface UserManagerController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign,nonatomic)NSInteger count;
@property (strong,nonatomic) NSMutableArray *managerArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *avatarBtn;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userType;
@property (weak, nonatomic) IBOutlet UILabel *userCount;
@end

@implementation UserManagerController

#pragma mark -- 懒加载
- (NSMutableArray *)managerArr{
    if (_managerArr == nil) {
        _managerArr = [NSMutableArray array];
    }
    return _managerArr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self setUserBaseInfo];
    [self setUserList];
}

- (void)setUserBaseInfo{
    [UserManagerAjax UserBaseInfoWithSuccess:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        UserBaseInfoModel *model = [UserBaseInfoModel UserBaseInfoModelWithDict:results];
        [_avatarBtn sd_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal];
        [_avatarBtn roundWithRadius:36];
        _userName.text = model.nickname;
        _userType.text = model.type;
        _userCount.text = FORMAT(@"账号：%@",model.username);
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)setUserList{
    [UserManagerAjax UserListWithSuccess:^(NSDictionary *dict) {
        NSArray *results = dict[@"results"];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:results.count];
        _count = results.count;
        for (int i = 0; i < results.count; i++) {
            NSDictionary *sub = [results objectAtIndex:i];
            UserTypeModel *model = [UserTypeModel UserTypeModelWithDict:sub];
            [arr addObject:model];
        }
        _managerArr = arr;
        [self.tableView reloadData];
        
    } failed:^(NSError *error) {
        
    }];
}


#pragma mark -- UITableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableViewHeight.constant = _count * 47.0;
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ManagerCell *cell = [ManagerCell managerCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UserTypeModel *model = [_managerArr objectAtIndex:indexPath.row];
    cell.managerNameLabel.text = model.nickname;
    if ([model.typeId isEqualToString:@"3"]) {
        cell.managerJobLabel.text = @"分析员";
    }else{
        cell.managerJobLabel.text = @"店长";
    }
    return cell;
}
#pragma mark -- UITableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"UserManagerController" bundle:[NSBundle mainBundle] ];
    UserManagerDataController *controller = [board instantiateViewControllerWithIdentifier:@"UserManagerDataController"];
    UserTypeModel *model = [_managerArr objectAtIndex:indexPath.row];
    controller.userid = model.ID;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -- 按钮触发事件
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//取消右滑返回手势
-(void)viewDidAppear:(BOOL)animated{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [self setUserList];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
@end
