//
//  AddUserManagerController.m
//  IntellectDress
//
//  Created by zerom on 16/10/9.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "AddUserManagerController.h"
#import "StoreModel.h"
#import "ShopChoseCell.h"
@interface AddUserManagerController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *careerView;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *bossBtn;
@property (weak, nonatomic) IBOutlet UIButton *workerBtn;
@property (weak, nonatomic) IBOutlet UIButton *careerBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (assign,nonatomic)NSInteger count;
@property (strong,nonatomic) NSMutableArray *storeArr;
@property (strong,nonatomic) NSMutableArray *selectedArr;
@property (assign,nonatomic)NSInteger selectedCount;

@property (copy,nonatomic) NSString *ids;
@property (copy,nonatomic) NSString *typeid;
//@property (copy,nonatomic) NSString *userTel;

/**
 遮罩按钮
 */
@property (strong,nonatomic) UIButton *shadeBtn;
@end

@implementation AddUserManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    _navigationView.backgroundColor = defaultColor;
    [_saveBtn roundWithRadius:6];
    _saveBtn.backgroundColor = defaultColor;
    [_saveBtn setTitleColor:RGB(186, 251, 225) forState:UIControlStateNormal];
    _careerView.transform = CGAffineTransformMakeTranslation(375, 0);
    [_careerView roundWithRadius:10];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    [self setStoreList];
}


#pragma mark --请求数据

- (void)addUser{
    [UserManagerAjax AddUserWithIds:_ids typeid:_typeid userTel:_phoneTextField.text Success:^(NSDictionary *dict) {
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSError *error) {
        
    }];
}

- (void)setStoreList{
    [HomeAjax storeManagerWithSuccess:^(NSDictionary *json) {
        NSArray *results = json[@"results"];
        _count = results.count;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_count];
        for (int i = 0; i < _count; i++) {
            NSDictionary *dic = [results objectAtIndex:i];
            StoreModel *model = [StoreModel storeModelWithDict:dic];
            [arr addObject:model];
        }
        _storeArr = arr;
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark -- UITableViewDataSource数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopChoseCell *cell = [ShopChoseCell ShopChoseCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    StoreModel *model = [_storeArr objectAtIndex:indexPath.row];
    cell.shopName.text = model.title;
    cell.switchBtn.tag = indexPath.row;
    [cell.switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_selectedArr addObject:cell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
#pragma mark -- 按钮触发事件
//选择职业按钮点击
- (IBAction)functionChoseBtnClick:(id)sender {
    //当键盘弹出时 点击职业按钮后 收回键盘
    [self.view endEditing:YES];
    if (_careerView.frame.origin.x > 375) {
        [UIView animateWithDuration:0.5 animations:^{
            _careerView.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }
    //添加遮罩按钮
    [self addShadeBtn];
    //3.让图片调整位置到最前面
    [self.view bringSubviewToFront:_careerView];
}
- (IBAction)bossBtnClick:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        //1.让阴影变透明
        self.shadeBtn.alpha=0;
        _careerView.transform = CGAffineTransformMakeTranslation(375, 0);
    } completion:^(BOOL finished) {
        //3.移除阴影
        self.shadeBtn=nil;
        [_careerBtn setTitle:@"店长" forState:UIControlStateNormal];
        [_careerBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _typeid = @"2";
    }];
    
}
- (IBAction)workerBtnClick:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        //1.让阴影变透明
        self.shadeBtn.alpha=0;
        _careerView.transform = CGAffineTransformMakeTranslation(375, 0);
    } completion:^(BOOL finished) {
        
        //3.移除阴影
        self.shadeBtn=nil;
        [_careerBtn setTitle:@"分析员" forState:UIControlStateNormal];
        [_careerBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _typeid = @"3";
    }];
}

- (void)switchBtnClick:(UISwitch *)btn{
    if (btn.on == YES) {
        NSString *ID = [NSString stringWithFormat:@"%ld",btn.tag+1];
        if (_ids == nil) {
            _ids = [NSString stringWithFormat:@"%@",ID];
        }else{
            _ids = [NSString stringWithFormat:@"%@,%@",_ids,ID];
        }
    }else{
        NSString *ID = [NSString stringWithFormat:@"%ld",btn.tag+1];
        NSString *id1 = [NSString stringWithFormat:@",%@",ID];
        NSString *id2 = [NSString stringWithFormat:@"%@,",ID];
        if ([_ids rangeOfString:id1].location != NSNotFound) {
            _ids = [_ids stringByReplacingOccurrencesOfString:id1 withString:@""];
        }else if([_ids rangeOfString:id1].location == NSNotFound && [_ids rangeOfString:id2].location != NSNotFound){
            _ids = [_ids stringByReplacingOccurrencesOfString:id2 withString:@""];
        }else {
            _ids = [_ids stringByReplacingOccurrencesOfString:ID withString:@""];
            if ([_ids isEqualToString:@""]) {
                _ids = nil;
            }
        }
    }
    
    
    NSLog(@"ids ------  %@",_ids);
}
//保存按钮点击
- (IBAction)SaveBtnClick:(id)sender {
    [self addUser];
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --  遮罩按钮点击事件
- (void)changeViewFrame{

    if (_careerView.frame.origin.x < 375) {
        [UIView animateWithDuration:0.5 animations:^{
            //1.让阴影变透明
            self.shadeBtn.alpha=0;
            //2.让职业View恢复到原始的frame
            _careerView.transform = CGAffineTransformMakeTranslation(375, 0);
        } completion:^(BOOL finished) {
            //3.移除阴影
            self.shadeBtn=nil;
        }];
    }
}

#pragma mark -- 设置遮罩按钮
- (void)addShadeBtn{
    //创建遮罩按钮
    UIButton *shade = [[UIButton alloc] init];
    self.shadeBtn = shade;
    shade.frame = self.view.bounds;
    //设置阴影的颜色
    shade.backgroundColor=[UIColor blackColor];
    //设置透明度
    shade.alpha=0.1;//目的就是为了生成动画效果
    //为阴影 添加点击事件
    [shade addTarget:self action:@selector(changeViewFrame) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:shade];

}

#pragma mark -- 点击空白处 收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark -- 懒加载
- (NSMutableArray *)storeArr{
    if (_storeArr == nil) {
        _storeArr = [NSMutableArray array];
    }
    return _storeArr;
}

- (NSMutableArray *)selectedArr{
    if (_selectedArr == nil) {
        _selectedArr = [NSMutableArray array];
    }
    return _selectedArr;
}
- (NSString *)ids{
    if (_ids == nil) {
        _ids = [NSString string];
    }
    return _ids;
}

@end
