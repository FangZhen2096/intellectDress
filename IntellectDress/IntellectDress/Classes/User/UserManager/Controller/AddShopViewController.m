//
//  AddShopViewController.m
//  IntellectDress
//
//  Created by zerom on 16/10/24.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "AddShopViewController.h"
#import "StoreModel.h"
#import "ShopChoseCell.h"
@interface AddShopViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (assign,nonatomic)NSInteger count;
@property (strong,nonatomic) NSMutableArray *storeArr;
@property (strong,nonatomic) NSMutableArray *selectedArr;
@property (copy,nonatomic) NSString *ids;
@end

@implementation AddShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationView.backgroundColor = defaultColor;
    self.saveBtn.backgroundColor = defaultColor;
    [self.saveBtn setTitleColor:RGB(186, 251, 225) forState:UIControlStateNormal];
    [self.saveBtn roundWithRadius:6];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setStoreList];
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


#pragma mark --UITableViewDataSource数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopChoseCell *cell = [ShopChoseCell ShopChoseCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    StoreModel *model = [_storeArr objectAtIndex:indexPath.row];
    cell.shopName.text = model.title;
    cell.switchBtn.tag = indexPath.row;
    [cell.switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_selectedArr addObject:cell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark -- 按钮点击action
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)switchBtnClick:(UISwitch *)btn{
    if (btn.on == YES) {
        NSString *ID = [NSString stringWithFormat:@"%ld",btn.tag+1];
        if (_ids == nil) {
            _ids = [NSString stringWithFormat:@"%@",ID];
        }else{
            _ids = [NSString stringWithFormat:@"%@,%@",_ids,ID];
        }
    }else{
        NSString *ID = [NSString stringWithFormat:@"%ld",btn.tag+1];
        NSString *id1 = [NSString stringWithFormat:@",%@",ID];
        NSString *id2 = [NSString stringWithFormat:@"%@,",ID];
        if ([_ids rangeOfString:id1].location != NSNotFound) {
            _ids = [_ids stringByReplacingOccurrencesOfString:id1 withString:@""];
        }else if([_ids rangeOfString:id1].location == NSNotFound && [_ids rangeOfString:id2].location != NSNotFound){
            _ids = [_ids stringByReplacingOccurrencesOfString:id2 withString:@""];
        }else {
            _ids = [_ids stringByReplacingOccurrencesOfString:ID withString:@""];
            if ([_ids isEqualToString:@""]) {
                _ids = nil;
            }
        }
    }
    
    
    NSLog(@"ids ------  %@",_ids);
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
@end
