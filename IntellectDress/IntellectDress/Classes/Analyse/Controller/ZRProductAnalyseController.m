//
//  ZRProductAnalyseController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/22.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRProductAnalyseController.h"
#import "DisplayCell.h"
#import "ProductAnalyseTryOnModel.h"
#import "ProductAnalyseFittingModel.h"
#import "ProductCakeModel.h"
@interface ZRProductAnalyseController ()<UITableViewDataSource,UIScrollViewDelegate,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UIImageView *icon1;
@property (weak, nonatomic) IBOutlet UIImageView *icon2;
@property (weak, nonatomic) IBOutlet UIImageView *icon3;
@property (weak, nonatomic) IBOutlet UIImageView *icon4;
@property (weak, nonatomic) IBOutlet UIImageView *icon5;
@property (weak, nonatomic) IBOutlet UIImageView *icon6;
@property (weak, nonatomic) IBOutlet UIImageView *icon7;
@property (weak, nonatomic) IBOutlet UIImageView *icon8;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UITableView *displayTableView;
@property (weak, nonatomic) IBOutlet UITableView *displayTableView2;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIScrollView *displayScrollView;
@property (nonatomic,strong) UIButton *lastBtn;
@property (weak, nonatomic) IBOutlet UIImageView *blackPoint1;
@property (weak, nonatomic) IBOutlet UIImageView *blackPoint2;
@property (weak, nonatomic) IBOutlet UIImageView *blackPoint3;
@property (weak, nonatomic) IBOutlet UIButton *suggestBtn1;
@property (weak, nonatomic) IBOutlet UIButton *suggestBtn2;
@property (weak, nonatomic) IBOutlet UIButton *suggestBtn3;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (strong,nonatomic) ProductAnalyseTryOnModel *productAnalyseTryOnModel;
@property (strong,nonatomic) ProductAnalyseFittingModel *productAnalyseFittingModel;
@property (strong,nonatomic) ProductCakeModel *cakeModel;
@property (assign,nonatomic)NSInteger tryOnCount;
@property (assign,nonatomic)NSInteger fittingCount;
@property (strong,nonatomic) NSMutableArray *tryOnArr;
@property (strong,nonatomic) NSMutableArray *fittingArr;
@property (strong,nonatomic) NSMutableArray *cakeArr;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *productTitle;

@end

@implementation ZRProductAnalyseController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBtnStyle];
    [self setBlackPoint];
    _navigationView.backgroundColor = defaultColor;
    _displayTableView.dataSource = self;
    _displayTableView.delegate = self;
    _displayTableView2.dataSource = self;
    _displayTableView2.delegate = self;
    _displayScrollView.delegate = self;
    _lastBtn = _button1;
    [_suggestBtn1 addTarget:self action:@selector(suggestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_suggestBtn2 addTarget:self action:@selector(suggestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_suggestBtn3 addTarget:self action:@selector(suggestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setProductAnalyseSuggest];
    [self setProductAnalyseTryOn];
    [self setProductAnalyseFitting];
    [self setFittCake];
}

#pragma mark -- 网络请求等方法
- (void)setProductAnalyseSuggest{
    [AnalyseAjax productAnalyseSuggestWithSuccess:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        NSString *startTime = results[@"starttime"];
        NSString *endTime = results[@"endtime"];
        [_startTimeLabel setText:startTime];
        [_endTimeLabel setText:endTime];
        NSArray *advice = results[@"advice"];
        NSDictionary *advice1 = [advice objectAtIndex:0];
        NSDictionary *advice2 = [advice objectAtIndex:1];
        NSDictionary *advice3 = [advice objectAtIndex:2];
        [_suggestBtn1 setTitle:advice1[@"title"] forState:UIControlStateNormal];
        [_suggestBtn1 setTitle:advice2[@"title"] forState:UIControlStateNormal];
        [_suggestBtn1 setTitle:advice3[@"title"] forState:UIControlStateNormal];
    } failed:^(NSError *error) {
        
    }];
}

- (void)setProductAnalyseTryOn{
    [AnalyseAjax productAnalyseTryOnWithStartTime:_startTimeLabel.text endtime:_endTimeLabel.text Success:^(NSDictionary *dict) {
        NSArray *results = dict[@"results"];
        _tryOnCount = results.count;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:results.count];
        for (int i =0; i <results.count; i++) {
            NSDictionary *resultSub = [results objectAtIndex:i];
            _productAnalyseTryOnModel = [ProductAnalyseTryOnModel productAnalyseTryOnModelWithDict:resultSub];
            [arr addObject:_productAnalyseTryOnModel];
        }
        _tryOnArr = arr;
        [self.displayTableView2 reloadData];
    } failed:^(NSError *error) {
        
    }];
}

- (void)setProductAnalyseFitting{
    [AnalyseAjax productAnalyseFittingWithStartTime:_startTimeLabel.text endtime:_endTimeLabel.text Success:^(NSDictionary *dict) {
        NSArray *results = dict[@"results"];
        _fittingCount = results.count;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:results.count];
        for (int i =0; i <results.count; i++) {
            NSDictionary *resultSub = [results objectAtIndex:i];
            _productAnalyseFittingModel = [ProductAnalyseFittingModel productAnalyseFittingModelWithDict:resultSub];
            [arr addObject:_productAnalyseFittingModel];
        }
        _fittingArr = arr;
        [self.displayTableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}
- (void)setFittCake{
    [AnalyseAjax productAnalyseFittCakeWithStartTime:_startTimeLabel.text endtime:_endTimeLabel.text Success:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        NSDictionary *total = results[@"total"];
        NSString *num = total[@"num"];
        [_num setText:num];
        NSString *title = total[@"title"];
        [_productTitle setText:title];
        NSArray *list = results[@"list"];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
        for (int i = 0; i<list.count; i++) {
            NSDictionary *listSub = [list objectAtIndex:i];
            _cakeModel = [ProductCakeModel productCakeWithDict:listSub];
            [arr addObject:_cakeModel];
        }
        if (_cakeArr.count >0) {
            [_cakeArr removeAllObjects];
            _cakeArr = arr;
        }else{
            _cakeArr = arr;
        }
        [self setCircleView];
        [self.circleView setNeedsDisplay];
    } failed:^(NSError *error) {
        
    }];
}

- (void)setTryCake{
    [AnalyseAjax productAnalyseTryCakeCakeWithStartTime:_startTimeLabel.text endtime:_endTimeLabel.text Success:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        NSDictionary *total = results[@"total"];
        NSString *num = total[@"num"];
        [_num setText:num];
        NSString *title = total[@"title"];
        [_productTitle setText:title];
        NSArray *list = results[@"list"];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
        for (int i = 0; i<list.count; i++) {
            NSDictionary *listSub = [list objectAtIndex:i];
            _cakeModel = [ProductCakeModel productCakeWithDict:listSub];
            [arr addObject:_cakeModel];
        }
        if (_cakeArr.count >0) {
            [_cakeArr removeAllObjects];
            _cakeArr = arr;
        }else{
            _cakeArr = arr;
        }
        [self setCircleView];
        [self.circleView setNeedsDisplay];
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark -- 按钮点击触发
- (void)suggestBtnClick:(UIButton *)btn{
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"AnalyseViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"LoadSuggestWebController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)button2Click:(id)sender {
    if (_button2.selected) {
        return;
    }
    _button2.selected = !_button2.selected;
    [UIView animateWithDuration:0.5 animations:^{
        _displayScrollView.contentOffset = CGPointMake(375, 0);
    }];
    [self setProductAnalyseTryOn];
    [self setTryCake];
}
- (IBAction)button1Click:(id)sender {
    if (_button1.selected) {
        return;
    }
    _button1.selected = !_button1.selected;
    [UIView animateWithDuration:0.5 animations:^{
        _displayScrollView.contentOffset = CGPointMake(0, 0);
    }];
    [self setProductAnalyseFitting];
    [self setFittCake];
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)dateBtnClick:(id)sender {
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"ReportViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"ZRTimeCompareController"];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -- UITableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView.tag == 102 ) {
        return  _tryOnCount;
    }else{
        return _fittingCount;
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

#pragma  mark -- UIScrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x > SCREENWIDTH * 0.5) {
        _lastBtn.selected = NO;
        _button2.selected = YES;
        _lastBtn = _button2;
    }else{
        _lastBtn.selected = NO;
        _button1.selected = YES;
        _lastBtn = _button1;
    }
}

#pragma mark -- 视图加载
- (void)setBtnStyle{
    [_button1 setTitleColor:RGB(176, 176, 176) forState:UIControlStateNormal];
    [_button1 setTitleColor:defaultColor forState:UIControlStateSelected];
    [_button2 setTitleColor:RGB(176, 176, 176) forState:UIControlStateNormal];
    [_button2 setTitleColor:defaultColor forState:UIControlStateSelected];
}

- (void)setCircleView{
//    for (UIView *view in self.circleView.subviews) {
//        [view removeFromSuperview];
//    }
    NSArray *iconArr = @[_icon1,_icon2,_icon3,_icon4,_icon5,_icon6,_icon7,_icon8];
    NSMutableArray *item = [NSMutableArray arrayWithCapacity:8];
    for (int i = 0; i < 8; i++) {
        ProductCakeModel *cakeModel = [_cakeArr objectAtIndex:i];
       [item addObject: [PNPieChartDataItem dataItemWithValue:[cakeModel.pre floatValue] color:[UIColor colorWithHexString:cakeModel.color] description:cakeModel.name]];
        UIImageView *icon = iconArr[i];
        icon.backgroundColor = [UIColor colorWithHexString:cakeModel.color];
    }
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(79, 56, 220, 220) items:item];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    [pieChart strokeChart];
    [_circleView addSubview:pieChart];
}
- (void)setBlackPoint{
    self.blackPoint1.layer.cornerRadius = 3;
    self.blackPoint1.layer.masksToBounds = YES;
    self.blackPoint2.layer.cornerRadius = 3;
    self.blackPoint2.layer.masksToBounds = YES;
    self.blackPoint3.layer.cornerRadius = 3;
    self.blackPoint3.layer.masksToBounds = YES;
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.tabBar.hidden = YES;
}
//取消返回按钮的文字
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
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

- (NSMutableArray *)cakeArr{
    if (_cakeArr == nil) {
        _cakeArr = [NSMutableArray array];
    }
    return _cakeArr;
}

@end
