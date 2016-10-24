//
//  ZRMemoController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/23.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRMemoController.h"
#import "ZRMemoCell.h"
#import "MemoListModel.h"
#import "ZRMemoDetailsController.h"
@interface ZRMemoController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UITableView *memoTableView;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (assign,nonatomic)NSInteger count;
@property (strong,nonatomic) MemoListModel *memoListModel;
@property (strong,nonatomic) NSMutableArray *memolistArr;
@property (strong,nonatomic) NSMutableArray *cellArr;
@property (copy,nonatomic) NSString *bid;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *allSelectedBtn;
@property (strong,nonatomic) ZRMemoCell *memoCell;
@property (assign,nonatomic)NSInteger selectedBtnCount;
@property (copy,nonatomic) NSString *bids;
@end

@implementation ZRMemoController

#pragma mark  -- 懒加载
- (NSMutableArray *)memolistArr{
    if (_memolistArr== nil) {
        _memolistArr = [NSMutableArray array];
    }
    return  _memolistArr;
}

- (NSMutableArray *)cellArr{
    if (_cellArr == nil) {
        _cellArr = [NSMutableArray array];
    }
    return _cellArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _memoTableView.dataSource = self;
    _memoTableView.delegate  = self;
    _navigationView.backgroundColor = defaultColor;
    
}

- (void)setMemoList{
    [MemoAjax MemoListWithSuccess:^(NSDictionary *dict) {
        NSArray *results = dict[@"results"];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:results.count];
        _count = results.count;
        for (int i =0; i < _count; i++) {
            NSDictionary *sub = [results objectAtIndex:i];
            _memoListModel = [MemoListModel memoListModelWithDict:sub];
            [arr addObject:_memoListModel];
        }
        _memolistArr = arr;
        [self.memoTableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}


#pragma mark -- 按钮触发事件
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)allChoseBtnClick:(id)sender {
    _allSelectedBtn.selected = !_allSelectedBtn.selected;
    if (_selectedBtnCount == [_cellArr count]) {
        for (ZRMemoCell *cell in self.cellArr) {
            self.memoCell = cell;
            [self.memoCell.selectedBtn setSelected:NO];
        }
    }else{
        for (ZRMemoCell *cell in self.cellArr) {
            self.memoCell = cell;
            [self.memoCell.selectedBtn setSelected:YES];
        }
    }
    if (_allSelectedBtn.selected) {
        for (ZRMemoCell *cell in self.cellArr) {
            self.memoCell = cell;
            [self.memoCell.selectedBtn setSelected:YES];
            _selectedBtnCount = [_cellArr count];
            
        }
    }else{
        for (ZRMemoCell *cell in self.cellArr) {
            self.memoCell = cell;
            [self.memoCell.selectedBtn setSelected:NO];
            _selectedBtnCount =0;
        }
    }

}

- (IBAction)delBtnClick:(id)sender {
    NSLog(@"bids--------%@",_bids);
    [MemoAjax DelsMemoDetailsWithBid:_bids Success:^(NSDictionary *dict) {
        
    } failed:^(NSError *error) {
        
    }];
    [UIView animateWithDuration:0.5 animations:^{
        _bottomView.transform = CGAffineTransformMakeTranslation(0, 49);
    } completion:^(BOOL finished) {
        for (ZRMemoCell *cell in self.cellArr) {
            self.memoCell = cell;
            [cell.selectedBtn setHidden:YES];
            [cell.markBtn setHidden:NO];
        }
        [self setMemoList];
    }];
}

- (IBAction)editBtnClick:(id)sender {
    if (_bottomView.frame.origin.y >= 667) {
//        [UIView animateWithDuration:0.5 animations:^{
//            _bottomView.transform = CGAffineTransformMakeTranslation(0, 0);
//            for (ZRMemoCell *cell in self.cellArr) {
//                self.memoCell = cell;
//                [cell.selectedBtn setHidden:NO];
//                [cell.markBtn setHidden:YES];
//            }
//        }];
        [UIView animateWithDuration:0.5 animations:^{
            _bottomView.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            for (ZRMemoCell *cell in self.cellArr) {
                self.memoCell = cell;
                [cell.selectedBtn setHidden:NO];
                [cell.markBtn setHidden:YES];
            }
            [self.memoTableView reloadData];
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _bottomView.transform = CGAffineTransformMakeTranslation(0, 49);
            for (ZRMemoCell *cell in self.cellArr) {
                self.memoCell = cell;
                [cell.selectedBtn setHidden:YES];;
                [self.memoCell.selectedBtn setSelected:NO];
                [cell.markBtn setHidden:NO];
            }
        }];
        [self.allSelectedBtn setSelected:NO];
        [self.memoTableView reloadData];
    }
    
}
#pragma mark -- UITableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZRMemoCell *cell = [ZRMemoCell memoCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _memoListModel = [_memolistArr objectAtIndex:indexPath.row];
    [cell.title setText:_memoListModel.info];
    [cell.time setText:_memoListModel.time];
    [_cellArr addObject:cell];
    return cell;
}

#pragma mark -- UITableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_bottomView.frame.origin.y>=667) {
        UIStoryboard*board = [UIStoryboard storyboardWithName:@"ZRMemoController" bundle:[NSBundle mainBundle] ];
        ZRMemoDetailsController*controller = [board instantiateViewControllerWithIdentifier:@"ZRMemoDetailsController"];
        _memoListModel = [_memolistArr objectAtIndex:indexPath.row];
        _bid = _memoListModel.ID;
        controller.bid = _bid;
        NSLog(@"bid------%@",_bid);
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        ZRMemoCell *cell = [self.memoTableView cellForRowAtIndexPath:indexPath];
        _memoListModel  = [_memolistArr objectAtIndex:indexPath.row];
        if (_bids == nil) {
            _bids = [NSString stringWithFormat:@"%@",_memoListModel.ID];
        }else{
            _bids = [NSString stringWithFormat:@"%@,%@",_bids,_memoListModel.ID];
        }

        cell.selectedBtn.selected = !cell.selectedBtn.selected;
        if (cell.selectedBtn.selected == YES) {
            _selectedBtnCount++;
        }else{
            _selectedBtnCount--;
        }
        if (_selectedBtnCount == [_cellArr count]) {
            [_allSelectedBtn setSelected:YES];
        }else{
            [_allSelectedBtn setSelected:NO];
        }

    }
    
}


//取消右滑返回手势
-(void)viewDidAppear:(BOOL)animated{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [self setMemoList];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.tabBar.hidden = YES;
    _bottomView.transform = CGAffineTransformMakeTranslation(0, 49);
    [self setMemoList];
    
}
@end
