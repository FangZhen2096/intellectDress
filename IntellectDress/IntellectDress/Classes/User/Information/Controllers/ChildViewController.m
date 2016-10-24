//
//  ChildViewController.m
//  clothesnews
//
//  Created by 小强 on 16/5/16.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "ChildViewController.h"
#import "MJRefresh.h"
#import "ArticleBiz.h"
#import "NewsCell.h"
#import "SDCycleScrollView.h"
@interface ChildViewController ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic)NSInteger page;
@property (nonatomic)NSMutableArray*datas;
@property (nonatomic)ArticleBiz*biz;
@property (nonatomic)SDCycleScrollView*bannerView;
@property (nonatomic)NSArray*banners;
@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bannerView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(100, 0, SCREENWIDTH, SCREENHEIGHT/3)];
    _bannerView.delegate = self;
//    _bannerView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    _bannerView.backgroundColor = [UIColor whiteColor];
    _bannerView.autoScrollTimeInterval = 4;
    _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _tableView.tableHeaderView = _bannerView;
    _datas = [[NSMutableArray alloc] init];
    _biz = [[ArticleBiz alloc] init];
    __weak ChildViewController*self_  = self;
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self_ loadData];
    }];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self_ reloadData];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"UPDATEARTICLELIST" object:nil];
    
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSDictionary*item = _banners[index];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ToDetail" object:item];
}

-(void)loadData{
    _loaded = YES;
    _page++;
    [_biz listinfo:_typeId page:_page userid:[UserBiz userId] callback:^(BOOL isError, NSDictionary *json) {
        [_tableView.mj_header endRefreshing];
        if (isError) {
            [_tableView.mj_footer endRefreshing];
            return ;
        }
        NSArray*array = json[@"results"];
        [_datas addObjectsFromArray:array];
        if (array.count<10) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [_tableView.mj_footer endRefreshing];
        }
        [_tableView reloadData];
    }];
}
-(void)reloadData{
    _page = 0;
    [_datas removeAllObjects];
    [self loadData];
    [_biz pic:_typeId
     callback:^(BOOL isError, NSDictionary *json) {
         if (isError) {
             return ;
         }
         NSMutableArray*titleArray = [[NSMutableArray alloc] init];
         NSMutableArray*urlArray = [[NSMutableArray alloc] init];
         
         _banners = json[@"results"];
         for (NSDictionary*item in _banners) {
             [titleArray addObject:FORMAT(@"%@",item[@"title"])];
             [urlArray addObject:FORMAT(@"%@",item[@"img"])];
         }
         _bannerView.imageURLStringsGroup = urlArray;
         _bannerView.titlesGroup = titleArray;
     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary*item = [_datas[indexPath.row] mutableCopy];
    item[@"read"] = @(YES);
    [_datas replaceObjectAtIndex:indexPath.row withObject:item];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ToDetail" object:item];
    [tableView reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell*cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    NSDictionary*item = array(_datas, indexPath.row);
    if (item) {
        [cell fillWithDic:item];
    }
    return  cell;
}

@end
