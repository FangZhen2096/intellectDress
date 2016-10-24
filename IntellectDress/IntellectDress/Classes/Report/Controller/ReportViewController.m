//
//  ReportViewController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/2.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ReportViewController.h"
#import "PNChart.h"
#import "ReportAjax.h"
#import "ZRTimeCompareController.h"

@interface ReportViewController ()<PNChartDelegate,ZRTimeCompareControllerDelegate>


@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UIView *chartView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *blackPoint1;
@property (weak, nonatomic) IBOutlet UIImageView *blackPoint2;
@property (weak, nonatomic) IBOutlet UIImageView *blackPoint3;
/**
 开始时间
 */
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
/**
 结束时间
 */
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
//进店率
@property (assign,nonatomic)int joinRate;
//成交率
@property (assign,nonatomic)int dealRate;
//试衣率
@property (assign,nonatomic)int tryClothesRate;
//试穿率
@property (assign,nonatomic)int tryOnRate;

@property (strong,nonatomic) NSMutableArray *XLabels;
@property (strong,nonatomic) NSMutableArray *YLabels;
@property (strong,nonatomic) NSMutableArray *YValues;
//分析结果
@property (weak, nonatomic) IBOutlet UILabel *ResultTips;
@property (weak, nonatomic) IBOutlet UILabel *weatherTitle;
@property (weak, nonatomic) IBOutlet UILabel *weatherNum;
@property (weak, nonatomic) IBOutlet UILabel *weatherCenter;
@property (weak, nonatomic) IBOutlet UILabel *weatherInfo;
//客流
@property (weak, nonatomic) IBOutlet UILabel *comeNum;
@property (weak, nonatomic) IBOutlet UILabel *comeTitle;
@property (weak, nonatomic) IBOutlet UILabel *maxComNum;
@property (weak, nonatomic) IBOutlet UILabel *maxComeTitle;
@property (weak, nonatomic) IBOutlet UILabel *ADoorMaxComeNum;
@property (weak, nonatomic) IBOutlet UILabel *ADoorMaxComeTitle;
@property (weak, nonatomic) IBOutlet UILabel *comeRateNum;
@property (weak, nonatomic) IBOutlet UILabel *comRateTitle;
//商品
@property (weak, nonatomic) IBOutlet UILabel *tryClothesNum;
@property (weak, nonatomic) IBOutlet UILabel *tryClothesTitle;
@property (weak, nonatomic) IBOutlet UILabel *tryOnNum;
@property (weak, nonatomic) IBOutlet UILabel *tryOnTitle;
@property (weak, nonatomic) IBOutlet UILabel *tryClothesRateNum;
@property (weak, nonatomic) IBOutlet UILabel *tryClothesRateTitle;
@property (weak, nonatomic) IBOutlet UILabel *tryOnRateNum;
@property (weak, nonatomic) IBOutlet UILabel *tryOnRateTitle;

//销售
@property (weak, nonatomic) IBOutlet UILabel *orderCountNum;
@property (weak, nonatomic) IBOutlet UILabel *orderCountTitle;
@property (weak, nonatomic) IBOutlet UILabel *saleCountNum;
@property (weak, nonatomic) IBOutlet UILabel *saleCountTitle;
@property (weak, nonatomic) IBOutlet UILabel *getProfitNum;
@property (weak, nonatomic) IBOutlet UILabel *getProfitTitle;
@property (weak, nonatomic) IBOutlet UILabel *dealRateNum;
@property (weak, nonatomic) IBOutlet UILabel *dealRateTitle;
//进货价
@property (weak, nonatomic) IBOutlet UILabel *costNum;
@property (weak, nonatomic) IBOutlet UILabel *costNumLabel;
//客单价
@property (weak, nonatomic) IBOutlet UILabel *priceNum;
@property (weak, nonatomic) IBOutlet UILabel *priceNumLabel;

@property (weak, nonatomic) IBOutlet UIButton *adviceBtn1;
@property (weak, nonatomic) IBOutlet UIButton *adviceBtn2;
@property (weak, nonatomic) IBOutlet UIButton *adviceBtn3;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn1;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn2;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn3;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn4;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn5;

@end

@implementation ReportViewController



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //跳转到子视图时，将circleView中的子视图清空
    for (UIView *view in self.circleView.subviews) {
        [view removeFromSuperview];
    }
    [self setReport];
    [self setBlackPoint];
    [self setChart];
    [self.segmentedControl setTintColor:defaultColor];
    [self.navigationController.navigationBar setBackgroundColor:defaultColor];
        [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [_startTimeLabel setText:@"2016-10-24"];
    [_endTimeLabel setText:@"2016-10-24"];
    [_adviceBtn1 addTarget:self action:@selector(suggestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_adviceBtn2 addTarget:self action:@selector(suggestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_adviceBtn3 addTarget:self action:@selector(suggestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn1 addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn2 addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn3 addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn4 addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn5 addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}


//设置汇报
- (void)setReport{
    [ReportAjax reportSuccessWithStartTime:_startTimeLabel.text endTime:_endTimeLabel.text success:^(NSDictionary *dict) {
        NSLog(@"汇报json--------%@",dict);
        NSDictionary *results = dict[@"results"];
        NSString *shopName = results[@"shop"];
        self.navigationItem.title = shopName;
        NSArray *rate = results[@"rate"];
        NSLog(@"rate----%@",rate);
        NSDictionary *rate1 = [rate objectAtIndex:0];
        NSDictionary *rate2 = [rate objectAtIndex:1];
        NSDictionary *rate3 = [rate objectAtIndex:2];
        NSDictionary *rate4 = [rate objectAtIndex:3];
        //圆视图设置
        [self setCirCleWithRect:CGRectMake(30, 11, 56, 56) Total:100 current:[rate1[@"rate"] intValue] clockWise:YES overrideLineWidth:2 text:rate1[@"title"] strokeColor:defaultColor];
        [self setCirCleWithRect:CGRectMake(116, 11, 56, 56) Total:100 current:[rate2[@"rate"] intValue] clockWise:YES overrideLineWidth:2 text:rate2[@"title"] strokeColor:defaultColor];
        [self setCirCleWithRect:CGRectMake(192, 11, 56, 56) Total:100 current:[rate3[@"rate"] intValue] clockWise:YES overrideLineWidth:2 text:rate3[@"title"] strokeColor:RGB(255, 102, 6)];
        [self setCirCleWithRect:CGRectMake(278, 11, 56, 56) Total:100 current:[rate4[@"rate"] intValue] clockWise:YES overrideLineWidth:2 text:rate4[@"title"] strokeColor:RGB(255, 60, 89)];
        //分析结果和天气设置
        NSDictionary *result = results[@"result"];
        NSLog(@"分析结果-------------%@",result);
        [_ResultTips setText:result[@"tips"]];
        [_weatherTitle setText:result[@"title"]];
        [_weatherNum setText:FORMAT(@"%@%@",result[@"num"],result[@"unit"])];
        [_weatherInfo setText: result[@"info"]];
        [_weatherCenter setText: result[@"center"]];
        
        //客流设置
        NSArray  *value = results[@"value"];
        NSDictionary *valueSub = [value objectAtIndex:0];
        NSArray *valueList = valueSub[@"list"];
        NSDictionary *list1 = [valueList objectAtIndex:0];
        NSDictionary *list2 = [valueList objectAtIndex:1];
        NSDictionary *list3 = [valueList objectAtIndex:2];
        NSDictionary *list4 = [valueList objectAtIndex:3];
        [_comeNum setText:list1[@"num"]];
        [_comeTitle setText:list1[@"title"]];
        [_maxComNum setText:list2[@"num"]];
        [_maxComeTitle setText:list2[@"title"]];
        [_ADoorMaxComeNum setText:list3[@"num"]];
        [_ADoorMaxComeTitle setText:list3[@"title"]];
        [_comeRateNum setText:list4[@"num"]];
        [_comRateTitle setText:list4[@"title"]];
        [self.view setNeedsDisplay];
        
        //商品设置
        NSDictionary *goods = [value objectAtIndex:1];
        NSArray *goodList = goods[@"list"];
        NSDictionary *goodList1 = [goodList objectAtIndex:0];
        NSDictionary *goodList2 = [goodList objectAtIndex:1];
        NSDictionary *goodList3 = [goodList objectAtIndex:2];
        NSDictionary *goodList4 = [goodList objectAtIndex:3];
        [_tryClothesNum setText:goodList1[@"num"]];
        [_tryClothesTitle setText:goodList1[@"title"]];
        [_tryOnNum setText:goodList2[@"num"]];
        [_tryOnTitle setText:goodList2[@"title"]];
        [_tryClothesRateNum setText:goodList3[@"num"]];
        [_tryClothesRateTitle setText:goodList3[@"title"]];
        [_tryOnRateNum setText:goodList4[@"num"]];
        [_tryOnRateTitle setText:goodList4[@"title"]];
        
        //销售设置
        NSDictionary *sale = [value objectAtIndex:2];
        NSArray *saleList = sale[@"list"];
        NSDictionary *saleList1 = [saleList objectAtIndex:0];
        NSDictionary *saleList2 = [saleList objectAtIndex:1];
        NSDictionary *saleList3 = [saleList objectAtIndex:2];
        NSDictionary *saleList4 = [saleList objectAtIndex:3];
        NSDictionary *saleList5 = [saleList objectAtIndex:4];
        NSDictionary *saleList6 = [saleList objectAtIndex:5];
        [_orderCountNum setText:saleList1[@"num"]];
        [_orderCountTitle setText:saleList1[@"title"]];
        [_saleCountNum setText:saleList2[@"num"]];
        [_saleCountTitle setText:saleList2[@"title"]];
        [_getProfitNum setText:saleList3[@"num"]];
        [_getProfitTitle setText:saleList3[@"title"]];
        [_dealRateNum setText:saleList4[@"num"]];
        [_dealRateTitle setText:saleList4[@"title"]];
        [_costNum setText:saleList5[@"num"]];
        [_costNumLabel setText:saleList5[@"title"]];
        [_priceNum setText:saleList6[@"num"]];
        [_priceNumLabel setText:saleList6[@"title"]];
        
        //经营建议
        NSDictionary *bottom = results[@"bottom"];
        NSArray *advice = bottom[@"advice"];
        NSDictionary *advice1 = [advice objectAtIndex:0];
        NSDictionary *advice2 = [advice objectAtIndex:1];
        NSDictionary *advice3 = [advice objectAtIndex:2];
        [_adviceBtn1 setTitle:advice1[@"title"] forState:UIControlStateNormal];
        [_adviceBtn2 setTitle:advice2[@"title"] forState:UIControlStateNormal];
        [_adviceBtn3 setTitle:advice3[@"title"] forState:UIControlStateNormal];
        
        
    } failed:^(NSError *error) {
        
    }];
    
}

- (void)setChart{
    [ReportAjax reportChartSuccessWithStartTime:_startTimeLabel.text endTime:_endTimeLabel.text type:@"1" success:^(NSDictionary *dict) {
        NSLog(@"客流量chart Json--------%@",dict);
        NSDictionary *results = dict[@"results"];
//        NSString *title = results[@"title"];
//        NSString *yMax = results[@"ymax"];
        NSArray *list = results[@"list"];
        
        NSDictionary *list1 = [list objectAtIndex:0];
        NSDictionary *list2 = [list objectAtIndex:1];
        NSDictionary *list3 = [list objectAtIndex:2];
        NSDictionary *list4 = [list objectAtIndex:3];
        NSDictionary *list5 = [list objectAtIndex:4];
        NSDictionary *list6 = [list objectAtIndex:5];
        NSDictionary *list7 = [list objectAtIndex:6];
        NSDictionary *list8 = [list objectAtIndex:7];
        NSDictionary *list9 = [list objectAtIndex:8];
        NSDictionary *list10 = [list objectAtIndex:9];
        NSDictionary *list11 = [list objectAtIndex:10];
        NSDictionary *list12 = [list objectAtIndex:11];
        
        for (UIView *view in self.scrollView.subviews) {
            [view removeFromSuperview];
        }
        static NSNumberFormatter *barChartFormatter;
        if (!barChartFormatter){
            barChartFormatter = [[NSNumberFormatter alloc] init];
            barChartFormatter.numberStyle = NSNumberFormatterNoStyle;
            barChartFormatter.allowsFloats = NO;
            barChartFormatter.maximumFractionDigits = 0;
        }
        
        PNBarChart *barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 0, 500, 200.0)];
        barChart.backgroundColor = [UIColor clearColor];
        barChart.yLabelFormatter = ^(CGFloat yValue){
            return [barChartFormatter stringFromNumber:[NSNumber numberWithFloat:yValue]];
        };
        barChart.yChartLabelWidth = 20.0;
        barChart.chartMarginLeft = 30.0;
        barChart.chartMarginRight = 10.0;
        barChart.chartMarginTop = 5.0;
        barChart.chartMarginBottom = 10.0;
        barChart.labelMarginTop = 5.0;
        barChart.showChartBorder = YES;
        [barChart setXLabels:@[list1[@"start"],list2[@"start"],list3[@"start"],list4[@"start"],list5[@"start"],list6[@"start"],list7[@"start"],list8[@"start"],list9[@"start"],list10[@"start"],list11[@"start"],list12[@"start"]]];
        barChart.yLabels = @[@0,@10,@20,@30,@40,@50];
        [barChart setYValues:@[list1[@"num"],list2[@"num"],list3[@"num"],list4[@"num"],list5[@"num"],list6[@"num"],list7[@"num"],list8[@"num"],list9[@"num"],list10[@"num"],list11[@"num"],list12[@"num"]]];
        [barChart setStrokeColors:@[BarChartBlue,BarChartBlue,BarChartBlue,BarChartBlue,BarChartBlue,BarChartBlue,BarChartBlue,BarChartBlue]];
        barChart.isGradientShow = NO;
        barChart.isShowNumbers = YES;
        
        [barChart strokeChart];
        barChart.delegate = self;
        
        self.scrollView.contentSize = CGSizeMake(barChart.frame.size.width, barChart.frame.size.height);
        [self.scrollView addSubview:barChart];

       
    } failed:^(NSError *error) {
        
    }];
}



- (void)setBarChartWithXLabel:(NSString *)XLabel YValue:(NSString *)YValue{
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    static NSNumberFormatter *barChartFormatter;
    if (!barChartFormatter){
        barChartFormatter = [[NSNumberFormatter alloc] init];
        barChartFormatter.numberStyle = NSNumberFormatterNoStyle;
        barChartFormatter.allowsFloats = NO;
        barChartFormatter.maximumFractionDigits = 0;
    }
    
    PNBarChart *barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 0, 500, 200.0)];
    barChart.backgroundColor = [UIColor clearColor];
    barChart.yLabelFormatter = ^(CGFloat yValue){
        return [barChartFormatter stringFromNumber:[NSNumber numberWithFloat:yValue]];
    };
    barChart.yChartLabelWidth = 20.0;
    barChart.chartMarginLeft = 30.0;
    barChart.chartMarginRight = 10.0;
    barChart.chartMarginTop = 5.0;
    barChart.chartMarginBottom = 10.0;
    barChart.labelMarginTop = 5.0;
    barChart.showChartBorder = YES;
    [barChart setXLabels:_XLabels];
    barChart.yLabels = @[@0,@10,@20,@30,@40,@50];
    [barChart setYValues:_YValues];
    [barChart setStrokeColors:@[BarChartBlue,BarChartBlue,BarChartBlue,BarChartBlue,BarChartBlue,BarChartBlue,BarChartBlue,BarChartBlue]];
    barChart.isGradientShow = NO;
    barChart.isShowNumbers = YES;
    
    [barChart strokeChart];
    barChart.delegate = self;
    
    self.scrollView.contentSize = CGSizeMake(barChart.frame.size.width, barChart.frame.size.height);
    [self.scrollView addSubview:barChart];
}


- (void)setCirCleWithRect:(CGRect)rect Total:(int)total current:(int )current clockWise:(BOOL)clockwise overrideLineWidth:(int )overrideLineWidth text:(NSString *)text strokeColor:(UIColor *)color{
    PNCircleChart *circle = [[PNCircleChart alloc] initWithFrame:rect total:[NSNumber numberWithInt:total] current:[NSNumber numberWithInt:current] clockwise:clockwise shadow:NO shadowColor:nil displayCountingLabel:YES overrideLineWidth:[NSNumber numberWithInt:overrideLineWidth]];
    circle.backgroundColor = [UIColor clearColor];
    [circle setStrokeColor:color];
    [circle strokeChart];
    [_circleView addSubview:circle];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = text;
    label1.textColor = [UIColor grayColor];
    label1.font = [UIFont systemFontOfSize:12];
    [_circleView addSubview:label1];
    label1.frame = CGRectMake(rect.origin.x+10, rect.origin.y+13, rect.size.width, rect.size.height);
}

- (void)setBlackPoint{
    self.blackPoint1.layer.cornerRadius = 3;
    self.blackPoint1.layer.masksToBounds = YES;
    self.blackPoint2.layer.cornerRadius = 3;
    self.blackPoint2.layer.masksToBounds = YES;
    self.blackPoint3.layer.cornerRadius = 3;
    self.blackPoint3.layer.masksToBounds = YES;
}

#pragma mark -- 按钮点击事件
//日历按钮点击
- (IBAction)calenderBtnClick:(id)sender {
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"ReportViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"ZRTimeCompareController"];
    [self.navigationController pushViewController:controller animated:YES];
}
//经营建议按钮点击
- (void)suggestBtnClick:(UIButton *)btn{
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"AnalyseViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"LoadSuggestWebController"];
    [self.navigationController pushViewController:controller animated:YES];
}

//解读和更多按钮点击

- (void)moreBtnClick:(UIButton *)btn{
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"AnalyseViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"LoadSuggestWebController"];
    [self.navigationController pushViewController:controller animated:YES];
}

//取消返回按钮的文字
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
   
}
#pragma mark --  懒加载
- (NSMutableArray *)XLabels{
    if (_XLabels == nil) {
        _XLabels = [NSMutableArray array];
    }
    return _XLabels;
}
- (NSMutableArray *)YLabels{
    if (_YLabels == nil) {
        _YLabels = [NSMutableArray array];
    }
    return _YLabels;
}

- (NSMutableArray *)YValues{
    if (_YValues == nil) {
        _YValues = [NSMutableArray array];
    }
    return _YValues;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
