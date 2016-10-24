//
//  ZRProductCategoryController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRProductCategoryController.h"
#import "LeftViewCell.h"
#import "RightViewCell.h"
#import "ProductCategoryModel.h"
#import "ProductListModel.h"
@interface ZRProductCategoryController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (nonatomic,strong) LeftViewCell *selectedCell;
@property (strong,nonatomic) NSMutableArray *productCategoryArr;
@property (assign,nonatomic)NSInteger count;
@property (strong,nonatomic) ProductCategoryModel *productCategoryModel;
@property (strong,nonatomic) ProductListModel *productListModel;
@property (strong,nonatomic) NSMutableArray *productListArr;
@property (copy,nonatomic) NSString *classId;
@property (assign,nonatomic)NSInteger ListCount;
@end

@implementation ZRProductCategoryController

#pragma mark -- 懒加载
- (NSMutableArray *)productCategoryArr{
    if (_productCategoryArr == nil) {
        _productCategoryArr = [NSMutableArray array];
    }
    return _productCategoryArr;
}

- (NSMutableArray *)productListArr{
    if (_productListArr == nil) {
        _productListArr = [NSMutableArray array];
    }
    return _productListArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.delegate = self;
    _topView.backgroundColor = defaultColor;
    _leftTableView.backgroundColor = defaultColor;
    _classId = @"1";
    [self setProductCategory];

}

- (void)setProductCategory{
    [AnalyseAjax productCategoryWithSuccess:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        NSArray *list = results[@"list"];
        _count = list.count;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
        for (int i = 0; i<list.count; i++) {
            NSDictionary *listSub = [list objectAtIndex:i];
            _productCategoryModel = [ProductCategoryModel productCategoryWithDict:listSub];
            [arr addObject:_productCategoryModel];
        }
        _productCategoryArr = arr;
        
        [_leftTableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}

-(void)setProductList{
    [AnalyseAjax productListWithClassId:_classId Success:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        NSArray *list = results[@"list"];
        _ListCount = list.count;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
        for (int i = 0; i<list.count; i++) {
            NSDictionary *listSub = [list objectAtIndex:i];
            _productListModel = [ProductListModel productListWithDict:listSub];
            [arr addObject:_productListModel];
        }
        _productListArr = arr;

        [_rightTableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}


#pragma mark -- UITableViewDataSource数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView.tag == 2) {
        return _ListCount;
    }else{
        return _count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 2) {
        ProductListModel * productListModel = [_productListArr objectAtIndex:indexPath.row];
        RightViewCell *cell = [RightViewCell rightViewCell:tableView];
        [cell.title setText:productListModel.title];
        [cell.total setText:productListModel.total];
        return cell;
    }else{
        ProductCategoryModel *productCategory = [_productCategoryArr objectAtIndex:indexPath.row];
        LeftViewCell *cell = [LeftViewCell leftViewCell:tableView];
        [cell.title setText:productCategory.title];
        [cell.total setText:productCategory.total];
        return cell;
    }
    
}

-  (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        self.selectedCell.isSelected = NO;
        LeftViewCell *leftCell = [tableView cellForRowAtIndexPath:indexPath];
        leftCell.isSelected = YES;
        self.selectedCell = leftCell;
        ProductCategoryModel *model = [_productCategoryArr objectAtIndex:indexPath.row];
        _classId = model.ID;
        [self setProductList];
    }else{
        NSString *wareid = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getWearid" object:wareid];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
