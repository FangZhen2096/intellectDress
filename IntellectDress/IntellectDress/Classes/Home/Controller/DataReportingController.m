//
//  DataReportingController.m
//  IntellectDress
//
//  Created by zerom on 16/9/30.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "DataReportingController.h"
#import "ReportingListCell.h"
#import "ReportListView.h"
#import "ReportListModel.h"
#import "ReportHearderView.h"
#import "ReportHeaderModel.h"
@interface DataReportingController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong ,nonatomic) NSMutableArray *cellArray;
@property (weak, nonatomic) IBOutlet UILabel *start;
@property (weak, nonatomic) IBOutlet UILabel *end;
@property (strong,nonatomic) NSMutableArray *reportModelArr;
@property (assign,nonatomic)NSInteger count;
@property (strong,nonatomic) ReportingListCell *reportingCell;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
//选中的按钮个数
@property (assign,nonatomic) NSInteger selectedBtnCount;
@property (copy,nonatomic) NSString *subtitle;
//@property (copy,nonatomic) NSString *start;
//@property (copy,nonatomic) NSString *end;
@property (weak, nonatomic) IBOutlet UIView *reportingView;
@property (assign,nonatomic)NSInteger sectionCount;
@property (strong,nonatomic) NSMutableArray *hearderArr;
@end

@implementation DataReportingController


#pragma mark -- 懒加载
- (NSMutableArray *)reportModelArr{
    if (_reportModelArr == nil) {
        _reportModelArr = [NSMutableArray array];
    }
    return _reportModelArr;
}
- (NSMutableArray *)hearderArr
{
    
    if (_hearderArr == nil) {
        _hearderArr = [NSMutableArray   array];
    }
    return _hearderArr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _navigationView.backgroundColor = defaultColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
    
    [_dateBtn roundWithRadius:11];
    [self setReportList];
//    [self LoadReportView];
}

//- (void)LoadReportView{
//    [self setReportList];
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReportListView" owner:self options:nil];
//    ReportListView *tmpCustomView = [nib objectAtIndex:0];
//    [tmpCustomView.title.titleLabel setText: _subtitle];
//    [tmpCustomView.start setText: _start];
//    [tmpCustomView.end setText: _end];
//    tmpCustomView.frame = CGRectMake(0, 0, 375, 400);
//    [self.reportingView addSubview:tmpCustomView];
//}
- (void)setReportList{
    [HomeAjax reportListWithSuccess:^(NSDictionary *dict) {
        NSArray *results = dict[@"results"];
        _sectionCount = results.count;
        NSDictionary *sub  = [NSDictionary dictionary];
        NSMutableArray *headerarr = [NSMutableArray arrayWithCapacity:_sectionCount];
        NSMutableArray *reportModelArr = [NSMutableArray array];
        for (int i =0; i<_sectionCount; i++) {
          sub = [results objectAtIndex:i];
            [headerarr addObject:sub];
            _hearderArr = headerarr;
        NSArray *list = sub[@"list"];
        _count = list.count;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_count];
        for (int i = 0; i<_count; i++) {
            NSDictionary *listsub = [list objectAtIndex:i];
            ReportListModel *model = [ReportListModel ReportListModelWithDict:listsub];
            [arr addObject:model];
        }
            
            [reportModelArr addObject:arr];
            _reportModelArr  = reportModelArr;
        }
        
//        NSString *start = sub[@"start"];
//        NSString *end = sub[@"end"];
//        NSString *title = sub[@"title"];
//        NSLog(@"start-----%@",start);
//        _start.text = start;
//        _end.text = end;
//        _dateBtn.titleLabel.text = title;
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark -- tableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportingListCell *cell = [ReportingListCell reportingListCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *arr = [_reportModelArr objectAtIndex:indexPath.section];
    ReportListModel *model = [arr objectAtIndex:indexPath.row];
    if ([model.read intValue] == 0) {
        [cell.storeNameLabel setTextColor:[UIColor grayColor]];
    }
    cell.storeNameLabel.text = model.title;
    cell.reportingContentLabel.text = model.info;
    
    return cell;
}
#pragma mark -- tableView代理方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 13, 40, 23)];
    UILabel *start =[[UILabel alloc] initWithFrame:CGRectMake(66, 14, 100, 21)];
    UILabel *end =[[UILabel alloc] initWithFrame:CGRectMake(191, 14, 100, 21)];
    UILabel *zhi = [[UILabel alloc] initWithFrame:CGRectMake(170, 14, 18, 21)];
    zhi.text = @"至";
    title.backgroundColor = defaultColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [title roundWithRadius:5];
     NSDictionary *sub  = [_hearderArr objectAtIndex:section];
    ReportHeaderModel *model = [ReportHeaderModel ReportHeaderModelWithDict:sub];
    UIView *heardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 50)];
    title.text= model.title;
    start.text = model.start;
    end.text = model.end;
    [heardView addSubview:title];
    [heardView addSubview:start];
    [heardView addSubview:end];
    [heardView addSubview:zhi];

    return heardView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
#pragma mark -- 按钮点击事件
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
- (NSMutableArray *)cellArray{
    if (_cellArray == nil) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}

@end
