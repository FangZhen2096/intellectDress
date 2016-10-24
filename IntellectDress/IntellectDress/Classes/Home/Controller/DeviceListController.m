//
//  DeviceListController.m
//  IntellectDress
//
//  Created by zerom on 16/10/9.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "DeviceListController.h"
#import "DeviceCell.h"
#import "DeviceModel.h"
@interface DeviceListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign,nonatomic)NSInteger count;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (strong,nonatomic) NSMutableArray *deviceArr;
@end

@implementation DeviceListController

#pragma mark -- 懒加载
- (NSMutableArray *)deviceArr{
    if (_deviceArr == nil) {
        _deviceArr = [NSMutableArray array];
    }
    return _deviceArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self setDeviceList];
}


- (void)setDeviceList{
    [HomeAjax DeviceListWithShopId:_shopid Success:^(NSDictionary *json) {
        NSArray *results = json[@"results"];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:results.count];
        _count = results.count;
        for (int i =0; i < _count; i++) {
            NSDictionary *dic = [results objectAtIndex:i];
            DeviceModel *model = [DeviceModel DeviceModelWithDict:dic];
            [arr addObject:model];
        }
        _deviceArr = arr;
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark -- UITableview数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeviceCell *cell = [DeviceCell deviceCell:tableView];
    DeviceModel *model = [_deviceArr objectAtIndex:indexPath.row];
    if ([model.online isEqualToString:@"在线"]) {
        [cell.deviceState setTextColor:[UIColor greenColor]];
    }else{
        [cell.deviceState setTextColor:[UIColor redColor]];
        [cell.deviceName setTextColor:[UIColor grayColor]];
    }
    cell.deviceName.text = model.alias;
    cell.deviceNum.text = model.imei;
    cell.deviceState.text = model.online;
    return cell;
}


#pragma mark -- 按钮触发事件
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
