//
//  AnalyseViewController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/2.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "AnalyseViewController.h"
#import "HotRankShopCell.h"
#import "AnalyseAjax.h"
#import "HotRankModel.h"

@interface AnalyseViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *firstTableView;

@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;
@property (weak, nonatomic) IBOutlet UITableView *thirdTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentView;
//选择（今周，今月，今季）
@property (copy,nonatomic) NSString *timeChose;


@property (strong,nonatomic)  HotRankModel*hotRankModel;
@property (strong,nonatomic) NSMutableArray *hotRankArray;

@end

@implementation AnalyseViewController

#pragma mark -- 懒加载
- (NSMutableArray *)hotRankArray{
    if (_hotRankArray == nil) {
        _hotRankArray = [[NSMutableArray alloc] init];
    }
    return _hotRankArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
    [self setHotRank];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _bigScrollView.delegate = self;
    _firstTableView.dataSource = self;
    _firstTableView.delegate = self;
    _secondTableView.dataSource = self;
    _secondTableView.delegate = self;
    _thirdTableView.dataSource = self;
    _thirdTableView.delegate = self;
    _bigScrollView.contentSize = CGSizeMake(_bigScrollView.frame.size.width, 0);
    _timeChose = @"week";
}

- (void)setHotRank{
    [AnalyseAjax HotRankWithTime:_timeChose Success:^(NSDictionary *dict) {
        NSLog(@"热度排行------Json:%@",dict);
        NSDictionary *results = dict[@"results"];
        NSArray *list = results[@"list"];
        NSMutableArray *hotRankArray = [NSMutableArray arrayWithCapacity:list.count];
        for (int i = 0; i < list.count; i++) {
            NSDictionary *listSub = [list objectAtIndex:i];
            _hotRankModel = [HotRankModel hotRankModelWithDict:listSub];
            [hotRankArray addObject:_hotRankModel];
            _hotRankArray = hotRankArray;
        }

        if ([_timeChose isEqualToString:@"week"]) {
            [self.firstTableView reloadData];
        }else if ([_timeChose isEqualToString:@"month"]){
            [self.secondTableView reloadData];
        }else{
            [self.thirdTableView reloadData];
        }
        
        
    } failed:^(NSError *error) {
        NSLog(@"热度分析error-------%@",error);
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotRankShopCell *cell = [HotRankShopCell HotRankShopCell:tableView];
    HotRankModel *hotrankModel = [_hotRankArray objectAtIndex:indexPath.row];
    [cell.rankNumLabel setText:hotrankModel.ber];
    [cell.shopNameLabel setText:hotrankModel.title];
    [cell.shopNumLabel setText:hotrankModel.number];
    [cell.shopPriceLabel setText:hotrankModel.price];
    [cell.shopProgressView setProgress:[hotrankModel.rate intValue]/100.0 animated:YES];
    [cell.shopImage sd_setImageWithURL:[NSURL URLWithString:hotrankModel.img]];
    [cell.progressPercentLabel setText:FORMAT(@"%@%@",hotrankModel.rate,hotrankModel.unit)];
    
        switch (indexPath.row) {
            case 0:
                [cell.rankNumLabel setTextColor:RGB(255, 192, 0)];
                return cell;
                break;
            case 1:
                
               [cell.rankNumLabel setTextColor:RGB(93, 128, 131)];
                return cell;
                break;
            case 2:
                
                [cell.rankNumLabel setTextColor:RGB(131, 89, 15)];
                return cell;
                break;
            case 3:
                
                [cell.rankNumLabel setTextColor:RGB(176, 176, 176)];
                return cell;
                break;
            case 4:
                [cell.rankNumLabel setTextColor:RGB(176, 176, 176)];
                return cell;
                break;
            default:
                break;
        }
    
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

- (IBAction)segmentDidClick:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.bigScrollView.contentOffset = CGPointMake(0, 0);
        }];
        self.timeChose = @"week";
        [self setHotRank];
        
    }else if ( sender.selectedSegmentIndex == 1){
        [UIView animateWithDuration:0.5 animations:^{
            self.bigScrollView.contentOffset = CGPointMake(SCREENWIDTH, 0);
        }];
        self.timeChose = @"month";
        [self setHotRank];

        
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.bigScrollView.contentOffset = CGPointMake(SCREENWIDTH*2, 0);
        }];
        self.timeChose = @"quarter";
        [self setHotRank];

        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x >= SCREENWIDTH * 0.5 && scrollView.contentOffset.x <SCREENWIDTH *1.5) {
        [self.segmentView setSelectedSegmentIndex:1];
        
    }else if (scrollView.contentOffset.x >= SCREENWIDTH *1.5){
        [self.segmentView setSelectedSegmentIndex:2];
        
    }else{
        [self.segmentView setSelectedSegmentIndex:0];
        
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == SCREENWIDTH) {
        self.timeChose = @"month";
        [self setHotRank];
    }else if (scrollView.contentOffset.x == 2*SCREENWIDTH){
        self.timeChose = @"quarter";
        [self setHotRank];
    }else{
        self.timeChose = @"week";
        [self setHotRank];
    }
}


@end
