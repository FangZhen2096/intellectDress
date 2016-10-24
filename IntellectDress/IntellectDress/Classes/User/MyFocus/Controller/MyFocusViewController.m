//
//  MyFocusViewController.m
//  IntellectDress
//
//  Created by zerom on 16/9/29.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "MyFocusViewController.h"
#import "FocusViewCell.h"
#import "FocusModel.h"
@interface MyFocusViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong ,nonatomic) FocusViewCell *focusCell;
@property (strong ,nonatomic) NSMutableArray *cellArray;
@property (weak, nonatomic) IBOutlet UIButton *allSelectedBtn;
//选中的按钮个数
@property (assign,nonatomic) NSInteger selectedBtnCount;
@property (assign,nonatomic)NSInteger count;
@property (strong,nonatomic) NSMutableArray *FocusArr;
@end

@implementation MyFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _bottomView.transform = CGAffineTransformMakeTranslation(0, 49);
    [self setFocusList];
}

- (void)setFocusList{
    [FocusAjax FocusListWithSuccess:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        NSArray *list = results[@"list"];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
        _count = list.count;
        for (int i =0; i<_count; i++) {
            NSDictionary *sub = [list objectAtIndex:i];
            FocusModel *model = [FocusModel FocusModelWithDict:sub];
            [arr addObject:model];
        }
        _FocusArr = arr;
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}


#pragma mark -- tableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FocusViewCell *cell = [FocusViewCell focusCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FocusModel *model = [_FocusArr objectAtIndex:indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.img]];
    cell.title.text = model.title;
    cell.number.text = model.number;
    cell.display.text = [NSString stringWithFormat:@"%@:",model.display];
    cell.piece.text = model.piece;
    cell.trying.text = [NSString stringWithFormat:@"%@:",model.trying];
    cell.num.text = model.num;
    cell.fitt.text =[NSString stringWithFormat:@"%@:",model.fitt];
    cell.ber.text = model.ber;
    cell.price.text = model.price;
    [self.cellArray addObject:cell];
    return cell;
    
}

#pragma mark -- tableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FocusViewCell *cell  = [self.tableView cellForRowAtIndexPath:indexPath];
    if (_bottomView.frame.origin.y >= 667) {
        UIStoryboard*board = [UIStoryboard storyboardWithName:@"AnalyseViewController" bundle:[NSBundle mainBundle] ];
        UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"ProductDetailsController"];
        NSString *gid = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"productDidClick" object:gid];
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    cell.selectedBtn.selected = !cell.selectedBtn.selected;
    if (cell.selectedBtn.selected == YES) {
        _selectedBtnCount++;
    }else{
        _selectedBtnCount--;
    }
    if (_selectedBtnCount == [_cellArray count]) {
        [_allSelectedBtn setSelected:YES];
    }else{
        [_allSelectedBtn setSelected:NO];
    }
    
}

#pragma mark -- 按钮点击事件
- (IBAction)backBtnClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)allSelectedBtnClick:(id)sender {
    _allSelectedBtn.selected = !_allSelectedBtn.selected;
    if (_selectedBtnCount == [_cellArray count]) {
        for (FocusViewCell *cell in self.cellArray) {
            self.focusCell = cell;
            [self.focusCell.selectedBtn setSelected:NO];
        }
    }else{
        for (FocusViewCell *cell in self.cellArray) {
            self.focusCell = cell;
            [self.focusCell.selectedBtn setSelected:YES];
        }
    }
    if (_allSelectedBtn.selected) {
        for (FocusViewCell *cell in self.cellArray) {
            self.focusCell = cell;
            [self.focusCell.selectedBtn setSelected:YES];
            _selectedBtnCount = [_cellArray count];

        }
    }else{
        for (FocusViewCell *cell in self.cellArray) {
            self.focusCell = cell;
            [self.focusCell.selectedBtn setSelected:NO];
            _selectedBtnCount =0;
        }
    }
    
}

- (IBAction)editBtnClick:(id)sender {
    if (_bottomView.frame.origin.y >= 667) {
        [UIView animateWithDuration:0.5 animations:^{
            _bottomView.transform = CGAffineTransformMakeTranslation(0, 0);
            for (FocusViewCell *cell in self.cellArray) {
                self.focusCell = cell;
                self.focusCell.containerView.transform =  CGAffineTransformMakeTranslation(54, 0);
            }
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _bottomView.transform = CGAffineTransformMakeTranslation(0, 49);
            for (FocusViewCell *cell in self.cellArray) {
                self.focusCell = cell;
                self.focusCell.containerView.transform =  CGAffineTransformMakeTranslation(0, 0);
                [self.focusCell.selectedBtn setSelected:NO];
            }
        }];
        [self.allSelectedBtn setSelected:NO];
        
    }
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark -- 懒加载
- (NSMutableArray *)cellArray{
    if (_cellArray == nil) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}

- (NSMutableArray *)FocusArr{
    if (_FocusArr == nil) {
        _FocusArr = [NSMutableArray array];
    }
    return _FocusArr;
}

@end
