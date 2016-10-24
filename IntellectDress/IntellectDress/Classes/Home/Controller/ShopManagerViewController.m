//
//  ShopManagerViewController.m
//  IntellectDress
//
//  Created by zerom on 16/10/8.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ShopManagerViewController.h"
#import "ShopViewCell.h"
#import "BottomViewCell.h"
#import "StoreModel.h"
#import "ShopDetailsDataController.h"
#import "DeviceListController.h"
#import "UserBaseInfoModel.h"
@interface ShopManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) UISwitch *mySwitch1;
@property (strong,nonatomic) UISwitch *mySwitch2;
@property (strong,nonatomic) UISwitch *mySwitch3;
@property (strong,nonatomic) NSMutableArray *ShopArr;
@property (assign,nonatomic)NSInteger count;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *addShopBtn;
@property (assign,nonatomic)BOOL addYesOrNo;
@property (weak, nonatomic) IBOutlet UIButton *avatarBtn;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userType;
@property (weak, nonatomic) IBOutlet UILabel *userCount;

@end

@implementation ShopManagerViewController

#pragma mark --懒加载
- (NSMutableArray *)ShopArr{
    if (_ShopArr == nil) {
        _ShopArr = [NSMutableArray array];
    }
    return _ShopArr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setShopList];
    [self setUserBaseInfo];
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


- (void)setShopList{
    [HomeAjax storeManagerWithSuccess:^(NSDictionary *json) {
        NSArray *results = json[@"results"];
        NSMutableArray *arr =[NSMutableArray arrayWithCapacity:results.count];
        _count = results.count;
        for (int i = 0; i<results.count; i++) {
            NSDictionary *sub = [results objectAtIndex:i];
            StoreModel *model = [StoreModel storeModelWithDict:sub];
            [arr addObject:model];
        }
        _ShopArr = arr;
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark --UITableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (_mySwitch1.on == NO){
            if (_mySwitch2.on == NO && _mySwitch3.on == NO) {
                self.tableViewHeight.constant = 150;
                return 1;
            }else if(_mySwitch2.on == YES && _mySwitch3.on == YES){
                self.tableViewHeight.constant = 350;
                return 1;
            }else{
                self.tableViewHeight.constant = 250;
                return 1;
            }
        }else{
            if ( _mySwitch2.on == NO && _mySwitch3.on == NO) {
                self.tableViewHeight.constant = 250;
                return 3;
            }else if(_mySwitch2.on == YES && _mySwitch3.on == YES){
                self.tableViewHeight.constant = 450;
                return 3;
            }else{
                self.tableViewHeight.constant = 350;
                return 3;
            }
        }
    }else if(section == 1){
        if (_mySwitch2.on == NO) {
            if (_mySwitch1.on == NO && _mySwitch3.on == NO) {
                self.tableViewHeight.constant = 150;
                return 1;
            }else if(_mySwitch1.on == YES && _mySwitch3.on == YES){
                self.tableViewHeight.constant = 350;
                return 1;
            }else{
                self.tableViewHeight.constant = 250;
                return 1;
            }
        }else{
            if (_mySwitch1.on == NO && _mySwitch3.on == NO) {
                self.tableViewHeight.constant =250;
                return 3;
            }else if(_mySwitch1.on == YES && _mySwitch3.on == YES){
                self.tableViewHeight.constant = 450;
                return 3;
            }else{
                self.tableViewHeight.constant = 350;
                return 3;
            }
        }
    }else{
        if (_mySwitch3.on == NO) {
            if (_mySwitch1.on == NO && _mySwitch2.on == NO) {
                self.tableViewHeight.constant = 150;
                return 1;
            }else if(_mySwitch1.on == YES && _mySwitch2.on == YES){
                self.tableViewHeight.constant = 350;
                return 1;
            }else{
                self.tableViewHeight.constant = 250;
                return 1;
            }
        }else{
            if (_mySwitch1.on == NO && _mySwitch2.on == NO) {
                self.tableViewHeight.constant =250;
                return 3;
            }else if(_mySwitch1.on == YES && _mySwitch3.on == YES){
                self.tableViewHeight.constant = 450;
                return 3;
            }else{
                self.tableViewHeight.constant = 350;
                return 3;
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        StoreModel *model = [_ShopArr objectAtIndex:indexPath.section];
        if (indexPath.row == 0) {
            ShopViewCell *cell  = [ShopViewCell shopViewCell:tableView];
            cell.storeNameLabel.text = model.title;
            UISwitch *mySwitch1 = [[UISwitch alloc] init];
            mySwitch1.frame = CGRectMake(300, 15, 42, 23);
            [mySwitch1 setOnTintColor:defaultColor];
            [mySwitch1 addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            _mySwitch1 = mySwitch1;
            [cell addSubview:mySwitch1];
            return cell;
        }else if (indexPath.row == 1){
            BottomViewCell *cell = [BottomViewCell bottomViewCell:tableView];
            cell.titleLabel.text = @"店铺管理";
            return cell;
        }else{
            BottomViewCell *cell = [BottomViewCell bottomViewCell:tableView];
            cell.titleLabel.text = @"设备列表";
            return cell;
        }
    }else if(indexPath.section == 1){
         StoreModel *model = [_ShopArr objectAtIndex:indexPath.section];
        if (indexPath.row == 0) {
            ShopViewCell *cell  = [ShopViewCell shopViewCell:tableView];
            cell.storeNameLabel.text = model.title;
            UISwitch *mySwitch = [[UISwitch alloc] init];
            mySwitch.frame = CGRectMake(300, 15, 42, 23);
            [mySwitch setOnTintColor:defaultColor];
            [mySwitch addTarget:self action:@selector(switchBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
            _mySwitch2 = mySwitch;
            [cell addSubview:mySwitch];
            return cell;
        }else if (indexPath.row == 1){
            BottomViewCell *cell = [BottomViewCell bottomViewCell:tableView];
            cell.titleLabel.text = @"店铺管理";
            return cell;
        }else{
            BottomViewCell *cell = [BottomViewCell bottomViewCell:tableView];
            cell.titleLabel.text = @"设备列表";
            return cell;
        }

    }else{
        StoreModel *model = [_ShopArr objectAtIndex:indexPath.section];
        if (indexPath.row == 0) {
            ShopViewCell *cell  = [ShopViewCell shopViewCell:tableView];
            cell.storeNameLabel.text = model.title;
            UISwitch *mySwitch = [[UISwitch alloc] init];
            mySwitch.frame = CGRectMake(300, 15, 42, 23);
            [mySwitch setOnTintColor:defaultColor];
            [mySwitch addTarget:self action:@selector(switchBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
            _mySwitch3 = mySwitch;
            [cell addSubview:mySwitch];
            return cell;
        }else if (indexPath.row == 1){
            BottomViewCell *cell = [BottomViewCell bottomViewCell:tableView];
            cell.titleLabel.text = @"店铺管理";
            return cell;
        }else{
            BottomViewCell *cell = [BottomViewCell bottomViewCell:tableView];
            cell.titleLabel.text = @"设备列表";
            return cell;

    }

}
}
#pragma mark -- UITableview的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row == 1) {
            UIStoryboard *board = [UIStoryboard storyboardWithName:@"HomeViewController" bundle:[NSBundle mainBundle]];
            ShopDetailsDataController *VC = [board instantiateViewControllerWithIdentifier:@"ShopDetailsDataController"];
            StoreModel *model = [_ShopArr objectAtIndex:indexPath.section];
            VC.shopid = model.ID;
            [self.navigationController pushViewController:VC animated:YES];
        }
        if (indexPath.row == 2) {
            UIStoryboard *board = [UIStoryboard storyboardWithName:@"HomeViewController" bundle:[NSBundle mainBundle]];
            DeviceListController *VC = [board instantiateViewControllerWithIdentifier:@"DeviceListController"];
            StoreModel *model = [_ShopArr objectAtIndex:indexPath.section];
            VC.shopid = model.ID;
            [self.navigationController pushViewController:VC animated:YES];
        }
    
}

#pragma mark -- 按钮点击事件
- (IBAction)addShopBtnClick:(id)sender {
    if ([_addShopBtn.titleLabel.text isEqualToString:@"添加店铺"]) {
        _addYesOrNo = YES;
        [_addShopBtn setTitle:@"取消添加" forState:UIControlStateNormal];

    }else{
        _addYesOrNo = NO;
        [_addShopBtn setTitle:@"添加店铺" forState:UIControlStateNormal];

    }
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)switchBtnClick:(UISwitch *)sender{
    
        if (sender.on == YES) {
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            for (int i =1; i < 3; i++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [indexPaths addObject: indexPath];
            }
//            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
//            [self.tableView endUpdates];
        }else{
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            for (int i =1; i < 3; i++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [indexPaths addObject: indexPath];
            }
            
            [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        }
    

}

- (void)switchBtnClick1:(UISwitch *)sender{
    
    if (sender.on == YES) {
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        for (int i =1; i < 3; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:1];
            [indexPaths addObject: indexPath];
        }
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }else{
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        for (int i =1; i < 3; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:1];
            [indexPaths addObject: indexPath];
        }
        
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }


}
- (void)switchBtnClick2:(UISwitch *)sender{
        
        if (sender.on == YES) {
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            for (int i =1; i < 3; i++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:2];
                [indexPaths addObject: indexPath];
            }
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
        }else{
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            for (int i =1; i < 3; i++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:2];
                [indexPaths addObject: indexPath];
            }
            
            [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        }
        
        
    }

@end


