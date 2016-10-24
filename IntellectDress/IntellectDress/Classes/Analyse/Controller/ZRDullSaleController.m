//
//  ZRDullSaleController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/22.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRDullSaleController.h"
#import "DisplayCell.h"
#import "DullSaleListModel.h"
#import "ProductCakeModel.h"
#import "ProductAnalyseFittingModel.h"
@interface ZRDullSaleController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;
@property (weak, nonatomic) IBOutlet UIProgressView *progress1;
@property (weak, nonatomic) IBOutlet UIProgressView *progress2;
@property (weak, nonatomic) IBOutlet UIProgressView *progress3;
@property (weak, nonatomic) IBOutlet UIProgressView *progress4;
@property (weak, nonatomic) IBOutlet UIProgressView *progress5;
@property (weak, nonatomic) IBOutlet UILabel *percent1;
@property (weak, nonatomic) IBOutlet UILabel *percent2;
@property (weak, nonatomic) IBOutlet UILabel *percent3;
@property (weak, nonatomic) IBOutlet UILabel *percent4;
@property (weak, nonatomic) IBOutlet UILabel *percent5;
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UITableView *displayTableView;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIImageView *icon1;
@property (weak, nonatomic) IBOutlet UIImageView *icon2;
@property (weak, nonatomic) IBOutlet UIImageView *icon3;
@property (weak, nonatomic) IBOutlet UIImageView *icon4;
@property (weak, nonatomic) IBOutlet UIImageView *icon5;
@property (weak, nonatomic) IBOutlet UIImageView *icon6;
@property (weak, nonatomic) IBOutlet UIImageView *icon7;
@property (weak, nonatomic) IBOutlet UIImageView *icon8;
@property (weak, nonatomic) IBOutlet UIImageView *blackPoint1;
@property (weak, nonatomic) IBOutlet UIImageView *blackPoint2;
@property (weak, nonatomic) IBOutlet UIImageView *blackPoint3;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *title3;
@property (weak, nonatomic) IBOutlet UILabel *title4;
@property (weak, nonatomic) IBOutlet UILabel *title5;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *productTitle;
@property (strong,nonatomic) ProductCakeModel *cakeModel;
@property (strong,nonatomic) NSMutableArray *cakeArr;
@property (weak, nonatomic) IBOutlet UIButton *suggestBtn1;
@property (weak, nonatomic) IBOutlet UIButton *suggestBtn2;
@property (weak, nonatomic) IBOutlet UIButton *suggestBtn3;

@property (strong,nonatomic) DullSaleListModel *dullSaleModel;
@property (strong,nonatomic) NSMutableArray *dullSaleArr;
@property (assign,nonatomic)NSInteger count;
@property (assign,nonatomic) NSInteger fittingCount;
@property (strong,nonatomic) ProductAnalyseFittingModel *productAnalyseFittingModel;
@property (strong,nonatomic) NSMutableArray *fittingArr;
@end

@implementation ZRDullSaleController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setImageRound];
    [self setBlackPoint];
    _displayTableView.dataSource = self;
    _displayTableView.delegate = self;
    _navigationView.backgroundColor = defaultColor;
    [self setDullSale];
    [self setFittCake];
    [self setProductAnalyseFitting];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark -- 请求数据
- (void)setDullSale{
    [AnalyseAjax productDullSaleWithStartTime:_startTimeLabel.text endtime:_endTimeLabel.text Success:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        [_startTimeLabel setText:FORMAT(@"%@",results[@"starttime"])];
        [_endTimeLabel setText:FORMAT(@"%@",results[@"endtime"])];
        NSArray *list = results[@"list"];
        _count = list.count;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
        for (int i =0; i<list.count; i++) {
            NSDictionary *listSub = [list objectAtIndex:i];
            _dullSaleModel = [DullSaleListModel dullSaleListWithDict:listSub];
            [arr addObject:_dullSaleModel];
        }
        _dullSaleArr = arr;
        NSArray *items = @[_title1,_title2,_title3,_title4,_title5];
        NSArray *progressArr = @[_progress1,_progress2,_progress3,_progress4,_progress5];
        NSArray *percentArr = @[_percent1,_percent2,_percent3,_percent4,_percent5];
        NSArray *dotView = @[_imageView1,_imageView2,_imageView3,_imageView4,_imageView5];
        for (int i = 0; i<_count; i++) {
            UILabel *title = [items objectAtIndex:i];
            _dullSaleModel = [_dullSaleArr objectAtIndex:i];
            UIProgressView *progressView = [progressArr objectAtIndex:i];
            [title setText:_dullSaleModel.title];
            [progressView setProgress:[_dullSaleModel.percent floatValue] / 100.0];
            [progressView setProgressTintColor:[UIColor colorWithHexString:_dullSaleModel.color]];
            
            UILabel *percent = [percentArr objectAtIndex:i];
            [percent setText:FORMAT(@"%@%@",_dullSaleModel.percent,_dullSaleModel.hold)];
            [percent setTextColor:[UIColor colorWithHexString:_dullSaleModel.color]];
            UIImageView *dotViewsub = [dotView objectAtIndex:i];
            [dotViewsub setBackgroundColor:[UIColor colorWithHexString:_dullSaleModel.color]];
        }
        NSDictionary *bottom = results[@"bottom"];
        NSArray *advice = bottom[@"advice"];
        NSDictionary *advice1 = [advice objectAtIndex:0];
        NSDictionary *advice2 = [advice objectAtIndex:1];
        NSDictionary *advice3 = [advice objectAtIndex:2];
        [_suggestBtn1 setTitle:advice1[@"title"] forState:UIControlStateNormal];
        [_suggestBtn1 setTitle:advice2[@"title"] forState:UIControlStateNormal];
        [_suggestBtn1 setTitle:advice3[@"title"] forState:UIControlStateNormal];
        
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
- (void)setProductAnalyseFitting{
    [AnalyseAjax productDisplayWithStartTime:_startTimeLabel.text endtime:_endTimeLabel.text Success:^(NSDictionary *dict) {
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

#pragma mark -- UITableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _fittingCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DisplayCell *cell = [DisplayCell displayCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    return cell;
}

#pragma mark -- UITableViewDelegate代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"AnalyseViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"ProductDetailsController"];
    NSString *gid = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"productDidClick" object:gid];
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark -- 设置视图
//设置圆点
- (void)setImageRound{
    [_imageView1 roundWithRadius:6];
    [_imageView2 roundWithRadius:6];
    [_imageView3 roundWithRadius:6];
    [_imageView4 roundWithRadius:6];
    [_imageView5 roundWithRadius:6];

    [_progress1 roundWithRadius:4];
    [_progress2 roundWithRadius:4];
    [_progress3 roundWithRadius:4];
    [_progress4 roundWithRadius:4];
    [_progress5 roundWithRadius:4];
}
- (void)setBlackPoint{
    self.blackPoint1.layer.cornerRadius = 3;
    self.blackPoint1.layer.masksToBounds = YES;
    self.blackPoint2.layer.cornerRadius = 3;
    self.blackPoint2.layer.masksToBounds = YES;
    self.blackPoint3.layer.cornerRadius = 3;
    self.blackPoint3.layer.masksToBounds = YES;
}
//设置饼图
- (void)setCircleView{
    NSArray *iconArr = @[_icon1,_icon2,_icon3,_icon4,_icon5,_icon6,_icon7,_icon8];
    NSMutableArray *item = [NSMutableArray arrayWithCapacity:8];
    for (int i = 0; i < 8; i++) {
        ProductCakeModel *cakeModel = [_cakeArr objectAtIndex:i];
        [item addObject: [PNPieChartDataItem dataItemWithValue:[cakeModel.pre floatValue] color:[UIColor colorWithHexString:cakeModel.color] description:cakeModel.name]];
        UIImageView *icon = iconArr[i];
        icon.backgroundColor = [UIColor colorWithHexString:cakeModel.color];
    }
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(69, 46, 240, 240) items:item];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    [pieChart strokeChart];
    [_circleView addSubview:pieChart];
}
#pragma mark -- 按钮点击触发
- (IBAction)dateBtnClick:(id)sender {
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"ReportViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"ZRTimeCompareController"];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)readMoreBtnClick:(id)sender {
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"AnalyseViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"ZRDisplayProductController"];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//取消返回按钮的文字
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
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
- (NSMutableArray *)dullSaleArr{
    if (_dullSaleArr == nil) {
        _dullSaleArr = [NSMutableArray array];
    }
    return _dullSaleArr;
}

- (NSMutableArray *)cakeArr{
    if (_cakeArr == nil) {
        _cakeArr = [NSMutableArray array];
    }
    return _cakeArr;
}

- (NSMutableArray *)fittingArr{
    if (_fittingArr == nil) {
        _fittingArr = [NSMutableArray array];
    }
    return _fittingArr;
}


@end
