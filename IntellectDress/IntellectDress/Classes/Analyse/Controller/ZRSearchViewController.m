//
//  ZRSearchViewController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRSearchViewController.h"
#import "ProductSearchResultCell.h"
#import "SearchModel.h"
@interface ZRSearchViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UILabel *searchResultNumber;
@property (strong,nonatomic) SearchModel *searchModel;
@property (strong,nonatomic) NSMutableArray *searchArr;
@property (assign,nonatomic)NSInteger count;
@end

@implementation ZRSearchViewController

#pragma mark -- 懒加载
- (NSMutableArray *)searchArr{
    if (_searchArr == nil) {
        _searchArr = [NSMutableArray array];
    }
    return _searchArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _historyTableView.dataSource =self;
    _historyTableView.delegate = self;
    _searchView.backgroundColor = defaultColor;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_searchTextField resignFirstResponder];
}

- (void)setSearchView{
    [AnalyseAjax searchProductWithSearch:_searchTextField.text Success:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        NSArray *list = results[@"list"];
        _count = list.count;
        NSString *num = results[@"sum"];
        [_searchResultNumber setText:[NSString stringWithFormat:@"智能经营宝为你搜索到%@个结果",num]];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
        for (int i =0; i < list.count; i++) {
            NSDictionary *listSub = [list objectAtIndex:i];
            _searchModel = [SearchModel searchWithDict:listSub];
            [arr addObject:_searchModel];
        }
        _searchArr = arr;
        [_historyTableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}
//点击屏幕收回键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_historyTableView endEditing:YES];
}
#pragma mark -- UITableViewDataSource数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductSearchResultCell *cell = [ProductSearchResultCell ProductSearchResultCellCell:tableView];
    SearchModel *model = [_searchArr objectAtIndex:indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    [cell.title setText:model.title];
    [cell.number setText:model.number];
    [cell.price setText:model.price];

    return cell;
}

#pragma mark -- UITableViewDelegate代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"AnalyseViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"ProductDetailsController"];
    NSString *gid = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"productDidClick" object:gid];
    [self.navigationController pushViewController:controller animated:YES];

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
#pragma mark --  按钮点击触发
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)searchBtnClick:(id)sender {
    [self setSearchView];
}

@end
