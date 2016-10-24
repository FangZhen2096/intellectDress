//
//  MessageCenterViewController.m
//  clothesnews
//
//  Created by 小强 on 16/5/20.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MessageBiz.h"
#import "MJRefresh.h"
#import "WebViewController.h"
#import "MessageCell.h"
#import "infoModel.h"
#import "InfoListCell.h"
@interface MessageCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *allchooseBtn;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic)MessageBiz*biz;
@property (nonatomic)NSMutableArray*datas;
@property (nonatomic)NSInteger page;
@property (strong,nonatomic) infoModel *infoModel;
@property (strong,nonatomic) NSMutableArray *infoModelArr;
@property (assign,nonatomic)NSInteger count;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic)NSDictionary*selectedItem;
@end

@implementation MessageCenterViewController

#pragma mark -- 懒加载
- (NSMutableArray *)infoModelArr{
    if (_infoModelArr == nil) {
        _infoModelArr = [NSMutableArray array];
    }
    return _infoModelArr;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //取消返回按钮文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    _bottomView.transform =  CGAffineTransformMakeTranslation(0, 50);
    _biz = [[MessageBiz alloc] init];
    _datas = [[NSMutableArray alloc] init];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self reloadData];
    }];
    [self reloadData];

}

- (void)setInfoList{
    [InfoCenterAjax infoCenterWithSuccess:^(NSDictionary *dict) {
        NSArray *results = dict[@"results"];
        _count = results.count;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_count];
        for (int i =0; i<_count; i++) {
            NSDictionary *sub = [results objectAtIndex:i];
            _infoModel = [infoModel infoModelWithDict:sub];
            [arr addObject:_infoModel];
        }
        _infoModelArr = arr;
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}
- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}
-(void)loadData{
    _page++;
    [_biz userinfo:[UserBiz userId] page:_page calback:^(BOOL isError, NSDictionary *json) {
        [self.tableView.header endRefreshing];
        if (isError) {
            
            self.navigationItem.rightBarButtonItem = nil;
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
//            _emptyView.hidden = _datas.count!=0;
//            _tableView.hidden = !_emptyView.hidden;
            
            return ;
        }
        NSArray*results = json[@"results"];
        [_datas addObjectsFromArray:results];
        if (results.count<10) {
            [self.tableView.footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.footer endRefreshing];
        }
        if (_datas.count==0) {
            self.navigationItem.rightBarButtonItem = nil;
        }
//        _emptyView.hidden = _datas.count!=0;
//        _tableView.hidden = !_emptyView.hidden;
        
        [self.tableView reloadData];
    }];
    
}
-(void)reloadData{
    _page=0;
    [self.datas removeAllObjects];
    [self loadData];
}
-(void)dealloc{
    [self.tableView endEditing:YES];
}

- (IBAction)allChooceBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    for (NSInteger i =0; i<_datas.count; i++) {
        NSIndexPath*path = [NSIndexPath indexPathForRow:i inSection:0];
        if (sender.selected) {
            [self.tableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }else{
            [self.tableView deselectRowAtIndexPath:path animated:YES];
        }
        
    }
}

- (IBAction)delBtnClick:(id)sender {
    NSArray*indexPths= self.tableView.indexPathsForSelectedRows;
    if (indexPths.count==0) {
        [SVProgressHUD showInfoWithStatus:@"还没有选择"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    NSMutableString*ids = [[NSMutableString alloc] init];
    for (NSInteger  i =0; i<indexPths.count; i++) {
        NSIndexPath*path = indexPths[i];
        NSDictionary*item = array(_datas, path.row);
        [ids appendFormat:@"%@,",item[@"id"]];
    }
    
    
    [ids deleteCharactersInRange:NSMakeRange(ids.length-1, 1)];
    [_biz delinfo:ids userid:[UserBiz userId] callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        NSMutableIndexSet*set = [[NSMutableIndexSet alloc] init];
        for (NSInteger  i =0; i<indexPths.count; i++) {
            NSIndexPath*path = indexPths[i];
            [set addIndex:path.row];
        }
        
        
        [_datas removeObjectsAtIndexes:set];
        
        
        [self.tableView deleteRowsAtIndexPaths:indexPths withRowAnimation:UITableViewRowAnimationFade];
        
//        self.tableView.hidden =_datas.count==0;
//        _emptyView.hidden = !self.tableView.hidden;
        
        if (_datas.count==0) {
            [self.tableView endEditing:YES];
            self.tableView.hidden =YES;
            
            self.navigationItem.rightBarButtonItem = nil;
            [UIView animateWithDuration:0.33 animations:^{
                [self.view layoutIfNeeded];
                _bottomView.transform = CGAffineTransformMakeTranslation(0, 50);
                
            }];
            
            
        }
    }];
}

#pragma mark -- UITableView代理方法
-(void)tableView:(UITableView*)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSArray*indexPths= self.tableView.indexPathsForSelectedRows;
    if (indexPths.count==_datas.count) {
        _allchooseBtn.selected = YES;
    }else{
        _allchooseBtn.selected = NO;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!tableView.isEditing) {
        NSMutableDictionary*item = [_datas[indexPath.row] mutableCopy];
        if (![item[@"see"] boolValue]) {
            [_biz read:FORMAT(@"%@",item[@"id"]) userid:[UserBiz userId] callback:^(BOOL isError, NSDictionary *json) {
                [self.tableView reloadData];
            }];
        }
        item[@"see"] = @(YES);
        [self.datas replaceObjectAtIndex:indexPath.row withObject:item];
        WebViewController*web = [[WebViewController alloc] init];
        web.htmlStr = FORMAT(@"%@",item[@"info"]);
        web.navTitle = FORMAT(@"%@",item[@"title"]);
        
        [ self.navigationController pushViewController:web animated:YES];
    }else{
        NSArray*indexPths= self.tableView.indexPathsForSelectedRows;
        if (indexPths.count==_datas.count) {
            _allchooseBtn.selected = YES;
        }else{
            _allchooseBtn.selected = NO;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
#pragma  mark -- UITableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell*cell=  [tableView dequeueReusableCellWithIdentifier:@"CELL"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary*item = array(_datas, indexPath.row);
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    if (item) {
        [cell fillWithDic:item];
    }

    return  cell;
}


- (IBAction)editBtnClick:(id)sender {
    if (_datas.count==0) {
        return;
    }
    _allchooseBtn.selected = NO;
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    if (self.tableView.isEditing) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.view bringSubviewToFront:_bottomView];
//            _bottomView.transform = CGAffineTransformMakeTranslation(0, -50);
            _bottomView.hidden = NO;
            _bottomViewHeight.constant = 50;
        }];
        
    }else{

        [UIView animateWithDuration:0.5 animations:^{
//            _bottomView.transform = CGAffineTransformMakeTranslation(0, 0);
            _bottomViewHeight.constant = 0;
            _bottomView.hidden = YES;
        }];
    }
    [UIView animateWithDuration:0.33 animations:^{
        [self.view layoutIfNeeded];
        if (self.tableView.isEditing) {
            _bottomView.alpha =1;
        }else{
            _bottomView.alpha =0;
        }
    }];
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

@end
