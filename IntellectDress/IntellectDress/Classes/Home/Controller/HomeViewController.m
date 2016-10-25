//
//  HomeViewController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/2.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "HomeViewController.h"
#import "WeatherModel.h"
#import "HomeAjax.h"
#import "MaxViewCell.h"
#import "TryClothesCell.h"
@interface HomeViewController ()<UITableViewDataSource,UIScrollViewDelegate,UITableViewDelegate>
/**
 *  第一个tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *firstTableView;
/**
 *  第二个tableview
 */
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;
/**
 *  滚动view
 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//左边button
@property (weak, nonatomic) IBOutlet UIButton *leftBtn1;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn1;
/**
 *  分析view1
 */
@property (weak, nonatomic) IBOutlet UIView *analyseView1;
/**
 *  分析view3
 */
@property (weak, nonatomic) IBOutlet UIView *analyseView3;
/**
 *  分析View2
 */
@property (weak, nonatomic) IBOutlet UIView *analyseView2;
/**
 *  第三个tableview
 */
@property (weak, nonatomic) IBOutlet UITableView *thirdTableView;
/**
 *  第一个topView
 */
@property (weak, nonatomic) IBOutlet UIView *topView1;
/**
 *  第二个topView
 */
@property (weak, nonatomic) IBOutlet UIView *topView2;
/**
 *  第三个topView
 */
@property (weak, nonatomic) IBOutlet UIView *topView3;
//天气度数
@property (weak, nonatomic) IBOutlet UILabel *temperature;
//当前进店人数
@property (weak, nonatomic) IBOutlet UILabel *come;
//天气图片
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
//城市Label
@property (weak, nonatomic) IBOutlet UILabel *city;
//天气
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
//舒适度
@property (weak, nonatomic) IBOutlet UILabel *clothesTitleLabel;
//穿衣建议
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
//店铺名称
@property (weak, nonatomic) IBOutlet UIButton *storeNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *storeNameLabel2;
@property (weak, nonatomic) IBOutlet UIButton *storeNameLabel3;

@property (weak, nonatomic) IBOutlet UILabel *temperature2;
@property (weak, nonatomic) IBOutlet UILabel *city2;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel2;
@property (weak, nonatomic) IBOutlet UILabel *clothesTitleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *descLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView2;

@property (weak, nonatomic) IBOutlet UILabel *temperature3;
@property (weak, nonatomic) IBOutlet UILabel *city3;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel3;
@property (weak, nonatomic) IBOutlet UILabel *clothesTitleLabel3;
@property (weak, nonatomic) IBOutlet UILabel *descLabel3;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView3;
//当前进店人次更新于。。。
@property (weak, nonatomic) IBOutlet UILabel *currentFlowLabel;
//经过人数
@property (weak, nonatomic) IBOutlet UILabel *passFlowLabel;
//进店最高人数
@property (copy,nonatomic) NSString *joinMaxLabel;
//经过最高人数
@property (copy,nonatomic) NSString *passMaxLabel;
//进店最高人数时间
@property (copy,nonatomic) NSString *joinmaxTimeLabel;
//进过最高人数时间
@property (copy,nonatomic) NSString *passMaxTimeLabel;
/**
 目前试衣人数
 */
@property (weak, nonatomic) IBOutlet UILabel *currentTryClothesLabel;
/**
 目前试衣更新于
 */
@property (weak, nonatomic) IBOutlet UILabel *tryClothesInfo;
/**
 试衣总数
 */
@property (weak, nonatomic) IBOutlet UILabel *tryClothesCountLabel;

/**
 目前试穿人数
 */
@property (weak, nonatomic) IBOutlet UILabel *currentTryOnLabel;

/**
 目前试穿更新于
 */
@property (weak, nonatomic) IBOutlet UILabel *tryOnInfoLabel;

/**
 试穿总数
 */
@property (weak, nonatomic) IBOutlet UILabel *tryOnCountLabel;

/************************        试衣的商品展示     ***************************/
@property (copy,nonatomic) NSString *cup1ImageViewURL;
@property (copy,nonatomic) NSString *cup1Title;
@property (copy,nonatomic) NSString *cup1Num;
@property (copy,nonatomic) NSString *cup1Unit;
@property (copy,nonatomic) NSString *cup1Price;

@property (copy,nonatomic) NSString *cup2ImageViewURL;
@property (copy,nonatomic) NSString *cup2Title;
@property (copy,nonatomic) NSString *cup2Num;
@property (copy,nonatomic) NSString *cup2Unit;
@property (copy,nonatomic) NSString *cup2Price;

@property (copy,nonatomic) NSString *cup3ImageViewURL;
@property (copy,nonatomic) NSString *cup3Title;
@property (copy,nonatomic) NSString *cup3Num;
@property (copy,nonatomic) NSString *cup3Unit;
@property (copy,nonatomic) NSString *cup3Price;
/************************        试衣的商品展示     ***************************/



/************************        试衣的商品展示     ***************************/
@property (copy,nonatomic) NSString *TryOnCup1ImageViewURL;
@property (copy,nonatomic) NSString *TryOnCup1Title;
@property (copy,nonatomic) NSString *TryOnCup1Num;
@property (copy,nonatomic) NSString *TryOnCup1Unit;
@property (copy,nonatomic) NSString *TryOnCup1Price;

@property (copy,nonatomic) NSString *TryOnCup2ImageViewURL;
@property (copy,nonatomic) NSString *TryOnCup2Title;
@property (copy,nonatomic) NSString *TryOnCup2Num;
@property (copy,nonatomic) NSString *TryOnCup2Unit;
@property (copy,nonatomic) NSString *TryOnCup2Price;

@property (copy,nonatomic) NSString *TryOnCup3ImageViewURL;
@property (copy,nonatomic) NSString *TryOnCup3Title;
@property (copy,nonatomic) NSString *TryOnCup3Num;
@property (copy,nonatomic) NSString *TryOnCup3Unit;
@property (copy,nonatomic) NSString *TryOnCup3Price;
/************************        试衣的商品展示     ***************************/
@property (copy,nonatomic) NSString *cityID;
@end

@implementation HomeViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:NO];
    
    [self setPassengerFlow];
    
    [self setTryClothes];
    [self setTryOn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstTableView.dataSource = self;
    self.secondTableView.dataSource = self;
    self.thirdTableView.dataSource = self;
    self.firstTableView.delegate = self;
    self.secondTableView.delegate = self;
    self.thirdTableView.delegate = self;
    self.firstTableView.scrollEnabled = NO;
    self.secondTableView.scrollEnabled = NO;
    self.thirdTableView.scrollEnabled = NO;
    self.firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(1125, 0);
    _cityID = [UserBiz cityId];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getObjecgt:) name:@"cityID" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getShopName:) name:@"shopName" object:nil];
    [self setTemperature];
    [self initView];
    
}
- (void)getShopName:(NSNotification *)notification{
    [_storeNameLabel setTitle:notification.object forState:UIControlStateNormal];
    [_storeNameLabel2 setTitle:notification.object forState:UIControlStateNormal];
    [_storeNameLabel3 setTitle:notification.object forState:UIControlStateNormal];
    
}

- (void)getObjecgt:(NSNotification *)notification{
    _cityID = notification.object;
    [self setTemperature];
}
- (void)initView{
    _topView1.backgroundColor = [UIColor colorWithRed:80/255.0 green:206/255.0 blue:214/255.0 alpha:1];
    _topView2.backgroundColor =[UIColor colorWithRed:81/255.0 green:162/255.0 blue:214/255.0 alpha:1];
    _topView3.backgroundColor =[UIColor colorWithRed:163/255.0 green:141/255.0 blue:233/255.0 alpha:1];
    _analyseView1.backgroundColor =[UIColor colorWithRed:80/255.0 green:206/255.0 blue:214/255.0 alpha:1];
    _analyseView2.backgroundColor =[UIColor colorWithRed:81/255.0 green:162/255.0 blue:214/255.0 alpha:1];
    _analyseView3.backgroundColor =[UIColor colorWithRed:163/255.0 green:141/255.0 blue:233/255.0 alpha:1];
}
//设置天气界面
- (void)setTemperature{
    [WeatherModel weatherWithCityID:_cityID Success:^(NSDictionary *dict) {
        NSDictionary *result = dict[@"results"];
        NSString *temp = result[@"temperature"];
        NSDictionary *clothes = result[@"clothes"];
        //第一个topView
        self.temperature.text = [NSString stringWithFormat:@"%@°",temp];
        [self.weatherImageView sd_setImageWithURL:result[@"weather_pic"]];
        [self.city setText: result[@"city"]];
        self.weatherLabel.text = result[@"weather"];
        self.clothesTitleLabel.text = clothes[@"title"];
        self.descLabel.text = clothes[@"desc"];
        //第二个topView
        self.temperature2.text = [NSString stringWithFormat:@"%@°",temp];
        [self.weatherImageView2 sd_setImageWithURL:result[@"weather_pic"]];
        self.city2.text =  result[@"city"];
        self.weatherLabel2.text = result[@"weather"];
        self.clothesTitleLabel2.text = clothes[@"title"];
        self.descLabel2.text = clothes[@"desc"];
        //第三个topview
        self.temperature3.text = [NSString stringWithFormat:@"%@°",temp];
        [self.weatherImageView3 sd_setImageWithURL:result[@"weather_pic"]];
        self.city3.text =  result[@"city"];
        self.weatherLabel3.text = result[@"weather"];
        self.clothesTitleLabel3.text = clothes[@"title"];
        self.descLabel3.text = clothes[@"desc"];
    } failed:^(NSError *error) {
        NSLog(@"天气的错误-------%@",error);
    }];
   
}
//设置客流界面
- (void)setPassengerFlow{
    [HomeAjax passengerFlowWithSuccess:^(NSDictionary *dict) {
        NSLog(@"客流字典----%@",dict);
        NSDictionary *results = dict[@"results"];
        NSDictionary *come = results[@"come"];
        NSArray *list = results[@"list"];
        NSDictionary *listSub = [list objectAtIndex:0];
        NSArray *max = results[@"max"];
        NSDictionary *max1 = [max objectAtIndex:0];
        NSDictionary *max2 = [max objectAtIndex:1];
        _come.text = come[@"num"];
        _currentFlowLabel.text =FORMAT(@"%@,%@",come[@"info"],come[@"time"]);
        _passFlowLabel.text = FORMAT(@"%@:%@",listSub[@"title"],listSub[@"num"]);
        _joinMaxLabel = FORMAT(@"%@",max1[@"num"]);
        _joinmaxTimeLabel = FORMAT(@"%@",max1[@"time"]);
        _passMaxLabel = FORMAT(@"%@",max2[@"num"]);
        _passMaxTimeLabel  = FORMAT(@"%@",max2[@"time"]);
        [_firstTableView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"设置客流错误————————%@",error);
    }];
}
//设置试衣界面
- (void)setTryClothes{
    [HomeAjax tryClothesWithSuccess:^(NSDictionary *json) {
        NSDictionary *results = json[@"results"];
        NSDictionary *total = results[@"total"];
        NSDictionary *fitt = results[@"fitt"];
        NSArray *list = results[@"list"];
        NSDictionary *list1 = [list objectAtIndex:0];
        NSDictionary *list2 = [list objectAtIndex:1];
        NSDictionary *list3 = [list objectAtIndex:2];
        NSLog(@"试衣Json---------%@",json);
        [_currentTryClothesLabel setText:FORMAT(@"%@",total[@"num"])];
        [_tryClothesInfo setText:FORMAT(@"%@%@",total[@"title"],total[@"info"])];
        [_tryClothesCountLabel setText:FORMAT(@"%@:%@%@",fitt[@"title"],fitt[@"num"],fitt[@"unit"])];
        _cup1ImageViewURL = list1[@"img"];
        _cup1Title = list1[@"title"];
        _cup1Num = list1[@"num"];
        _cup1Unit = list1[@"unit"];
        _cup1Price = list1[@"price"];
        
        _cup2ImageViewURL = list2[@"img"];
        _cup2Title = list2[@"title"];
        _cup2Num = list2[@"num"];
        _cup2Unit = list2[@"unit"];
        _cup2Price = list2[@"price"];
        
        _cup3ImageViewURL = list3[@"img"];
        _cup3Title = list3[@"title"];
        _cup3Num = list3[@"num"];
        _cup3Unit = list3[@"unit"];
        _cup3Price = list3[@"price"];
        //刷新tableView
        [_secondTableView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"设置试衣界面错误------------%@",error);
    }];
}
//设置试穿界面
- (void)setTryOn{
    [HomeAjax tryOnWithSuccess:^(NSDictionary *json) {
        NSDictionary *results = json[@"results"];
        NSDictionary *total = results[@"total"];
        NSDictionary *fitt = results[@"trying"];
        NSArray *list = results[@"list"];
        NSDictionary *list1 = [list objectAtIndex:0];
        NSDictionary *list2 = [list objectAtIndex:1];
        NSDictionary *list3 = [list objectAtIndex:2];
        NSLog(@"试穿Json---------%@",json);
        [_currentTryOnLabel setText:FORMAT(@"%@",total[@"num"])];
        [_tryOnInfoLabel setText:FORMAT(@"%@%@",total[@"title"],total[@"info"])];
        [_tryOnCountLabel setText:FORMAT(@"%@:%@%@",fitt[@"title"],fitt[@"num"],fitt[@"unit"])];
        _TryOnCup1ImageViewURL = list1[@"img"];
        _TryOnCup1Title = list1[@"title"];
        _TryOnCup1Num = list1[@"num"];
        _TryOnCup1Unit = list1[@"unit"];
        _TryOnCup1Price = list1[@"price"];
        
        _TryOnCup2ImageViewURL = list2[@"img"];
        _TryOnCup2Title = list2[@"title"];
        _TryOnCup2Num = list2[@"num"];
        _TryOnCup2Unit = list2[@"unit"];
        _TryOnCup2Price = list2[@"price"];
        
        _TryOnCup3ImageViewURL = list3[@"img"];
        _TryOnCup3Title = list3[@"title"];
        _TryOnCup3Num = list3[@"num"];
        _TryOnCup3Unit = list3[@"unit"];
        _TryOnCup3Price = list3[@"price"];
        [_thirdTableView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"设置试穿界面错误-------------%@",error);
    }];
}


- (IBAction)leftBtn1Click:(UIButton *)sender {
    if (sender.tag >4) {
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset = CGPointMake((sender.tag-5)*(375), -20);
        }];
    }
}

- (IBAction)rightBtn1Click:(UIButton *)sender {
    if (sender.tag<3) {
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset = CGPointMake(sender.tag * 375, -20);
        }];
    }
}

#pragma mark -- UItableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 102 || tableView.tag == 103) {
        return 3;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseId = @"";
    if (tableView.tag == 101) {
        if (indexPath.row == 0) {
            MaxViewCell *cell = [MaxViewCell maxViewCell:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([_joinMaxLabel isEqualToString:@"0"]) {
                [cell.joinMaxLabel setText: @"0"];
                [cell.joinmaxTimeLabel setText:@"00:00~00:00"];
                NSLog(@"cell.joinMaxLabel-------%@",cell.joinMaxLabel.text);
            }else{
                 [cell.joinMaxLabel setText: _joinMaxLabel];
                [cell.joinmaxTimeLabel setText: _joinmaxTimeLabel];
            }
            if ([_passMaxLabel isEqualToString:@"0"]) {
                [cell.passMaxLabel setText:@"0"];
                [cell.passMaxTimeLabel setText: @"00:00~00:00"];
            }else{
                [cell.passMaxLabel setText: _passMaxLabel];
                [cell.passMaxTimeLabel setText: _passMaxTimeLabel];
            }
            return cell;
        }else{
            reuseId = @"first2";
        }
    }
       if(tableView.tag == 102){
           if (indexPath.row == 0) {
               TryClothesCell *cell = [TryClothesCell tryClothesCell:tableView];
               [cell.cupImageView sd_setImageWithURL:[NSURL URLWithString:_cup1ImageViewURL]];
               [cell.clothesNameLabel setText:_cup1Title];
               [cell.numLabel setText:_cup1Num];
               [cell.unitLabel setText:_cup1Unit];
               [cell.priceLabel setText:_cup1Price];
               cell.selectionStyle = UITableViewCellSelectionStyleNone;
               return cell;
           }else if (indexPath.row == 1){
               TryClothesCell *cell = [TryClothesCell tryClothesCell:tableView];
               [cell.cupImageView sd_setImageWithURL:[NSURL URLWithString:_cup2ImageViewURL]];
               [cell.clothesNameLabel setText:_cup2Title];
               [cell.numLabel setText:_cup2Num];
               [cell.numLabel setTextColor:RGB(92, 128, 131)];
               [cell.unitLabel setText:_cup2Unit];
               [cell.unitLabel setTextColor:RGB(92, 128, 131)];
               [cell.priceLabel setText:_cup2Price];
               cell.stateImageView.image = [UIImage imageNamed:@"新品"];
               cell.selectionStyle = UITableViewCellSelectionStyleNone;
               return cell;
           }else{
               TryClothesCell *cell = [TryClothesCell tryClothesCell:tableView];
               [cell.cupImageView sd_setImageWithURL:[NSURL URLWithString:_cup3ImageViewURL]];
               [cell.clothesNameLabel setText:_cup3Title];
               [cell.numLabel setText:_cup3Num];
               [cell.numLabel setTextColor:RGB(130, 87, 12)];
               [cell.unitLabel setText:_cup3Unit];
               [cell.unitLabel setTextColor:RGB(130, 87, 12)];
               [cell.priceLabel setText:_cup3Price];
               cell.stateImageView.image = [UIImage imageNamed:@"活动"];
               cell.selectionStyle = UITableViewCellSelectionStyleNone;
               return cell;
           }
    }
    
    TryClothesCell *tryOnCell = [TryClothesCell tryClothesCell:tableView];
    tryOnCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView.tag == 103) {
        if (indexPath.row == 0) {
            [tryOnCell.cupImageView sd_setImageWithURL:[NSURL URLWithString:_TryOnCup1ImageViewURL]];
            [tryOnCell.clothesNameLabel setText:_TryOnCup1Title];
            [tryOnCell.numLabel setText:_TryOnCup1Num];
            [tryOnCell.unitLabel setText:_TryOnCup1Unit];
            [tryOnCell.priceLabel setText:_TryOnCup1Price];
            return tryOnCell;

        }else if (indexPath.row == 1){
            [tryOnCell.cupImageView sd_setImageWithURL:[NSURL URLWithString:_TryOnCup2ImageViewURL]];
            [tryOnCell.clothesNameLabel setText:_TryOnCup2Title];
            [tryOnCell.numLabel setText:_TryOnCup2Num];
            [tryOnCell.numLabel setTextColor:RGB(92, 128, 131)];
            [tryOnCell.unitLabel setText:_TryOnCup2Unit];
            [tryOnCell.unitLabel setTextColor:RGB(92, 128, 131)];
            [tryOnCell.priceLabel setText:_TryOnCup2Price];
            tryOnCell.stateImageView.image = [UIImage imageNamed:@"新品"];
            return tryOnCell;
        }else{
            [tryOnCell.cupImageView sd_setImageWithURL:[NSURL URLWithString:_TryOnCup3ImageViewURL]];
            [tryOnCell.clothesNameLabel setText:_TryOnCup3Title];
            [tryOnCell.numLabel setText:_TryOnCup3Num];
            [tryOnCell.numLabel setTextColor:RGB(130, 87, 12)];
            [tryOnCell.unitLabel setText:_TryOnCup3Unit];
            [tryOnCell.unitLabel setTextColor:RGB(130, 87, 12)];
            [tryOnCell.priceLabel setText:_TryOnCup3Price];
            tryOnCell.stateImageView.image = [UIImage imageNamed:@"活动"];
            return tryOnCell;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
    
    
}
    

//取消返回按钮的文字
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
}


#pragma mark -- UItableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 101) {
        return;
    }
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"AnalyseViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"ProductDetailsController"];
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark -- 按钮触发事件
- (IBAction)readEssay:(id)sender {
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"ZRInfomationViewController" bundle:[NSBundle mainBundle]];
    UIViewController *VC = [board instantiateViewControllerWithIdentifier:@"MainViewController"];
    [self.navigationController pushViewController:VC animated:YES];
}
- (IBAction)messageCenterClick:(id)sender {
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"ZRInfoCenterViewController" bundle:[NSBundle mainBundle]];
    UIViewController *VC = [board instantiateViewControllerWithIdentifier:@"MessageCenterViewController"];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
