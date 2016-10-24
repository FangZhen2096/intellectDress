//
//  UserManagerDataController.m
//  IntellectDress
//
//  Created by zerom on 16/10/10.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "UserManagerDataController.h"
#import "UserDetailsModel.h"
@interface UserManagerDataController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *userDetailsArr;
@property (strong,nonatomic) UserDetailsModel *model;
@property (weak, nonatomic) IBOutlet UILabel *tel;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@end

@implementation UserManagerDataController


#pragma mark -- 懒加载
- (NSMutableArray *)userDetailsArr{
    if (_userDetailsArr == nil) {
        _userDetailsArr = [NSMutableArray array];
    }
    return _userDetailsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _navigationView.backgroundColor = defaultColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self setUserDetailsInfo];
}

- (void)setUserDetailsInfo{
    [UserManagerAjax UserManagerDetailsInfoWithUserid:_userid Success:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        UserDetailsModel *model = [UserDetailsModel UserDetailsModelWithDict:results];
        _model = model;
        _tel.text = model.username;
        _nickName.text = model.nickname;
        _type.text = model.type;
        if ([model.sex integerValue] == 1) {
            _sex.text = @"男";
        }else{
            _sex.text = @"女";
        }
        
        
    } failed:^(NSError *error) {
        
    }];
}


#pragma mark -- UITableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
#pragma mark -- UITableView代理方法

#pragma mark -- 按钮点击action
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//删除用户按钮
- (IBAction)delUserBtnClick:(id)sender {
    [UserManagerAjax DelUserWithDelId:_model.ID Success:^(NSDictionary *dict) {
        
    } failed:^(NSError *error) {
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
}
//添加店铺
- (IBAction)addShop:(id)sender {
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"UserManagerController" bundle:[NSBundle mainBundle] ];
    UserManagerDataController *controller = [board instantiateViewControllerWithIdentifier:@"AddShopViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
