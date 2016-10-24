//
//  ZRProductInfoController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRProductInfoController.h"
#import "ProductInfoCell.h"
#import "AnalyseAjax.h"
#import "ProductInfoModel.h"
#import "ZRProductCategoryController.h"
#define buttonCount 4
@interface ZRProductInfoController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topNavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *fourthTableView;
@property (weak, nonatomic) IBOutlet UITableView *thirdTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;
@property (weak, nonatomic) IBOutlet UITableView *FirstTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (nonatomic,strong) UIButton *lastButton;
@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (copy,nonatomic) NSString *type;
@property (copy,nonatomic) NSString *wearid;
@property (strong,nonatomic) NSMutableArray *ProductArray;
@property (strong,nonatomic) ProductInfoModel *productInfo;

@property (copy,nonatomic) NSString *imgURL;
@property (copy,nonatomic) NSString *productTitle;
@property (copy,nonatomic) NSString *number;
@property (copy,nonatomic) NSString *display;
@property (copy,nonatomic) NSString *piece;
@property (copy,nonatomic) NSString *trying;
@property (copy,nonatomic) NSString *num;
@property (copy,nonatomic) NSString *fitt;
@property (copy,nonatomic) NSString *ber;
@property (copy,nonatomic) NSString *price;
@property (assign,nonatomic)NSInteger count;

@end

@implementation ZRProductInfoController

#pragma mark --  懒加载
-(NSString *)type{
    if (_type == nil) {
        _type = [[NSString alloc] init];
        _type = @"1";
    }
    return _type;
}
-(NSString *)wearid{
    if (_wearid == nil) {
        _wearid = [[NSString alloc] init];
        _wearid = @"1";
    }
    return _wearid;
}
- (NSMutableArray *)ProductArray{
    if (_ProductArray == nil) {
        _ProductArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _ProductArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _button1.selected = YES;
    _lastButton = _button1;
    _scrollView.delegate = self;
    _FirstTableView.dataSource = self;
    _FirstTableView.delegate = self;
    _secondTableView.dataSource = self;
    _secondTableView.delegate = self;
    _thirdTableView.dataSource = self;
    _thirdTableView.delegate = self;
    _fourthTableView.dataSource = self;
    _fourthTableView.delegate = self;
    _searchView.backgroundColor = defaultColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWearid:) name:@"getWearid" object:nil];
    _type = @"1";
    [self setProductInfo];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.tabBar.hidden = YES;
    
    
}

- (void)getWearid:(NSNotification *)notification{
     _wearid = notification.object ;
}

- (void)setLine{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _button1.frame.size.width+10, 30)];
    line.backgroundColor = defaultColor;
    [_topNavigationBar addSubview:line];
}

- (void)setProductInfo{
    [AnalyseAjax ProductInfoWithType:_type wearid:_wearid Success:^(NSDictionary *dict) {
        NSDictionary *results = dict[@"results"];
        NSArray *list = results[@"list"];
        _count = list.count;
        NSMutableArray *productArray  = [NSMutableArray arrayWithCapacity:_count];
        for (int i = 0; i < _count; i++) {
            NSDictionary *listSub = [list objectAtIndex:i];
            _productInfo = [ProductInfoModel productInfoWithDict:listSub];
            [productArray addObject:_productInfo];
            _ProductArray = productArray;
        }
        if ([_type isEqualToString:@"1"]) {
            [self.FirstTableView reloadData];
        }else if ([_type isEqualToString:@"2"]){
            [self.secondTableView reloadData];
        }else if ([_type isEqualToString:@"3"]){
             [self.thirdTableView reloadData];
        }else{
            [self.fourthTableView reloadData];
        }
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark -- UITableViewDataSource数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductInfoCell *cell = [ProductInfoCell productInfoCell:tableView];
        _productInfo = [_ProductArray objectAtIndex:indexPath.row];
        [cell.img sd_setImageWithURL:[NSURL URLWithString:_productInfo.img]];
        [cell.title setText:_productInfo.title];
        [cell.number setText:_productInfo.number];
        [cell.display setText:_productInfo.display];
        [cell.piece setText:_productInfo.piece];
        [cell.trying setText:_productInfo.trying];
        [cell.num setText:_productInfo.num];
        [cell.fitt setText:_productInfo.fitt];
        [cell.ber setText:_productInfo.ber];
        [cell.price setText:_productInfo.price];
        if ([_productInfo.love isEqualToString:@"true"]) {
            cell.likeBtn.selected = YES;
        }else{
            cell.likeBtn.selected = NO;
        }

    return cell;
}



#pragma mark -- 按钮点击触发
- (IBAction)button1Click:(id)sender {
    if (_button1.selected) {
        return;
    }
    _button1.selected = !_button1.selected;
    _type = @"1";
    [self setProductInfo];
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = CGPointMake(0, 0);
    }];
    
}

- (IBAction)button2Click:(id)sender {
    if (_button2.selected) {
        return;
    }
    _button2.selected = !_button2.selected;
    _type = @"2";
    [self setProductInfo];
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = CGPointMake(SCREENWIDTH, 0);
    }];
    
}

- (IBAction)button3Click:(id)sender {
    if (_button3.selected) {
        return;
    }
    _button3.selected = !_button3.selected;
    _type = @"3";
    [self setProductInfo];
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = CGPointMake(SCREENWIDTH*2, 0);
    }];
    
}

- (IBAction)button4Click:(id)sender {
    if (_button4.selected) {
        return;
    }
    _button4.selected = !_button4.selected;
    _type = @"4";
    [self setProductInfo];
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = CGPointMake(SCREENWIDTH*3, 0);
    }];
    
}
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma  mark --  UIScrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_scrollView.contentOffset.x >= SCREENWIDTH*0.5 && _scrollView.contentOffset.x < SCREENWIDTH *1.5) {
        _lastButton.selected = NO;
        _button2.selected = YES;
        _lastButton = _button2;
        
    }else if (_scrollView.contentOffset.x >=SCREENWIDTH *1.5 && _scrollView.contentOffset.x <SCREENWIDTH *2.5){
        _lastButton.selected = NO;
        _lastButton = _button3;
        _button3.selected = YES;
    }else if (_scrollView.contentOffset.x >=SCREENWIDTH *2.5 && _scrollView.contentOffset.x <SCREENWIDTH *3.5){
        _lastButton.selected = NO;
        _lastButton = _button4;
        _button4.selected = YES;

    }else{
        _lastButton.selected = NO;
        _lastButton = _button1;
        _button1.selected = YES;

    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_scrollView.contentOffset.x == SCREENWIDTH) {
        _type = @"2";
        [self setProductInfo];
    }else if (_scrollView.contentOffset.x == 2*SCREENWIDTH){
        _type = @"3";
        [self setProductInfo];
    }else if (_scrollView.contentOffset.x == 3*SCREENWIDTH){
        _type = @"4";
        [self setProductInfo];
    }else{
        _type = @"1";
        [self setProductInfo];
    }
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

//取消返回按钮的文字
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
