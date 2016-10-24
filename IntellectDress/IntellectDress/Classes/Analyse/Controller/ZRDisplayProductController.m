//
//  ZRDisplayProductController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/22.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRDisplayProductController.h"
#import "DisplayCell.h"
#import "ProductAnalyseFittingModel.h"
@interface ZRDisplayProductController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) ProductAnalyseFittingModel *displayModel;
@property (strong,nonatomic) NSMutableArray *displayArr;
@property (assign,nonatomic)NSInteger count;
@property (weak, nonatomic) IBOutlet UITableView *displayTableView;

@end

@implementation ZRDisplayProductController


- (void)viewDidLoad {
    [super viewDidLoad];
    _displayTableView.delegate = self;
    _displayTableView.dataSource = self;
    [self setDisplayMore];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
#pragma mark -- 请求数据
- (void)setDisplayMore{
    [AnalyseAjax productDisplayMoreWithSuccess:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        NSArray *list = results[@"list"];
        _count = list.count;
        NSMutableArray *arr =[NSMutableArray arrayWithCapacity:list.count];
        for (int i=0; i<_count; i++) {
            NSDictionary *listSub = [list objectAtIndex:i];
            _displayModel = [ProductAnalyseFittingModel productAnalyseFittingModelWithDict:listSub];
            [arr addObject:_displayModel];
        }
        _displayArr = arr;
        [_displayTableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DisplayCell *cell = [DisplayCell displayCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _displayModel = [_displayArr objectAtIndex:indexPath.row];
    [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:_displayModel.img]];
    [cell.shopNameLabel setText:_displayModel.title];
    [cell.shopNumLabel setText:_displayModel.number];
    [cell.shopCountLabel setText:_displayModel.ber];
    [cell.shopPriceLabel setText:_displayModel.price];
    if ([_displayModel.love isEqualToString:@"true"]) {
        cell.likeBtn.selected = YES;
    }else{
        cell.likeBtn.selected = NO;
    }
    return cell;
}

#pragma mark --UITableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard*board = [UIStoryboard storyboardWithName:@"AnalyseViewController" bundle:[NSBundle mainBundle] ];
    UIViewController*controller = [board instantiateViewControllerWithIdentifier:@"ProductDetailsController"];
    NSString *gid = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"productDidClick" object:gid];
    [self.navigationController pushViewController:controller animated:YES];

}
#pragma mark -- 按钮点击触发事件
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

//取消返回按钮的文字
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
}

#pragma mark -- 懒加载
- (NSMutableArray *)displayArr{
    if (_displayArr == nil) {
        _displayArr = [NSMutableArray array];
    }
    return _displayArr;
}

@end
