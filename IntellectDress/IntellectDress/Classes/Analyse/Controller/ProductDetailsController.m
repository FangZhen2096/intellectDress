//
//  ProductDetailsController.m
//  IntellectDress
//
//  Created by zerom on 16/9/26.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ProductDetailsController.h"
#import "ProductDetailsViewCell.h"
#import "AnalyseAjax.h"
#import "ProductModel.h"
@interface ProductDetailsController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *productDetailsView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIView *LinechartView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productNumber;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UIButton *productLike;
@property (weak, nonatomic) IBOutlet UILabel *tryClothesLabel;
@property (weak, nonatomic) IBOutlet UILabel *tryOnLabel;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (copy,nonatomic) NSString *gid;
@property (strong,nonatomic) ProductModel *product;
@property (strong,nonatomic) NSMutableArray *products;
@property (assign,nonatomic)NSInteger count;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ProductDetailsController

#pragma mark -- 懒加载
- (NSMutableArray *)products{
    if (_products == nil) {
        _products = [[NSMutableArray alloc] init];
    }
    return _products;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [self setProductDetails];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _label1.textColor = defaultColor;
    _label2.textColor = RGB(121, 125, 200);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getObjecgt:) name:@"productDidClick" object:nil];
    [self setLineView];
}

- (void)getObjecgt:(NSNotification *)notification{
    _gid = notification.object;
}
//设置商品明细
- (void)setProductDetails{
    [AnalyseAjax ProductDetailsWithGid:_gid Success:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        NSDictionary *wares = results[@"wares"];
        NSDictionary *base = results[@"base"];
        NSString *startTime = results[@"starttime"];
        NSString *endTime = results[@"endtime"];
        [_startTime setText:startTime];
        [_endTime setText:endTime];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:wares[@"img"]]];
        [_productNameLabel setText:wares[@"title"]];
        [_productNumber setText:wares[@"number"]];
        [_productPrice setText:wares[@"price"]];
        NSInteger selected = 0;
        if ([wares[@"love"] isEqualToString:@"true"]) {
            selected = 1;
        }else{
            selected = 0;
        }
        _productLike.selected = selected;
        [_tryClothesLabel setText:base[@"fitt"]];
        [_tryOnLabel setText:base[@"trying"]];
        [_displayLabel setText:base[@"display"]];
        NSArray *details = results[@"details"];
        _count = details.count;
        NSMutableArray *productArray = [NSMutableArray arrayWithCapacity:details.count];
        for (int i = 0; i < details.count; i++) {
            NSDictionary *detailSub = [details objectAtIndex:i];
            _product = [ProductModel productWithDict:detailSub];
            [productArray addObject:_product];
            _products = productArray;
        }

        [_tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark -- UITableViewDataSource数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailsViewCell *cell = [ProductDetailsViewCell productDetailsCell:tableView];
     if (indexPath.row == 0){
         cell.bottomLineHeight.constant = 1;
    }else if (indexPath.row == 6){
        [cell.TopSeperateLine setHidden:YES];
        cell.bottomLineHeight.constant = 3;
    }else{
        [cell.TopSeperateLine setHidden:YES];
        cell.bottomLineHeight.constant = 1;
    }
    if (indexPath.row!=0) {
        ProductModel *product = [_products objectAtIndex:indexPath.row-1];
        [cell.colorLabel setText:product.color];
        [cell.sizeLabel setText:product.size];
        [cell.tryClothesLabel setText:product.trying];
        [cell.tryOnLabel setText:product.fitt];
        [cell.disPlayLabel setText:product.display];
       
    }
    
    return cell;
}

- (void)setLineView{
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, 700, 143)];
    [lineChart setXLabels:@[@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30",@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00"]];

    // Line Chart No.1
    NSArray * data01Array = @[@5, @25, @28, @48, @25,@37,@16,@20,@30,@15,@14,@19,@25,@6,@30,@39,@10];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = defaultColor;
    data01.itemCount = lineChart.xLabels.count;
    data01.showPointLabel = YES;
    data01.pointLabelFont = [UIFont systemFontOfSize:10];
    data01.pointLabelColor = defaultColor;
    data01.inflexionPointColor = defaultColor;
    data01.inflexionPointStyle = PNLineChartPointStyleCircle;
    
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // Line Chart No.2
    NSArray * data02Array = @[@8, @12, @34, @67, @9,@5,@12,@32,@20,@19,@20,@23,@37,@10,@28,@10,@20];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = RGB(121, 125, 200);
    data02.itemCount = lineChart.xLabels.count;
    data02.showPointLabel = YES;
    data02.pointLabelFont = [UIFont systemFontOfSize:10];
    data02.inflexionPointColor = RGB(121, 125, 200);
    data02.inflexionPointStyle = PNLineChartPointStyleCircle;
    data02.pointLabelColor = RGB(121, 125, 200);
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01, data02];
    [lineChart strokeChart];
    
    lineChart.showSmoothLines = YES;
    lineChart.axisColor = RGB(220, 220, 220);
    lineChart.showLabel = YES;
    lineChart.showCoordinateAxis = YES;
    lineChart.showGenYLabels = YES;
    lineChart.xLabelColor = RGB(160, 160, 160);
    lineChart.yLabelColor = RGB(160, 160, 160);
    _scrollView.contentSize = CGSizeMake(lineChart.frame.size.width, lineChart.frame.size.height);
    [_scrollView addSubview:lineChart];
    
    
}

#pragma mark -- 按钮点击触发
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)dateBtnClick:(id)sender {
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"ReportViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"ZRTimeCompareController"];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)productLikeBtnClick:(id)sender {
    _productLike.selected = !_productLike.selected;
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
//取消返回按钮的文字
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
