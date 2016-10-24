//
//  ZRStoreChoseController.m
//  IntellectDress
//
//  Created by zerom on 16/9/30.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRStoreChoseController.h"
#import "ShopChoseCell.h"
#import "StoreModel.h"
@interface ZRStoreChoseController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *compareBtn;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign,nonatomic)NSInteger count;
@property (strong,nonatomic) NSMutableArray *storeArr;
@property (strong,nonatomic) NSMutableArray *selectedArr;
@property (strong,nonatomic) NSMutableArray *cellArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (assign,nonatomic)NSInteger selectedCount;

@end

@implementation ZRStoreChoseController



- (void)viewDidLoad {
    [super viewDidLoad];
    _compareBtn.backgroundColor = defaultColor;
    [_compareBtn roundWithRadius:20];
    _navigationView.backgroundColor = defaultColor;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self setStoreList];
    _selectedCount = 0;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)setStoreList{
    [HomeAjax storeManagerWithSuccess:^(NSDictionary *json) {
        NSArray *results = json[@"results"];
        _count = results.count;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_count];
        for (int i = 0; i < _count; i++) {
            NSDictionary *dic = [results objectAtIndex:i];
            StoreModel *model = [StoreModel storeModelWithDict:dic];
            [arr addObject:model];
        }
        _storeArr = arr;
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}


#pragma mark -- UITableViewDataSource数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableViewHeight.constant = _count *50;
    return _count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopChoseCell *cell = [ShopChoseCell ShopChoseCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    StoreModel *model = [_storeArr objectAtIndex:indexPath.row];
    cell.shopName.text = model.title;
    [cell.switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_selectedArr addObject:cell];
    return cell;
}

#pragma mark --按钮点击action
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)compareBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)switchBtnClick:(UISwitch *)btn{
    if (btn.on == YES) {
        _selectedCount++;
    }else{
        _selectedCount--;
    }
}

- (IBAction)confirmBtnClick:(id)sender {
    NSInteger selectedCount = 0;
    if (_selectedCount>0 && _selectedCount <3) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (_selectedCount ==0){
        [SVProgressHUD showInfoWithStatus:@"请选择需要查看的店铺"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else{
        [SVProgressHUD showInfoWithStatus:@"最多只能选择两个店铺"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
    
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


#pragma mark -- 懒加载
- (NSMutableArray *)storeArr{
    if (_storeArr == nil) {
        _storeArr = [NSMutableArray array];
    }
    return _storeArr;
}
- (NSMutableArray *)selectedArr{
    if (_selectedArr == nil) {
        _selectedArr = [NSMutableArray array];
    }
    return _selectedArr;
}
- (NSMutableArray *)cellArr{
    if (_cellArr == nil) {
        _cellArr = [NSMutableArray array];
    }
    return _cellArr;
}


@end
