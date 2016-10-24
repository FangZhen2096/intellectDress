//
//  ShopDetailsDataController.m
//  IntellectDress
//
//  Created by zerom on 16/10/9.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ShopDetailsDataController.h"
#import "KPTimePicker.h"
#import "ShopDetailsModel.h"
#import "ShopDetailsCell.h"
@interface ShopDetailsDataController ()<UITableViewDataSource,UITableViewDelegate,KPTimePickerDelegate>
//保存按钮
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UITableView *shopDataTableView;
@property (weak, nonatomic) IBOutlet UITableView *managerDataTableView;
@property (strong,nonatomic) UITableViewCell *cell;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (strong,nonatomic) NSMutableArray *shopModelArr;
@property (strong,nonatomic) UITextView *opens;
@property (strong,nonatomic) UITextView *closed;
@property (strong,nonatomic) UITextView *info;
@property (strong,nonatomic) UITextView *contact;
@end

@implementation ShopDetailsDataController

#pragma mark -- 懒加载

- (NSMutableArray *)shopModelArr{
    if (_shopModelArr == nil) {
        _shopModelArr = [NSMutableArray array];
    }
    return _shopModelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _navigationView.backgroundColor = defaultColor;
    _saveBtn.backgroundColor = defaultColor;
    [_saveBtn setTitleColor:RGB(186, 251, 255) forState:UIControlStateNormal];
    [_saveBtn roundWithRadius:6];
    _shopDataTableView.dataSource =self;
    _shopDataTableView.delegate = self;
    _managerDataTableView.dataSource = self;
    _managerDataTableView.delegate = self;
    [self setShopDetails];
}

- (void)setShopDetails{
    [HomeAjax shopDetailsWithShopId:_shopid Success:^(NSDictionary *json) {
        NSDictionary *results = json[@"results"];
        _shopName.text = results[@"title"];
        ShopDetailsModel *model = [ShopDetailsModel ShopDetailsModelWithDict:results];
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:model];
        _shopModelArr = arr;
        NSLog(@"_shopModelArr.count--------%ld",_shopModelArr.count);
        [self.shopDataTableView reloadData];
        [self.managerDataTableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark -- UITableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopDetailsModel *model = [_shopModelArr objectAtIndex:0];
    ShopDetailsCell *cell =[ShopDetailsCell ShopDetailsCell:tableView];
    if (tableView.tag == 100) {
        if (indexPath.row == 0) {
            cell.titleLabel.text =@"开店时间";
            cell.textView.text = model.opens;
            [cell.timeLabel setHidden:YES];
            _opens = cell.textView;
        }else if(indexPath.row == 1){
            cell.titleLabel.text = @"关店时间";
            cell.textView.text = model.closed;
            [cell.timeLabel setHidden:YES];
            _closed = cell.textView;
        }else if (indexPath.row == 2){
            cell.titleLabel.text = @"店铺介绍";
            cell.textView.text = model.info;
            [cell.timeLabel setHidden:YES];
            _info = cell.textView;
        }else{
            cell.titleLabel.text = @"联系方式";
            cell.textView.text = model.contact;
            [cell.timeLabel setHidden:YES];
            _contact = cell.textView;
        }
    }else{
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"经营者";
            cell.timeLabel.text = model.admin;
            [cell.pencilImage setHidden:YES];
            [cell.textView setHidden:YES];
        }else if (indexPath.row == 1){
            cell.titleLabel.text = @"手机号";
            cell.timeLabel.text = model.tel;
            [cell.pencilImage setHidden:YES];
            [cell.textView setHidden:YES];
        }else if (indexPath.row == 2){
            cell.titleLabel.text = @"城市";
            cell.timeLabel.text = model.city;
            [cell.pencilImage setHidden:YES];
            [cell.textView setHidden:YES];
        }else{
            cell.titleLabel.text = @"详细地址";
            cell.timeLabel.text = model.address;
            [cell.pencilImage setHidden:YES];
            [cell.textView setHidden:YES];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cell = cell;
    return cell;
}

#pragma mark -- UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag ==100) {
        if (indexPath.row == 2) {
            return 81;
        }else{
            return 47;
        }
    }
    return 47;
}


#pragma mark -- 按钮触发事件
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)saveBtnClick:(id)sender {
    [HomeAjax shopDetailsEditWithOpens:_opens.text closed:_closed.text info:_info.text contact:_contact.text shopid:_shopid Success:^(NSDictionary *json) {
        
    } failed:^(NSError *error) {
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)startTimeBtnClick:(id)sender {

}

- (IBAction)stopTimeBtnClick:(id)sender {
}




@end
