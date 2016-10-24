//
//  ZRHotRankController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/23.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRHotRankController.h"
#import "DisplayCell.h"
#import "ProductAnalyseTryOnModel.h"
#import "ProductAnalyseFittingModel.h"
#import "ProductAnalyseDisplayModel.h"
@interface ZRHotRankController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *hotRankTableView;
@property (weak, nonatomic) IBOutlet UITableView *hotRankTableView2;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *navigationView;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (nonatomic,strong) UIButton *selectedBtn;

@property (strong,nonatomic) ProductAnalyseDisplayModel * productAnalyseDisplayModel;
@property (strong,nonatomic) ProductAnalyseFittingModel *productAnalyseFittingModel;
@property (assign,nonatomic)NSInteger tryOnCount;
@property (assign,nonatomic)NSInteger fittingCount;
@property (strong,nonatomic) NSMutableArray *tryOnArr;
@property (strong,nonatomic) NSMutableArray *fittingArr;
@end

@implementation ZRHotRankController

- (void)viewDidLoad {
    [super viewDidLoad];
    _button1.selected = YES;
    _selectedBtn = _button1;
    _hotRankTableView.dataSource = self;
    _hotRankTableView.delegate = self;
    _hotRankTableView2.dataSource = self;
    _hotRankTableView2.delegate = self;
    _scrollView.delegate = self;
    _navigationView.backgroundColor = defaultColor;
    [self setBtnStyle];
    [self setFittMore];
    [self setTryMore];
}

- (void)setFittMore{
    [AnalyseAjax productAnalyseFittMoreWithSuccess:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        NSArray *list = results[@"list"];
        _fittingCount = list.count;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
        for (int i =0; i <list.count; i++) {
            NSDictionary *resultSub = [list objectAtIndex:i];
            _productAnalyseFittingModel = [ProductAnalyseFittingModel productAnalyseFittingModelWithDict:resultSub];
            [arr addObject:_productAnalyseFittingModel];
        }
        _fittingArr = arr;
        [self.hotRankTableView reloadData];
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)setTryMore{
    [AnalyseAjax productAnalyseTryOnMoreWithSuccess:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        NSArray *list = results[@"list"];
        _tryOnCount = list.count;
        NSLog(@"list.count----%ld",list.count);
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
        for (int i =0; i <list.count; i++) {
            NSDictionary *resultSub = [list objectAtIndex:i];
            _productAnalyseDisplayModel = [ProductAnalyseDisplayModel productAnalyseDisplayModelWithDict:resultSub];
            [arr addObject:_productAnalyseDisplayModel];
        }
        _tryOnArr = arr;
        [self.hotRankTableView2 reloadData];
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark -- UITableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 101) {
        return _fittingCount;
    }else{
        return _tryOnCount;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DisplayCell *cell = [DisplayCell displayCell:tableView];
    if (tableView.tag == 101) {
        ProductAnalyseFittingModel *fitting = [_fittingArr objectAtIndex:indexPath.row];
        [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:fitting.img]];
        [cell.shopNameLabel setText:fitting.title];
        [cell.shopNumLabel setText:fitting.number];
        [cell.shopPriceLabel setText:fitting.price];
        [cell.shopCountLabel setText:fitting.ber];
        if ([fitting.love isEqualToString:@"true"]) {
            cell.likeBtn.selected =YES;
        }else{
            cell.likeBtn.selected =NO;
        }
    }else{
        ProductAnalyseDisplayModel *tryon = [_tryOnArr objectAtIndex:indexPath.row];
        [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:tryon.img]];
        [cell.shopNameLabel setText:tryon.title];
        [cell.shopNumLabel setText:tryon.number];
        [cell.shopPriceLabel setText:tryon.price];
        [cell.shopCountLabel setText:tryon.ber];
        if ([tryon.love isEqualToString:@"true"]) {
            cell.likeBtn.selected =YES;
        }else{
            cell.likeBtn.selected =NO;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark --  UITableViewDelegate代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"AnalyseViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"ProductDetailsController"];
    NSString *gid = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"productDidClick" object:gid];
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark -- 按钮点击触发
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)button1DidClick:(id)sender {
    if (_button1.selected) {
        return;
    }
    _button1.selected = YES;
    _button1.backgroundColor = [UIColor whiteColor];
    _button2.backgroundColor = RGB(51, 174, 182);
    [_button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = CGPointMake(0, 0);
    }];
    
}
- (IBAction)button2DidClick:(id)sender {
    if (_button2.selected) {
        return;
    }
    _button2.selected = YES;
    _button2.backgroundColor = [UIColor whiteColor];
    _button1.backgroundColor = RGB(51, 174, 182);
    [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = CGPointMake(SCREENWIDTH, 0);
    }];
    
}

#pragma mark --UIScrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x >= SCREENWIDTH * 0.5) {
        _selectedBtn.selected = NO;
        _button2.selected = YES;
        _selectedBtn = _button2;
        _button2.backgroundColor = [UIColor whiteColor];
        [_button2 setTitleColor:defaultColor forState:UIControlStateSelected];
        _button1.backgroundColor = RGB(51, 174, 182);
        [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else{
        _selectedBtn.selected = NO;
        _button1.selected = YES;
        _selectedBtn = _button1;
        _button1.backgroundColor = [UIColor whiteColor];
        [_button1 setTitleColor:defaultColor forState:UIControlStateSelected];
        _button2.backgroundColor = RGB(51, 174, 182);
        [_button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
}

- (void)setBtnStyle{
    [_button1 setTitleColor:defaultColor forState:UIControlStateSelected];
    [_button1 setBackgroundColor:[UIColor whiteColor]];
    [_button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button2 setBackgroundColor:RGB(51, 174, 182)];
    [_button1 roundWithRadius:5];
    [_button2 roundWithRadius:5];
    
}
#pragma mark -- 懒加载
- (NSMutableArray *)tryOnArr{
    if (_tryOnArr == nil) {
        _tryOnArr = [NSMutableArray array];
    }
    return _tryOnArr;
}

- (NSMutableArray *)fittingArr{
    if (_fittingArr == nil) {
        _fittingArr = [NSMutableArray array];
    }
    return _fittingArr;
}

@end
