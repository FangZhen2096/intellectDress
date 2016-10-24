//
//  CollectionViewController.m
//  clothesnews
//
//  Created by 小强 on 16/5/18.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "CollectionViewController.h"
#import "MJRefresh.h"
#import "NewsCell.h"
#import "ArticleBiz.h"
#import "NewsDetailViewController.h"
@interface CollectionViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic)NSMutableArray*datas;
@property (nonatomic)NSInteger page;
@property (nonatomic)ArticleBiz*biz;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *allchooseBtn;
@property (strong, nonatomic) IBOutlet UIView *emptyView;
@property (nonatomic)NSDictionary*selectedItem;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _datas= [[ NSMutableArray alloc] init];
    _biz = [[ArticleBiz alloc] init];
    __weak CollectionViewController*self_  = self;
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self_ loadData];
    }];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self_ reloadData];
    }];
    [self reloadData];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
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
        return;
    }
    NSMutableString*ids = [[NSMutableString alloc] init];
    for (NSInteger  i =0; i<indexPths.count; i++) {
        NSIndexPath*path = indexPths[i];
        NSDictionary*item = array(_datas, path.row);
        [ids appendFormat:@"%@,",item[@"id"]];
    }
    
    
    [ids deleteCharactersInRange:NSMakeRange(ids.length-1, 1)];
    [_biz delfavorite:ids userid:[UserBiz userId] callback:^(BOOL isError, NSDictionary *json) {
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
        self.tableView.hidden =_datas.count==0;
        if (_datas.count==0) {
            _emptyView.hidden = NO;
            self.navigationItem.rightBarButtonItem = nil;
            self.navigationItem.rightBarButtonItem = nil;
            _bottomViewHeight.constant=0;
            [UIView animateWithDuration:0.33 animations:^{
                [self.view layoutIfNeeded];
                _bottomView.alpha =0;
            }];
        }
        
    }];
}

-(void)dealloc{
    [self.tableView endEditing:YES];
}

- (IBAction)editBtnClick:(id)sender {
    if (_datas.count==0) {
        return;
    }
    _allchooseBtn.selected = NO;
    
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    if (self.tableView.isEditing) {
        _bottomViewHeight.constant = 50;
        
    }else{
        _bottomViewHeight.constant = 0;
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
-(void)loadData{
    _page++;
    [_biz favorites:[UserBiz userId] page:_page callback:^(BOOL isError, NSDictionary *json) {
        [_tableView.mj_header endRefreshing];
        if (isError) {
            _emptyView.hidden = NO;
            self.navigationItem.rightBarButtonItem = nil;
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
        if (_datas.count==0) {
            _emptyView.hidden = NO;
            self.navigationItem.rightBarButtonItem = nil;
        }else{
            _emptyView.hidden = YES;
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)reloadData{
    _page = 0;
    [_datas removeAllObjects];
    [self loadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}
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
        _selectedItem = _datas[indexPath.row];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self performSegueWithIdentifier:@"collect-newsdetail" sender:nil];
    }else{
        NSArray*indexPths= self.tableView.indexPathsForSelectedRows;
        if (indexPths.count==_datas.count) {
            _allchooseBtn.selected = YES;
        }else{
            _allchooseBtn.selected = NO;
        }
    }
    //    NSMutableDictionary*item = [_datas[indexPath.row] mutableCopy];
    //    item[@"read"] = @(YES);
    //    [_datas replaceObjectAtIndex:indexPath.row withObject:item];
    
    //    [tableView reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell*cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    NSDictionary*item = array(_datas, indexPath.row);
    if (item) {
        [cell fillWithDic:item];
    }
    return  cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"collect-newsdetail"]) {
        NewsDetailViewController*detail = segue.destinationViewController;
        detail.data = _selectedItem;
    }
}




@end
