//
//  StoreManagerController.m
//  IntellectDress
//
//  Created by zerom on 16/9/30.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "StoreManagerController.h"
#import "StoreCell.h"
#import "StoreModel.h"
@interface StoreManagerController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *cellArr;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (strong,nonatomic) StoreModel *storeModel;
@property (strong,nonatomic) NSMutableArray *storeArr;
@property (assign,nonatomic)NSInteger count;
@end

@implementation StoreManagerController

#pragma mark -- 懒加载
- (NSMutableArray *)storeArr{
    if (_storeArr == nil) {
        _storeArr = [NSMutableArray array];
    }
    return  _storeArr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
    _navigationView.backgroundColor = defaultColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self setStoreList];
}
#pragma mark -- 请求数据
- (void)setStoreList{
    [HomeAjax storeManagerWithSuccess:^(NSDictionary *json) {
        NSArray *results  = json[@"results"];
        _count = results.count;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_count];
        for (int i =0; i<_count; i++) {
            NSDictionary *sub = [results objectAtIndex:i];
            _storeModel = [StoreModel storeModelWithDict:sub];
            [arr addObject:_storeModel];
        }
        _storeArr = arr;
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}
#pragma mark -- tableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreCell *cell = [StoreCell storeCell:tableView];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    _storeModel = [_storeArr objectAtIndex:indexPath.row];
    cell.title.text = _storeModel.title;
    [_cellArr addObject:cell];
    return  cell;
}

#pragma mark -- tableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.choseBtn.hidden = !cell.choseBtn.hidden;
    NSString *cityId = @"";
    _storeModel = [_storeArr objectAtIndex:indexPath.row];
    cityId = _storeModel.weatherid;
    NSString *title = _storeModel.title;
     [[NSNotificationCenter defaultCenter] postNotificationName:@"cityID" object:cityId];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shopName" object:title];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 按钮事件
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 懒加载
- (NSMutableArray *)cellArr{
    if (_cellArr == nil) {
        _cellArr = [NSMutableArray array];
    }
    return _cellArr;
}


@end
