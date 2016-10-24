//
//  SearchViewController.m
//  clothesnews
//
//  Created by 小强 on 16/5/20.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "SearchViewController.h"
#import "DB.h"
#import "ArticleBiz.h"
#import "HistoryCell.h"
#import "NewsDetailViewController.h"
#import "SearchResultCell.h"
#import "MJRefresh.h"

@interface SearchViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *circleContainerView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *hotTableView;
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
@property (weak, nonatomic) IBOutlet UIView *historyContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *historyContainerViewHeight;
@property (nonatomic)DB*db;
@property (nonatomic)NSMutableArray*historyDatas;
@property (nonatomic)ArticleBiz*biz;
@property (nonatomic)NSInteger page;
@property (nonatomic)NSMutableArray*searchDatas;
@property (nonatomic)NSMutableArray*hotDatas;
@property (nonatomic)NSDictionary*newsDetailData;
@property (weak, nonatomic) IBOutlet UIView *searchResultContainer;
@property (nonatomic)NSInteger hotPage;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIView *searchResultView;
@property (weak, nonatomic) IBOutlet UITableView *searchResultTableView;
@property (nonatomic)NSInteger searchResultPage;
@end

@implementation SearchViewController


//- (void)viewDidDisappear:(BOOL)animated
//{
//    self.navigationController.navigationBar.hidden = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    _biz =[[ArticleBiz alloc] init];
    _hotDatas = [[NSMutableArray alloc] init];
    _hotTableView.scrollEnabled = _historyTableView.scrollEnabled = NO;
    _searchDatas = [[NSMutableArray alloc] init];
    [_circleContainerView roundWithRadius:12];
    _historyDatas  = [[NSMutableArray alloc] init];
    _db = [[DB alloc] init];
    [_db addTable:@"create table if not exists SearchHistory (id integer primary key autoincrement  ,key char)"];
    [self loadHistory];
    [self changeHot];
    __weak SearchViewController*self_ = self;
    _searchResultTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self_ search];
    }];
    [_searchTextField addTarget:self action:@selector(handleSearchTextChange:) forControlEvents:UIControlEventEditingChanged];
}
-(void)handleSearchTextChange:(UITextField*)textField{
    if ([textField.text isempty]) {
        _searchResultContainer.hidden = YES;
    }
    
}
-(void)loadHistory{
    [_historyDatas removeAllObjects];
    [_db query:@"select * from SearchHistory" callback:^(NSMutableArray *result) {
        [_historyDatas addObjectsFromArray:[[result reverseObjectEnumerator] allObjects]];
        [self calculateHistoryHeight];
        [self.historyTableView reloadData];
    }];
}
-(void)calculateHistoryHeight{
    if (_historyDatas.count==0) {
        _historyContainerView.hidden = YES;
        _historyContainerViewHeight.constant = 0;
        [self.view layoutIfNeeded];
        return;
    }
    _historyContainerView.hidden = NO;
    if (_historyDatas.count>=5) {
        _historyContainerViewHeight.constant = 290;
    }else{
        _historyContainerViewHeight.constant = 40+_historyDatas.count*50;
    }
    
}
- (IBAction)changeHotBtnClick:(id)sender {
    [self changeHot];
}
-(void)changeHot{
    _hotPage++;
    [_biz hot:_hotPage callback: ^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        [_hotDatas removeAllObjects];
        [self.hotTableView reloadData];
        [_hotDatas addObjectsFromArray:json[@"results"]];
        if (_hotDatas.count<6) {
            _hotPage = 0;
        }
        [self.hotTableView reloadData];
        
    }];
}
-(void)search{
    _searchResultContainer.hidden = NO;
    _page++;
    _totalLabel.text = @"正在搜索....";
    [_biz search:_searchTextField.text  page:_page callback:^(BOOL isError, NSDictionary *json) {
        
        if (isError) {
            [_searchResultTableView.mj_footer endRefreshing];
            [_searchResultTableView reloadData];
            _searchResultView.hidden = YES;
            _emptyView.hidden = NO;
            return ;
        }
        NSDictionary*results = json[@"results"];
        NSArray*resultList =results[@"list"];
        if (resultList.count<10) {
            [_searchResultTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [_searchResultTableView.mj_footer endRefreshing];
        }
        [_searchDatas addObjectsFromArray:resultList];
        [_searchResultTableView reloadData];
        if (_searchDatas.count==0) {
            _searchResultView.hidden = YES;
            _emptyView.hidden = NO;
        }else{
            _emptyView.hidden = YES;
            _searchResultView.hidden = NO;
        }
        _totalLabel.text  = FORMAT(@"经营宝为您搜索到相关结果%@个",results[@"total"]);
    }];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clearHistoryBtnClick:(id)sender {
    if ([_db idu:@"delete from SearchHistory"]) {
        [_historyDatas removeAllObjects];
        [self.historyTableView reloadData];
        //hidden
        [self calculateHistoryHeight];
    }else{
        [SVProgressHUD showInfoWithStatus:@"删除失败"];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_historyTableView) {
        return _historyDatas.count>=5?5:_historyDatas.count;
    }
    if (tableView==_hotTableView) {
        if (_hotDatas) {
            return _hotDatas.count;
        }
    }
    if (tableView==_searchResultTableView) {
        return _searchDatas.count;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView==_historyTableView) {
        self.searchTextField.text = FORMAT(@"%@",_historyDatas[indexPath.row][@"key"]);
        [self search];
    }
    if (tableView==_hotTableView) {
        _newsDetailData = _hotDatas[indexPath.row];
        [self performSegueWithIdentifier:@"search-newsdetail" sender:nil];
    }
    if (tableView==_searchResultTableView) {
        _newsDetailData = _searchDatas[indexPath.row];
        [self performSegueWithIdentifier:@"search-newsdetail" sender:nil];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_historyTableView) {
        HistoryCell*cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
        cell.delBtn.tag = indexPath.row;
        [cell.delBtn addTarget:self action:@selector(deleteHistory:) forControlEvents:UIControlEventTouchUpInside];
        cell.historyLabel.text= FORMAT(@"%@",_historyDatas[indexPath.row][@"key"]);
        return  cell;
    }
    if (tableView==_hotTableView) {
        UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.textLabel.text = FORMAT(@"⋅ %@",_hotDatas[indexPath.row][@"title"]);
        return cell;
    }
    
    if (tableView ==_searchResultTableView) {
        SearchResultCell*cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
        [cell fillWithDic:_searchDatas[indexPath.row] searchKey:_searchTextField.text];
        return  cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    return  cell;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField.text isempty]) {
        _searchResultContainer.hidden = YES;
    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    _searchResultContainer.hidden = YES;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self searchBtnclick:nil];
    return YES;
}
- (IBAction)searchBtnclick:(id)sender {
    [self.view endEditing:YES];
    if ([_searchTextField.text isempty]) {
        [SVProgressHUD showInfoWithStatus:@"请输入搜索内容"];
        return;
    }
    BOOL haveHistory = NO;
    for (NSDictionary*item in _historyDatas) {
        if ([FORMAT(@"%@",item[@"key"]) isEqualToString:_searchTextField.text]) {
            haveHistory = YES;
            break;
        }
    }
    if (!haveHistory) {
        NSString*sql =FORMAT(@"insert into SearchHistory (key) values('%@')",_searchTextField.text);
        [_db idu:sql];
    }
    _page=0;
    [_searchDatas removeAllObjects];
    [self search];
    [self loadHistory];
    //search
}
-(void)deleteHistory:(UIButton*) sender{
    NSInteger index= sender.tag;
    if ([_db idu:FORMAT(@"delete from SearchHistory where id = %@",_historyDatas[index][@"id"])]) {
        [_historyDatas removeObjectAtIndex:index];
        [_historyTableView reloadData];
//        NSIndexPath*indexPath = [NSIndexPath indexPathForRow:index inSection:0] ;
//        [_historyTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self calculateHistoryHeight];
    }else{
        [SVProgressHUD showInfoWithStatus:@"删除失败"];
    }
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"search-newsdetail"]) {
        //构造没有的的键值
        NewsDetailViewController*detail = segue.destinationViewController;
        NSMutableDictionary*mutDic  =[_newsDetailData mutableCopy];
        mutDic[@"info"] = mutDic[@"title"];
        mutDic[@"img"]  = @"";
        detail.data =mutDic;
    }
}



@end
