//
//  ZRUserInfoViewController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/5.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRUserInfoViewController.h"

@interface ZRUserInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
/**
 *  保存按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *saveUserInfoBtn;
/**
 *  头像btn
 */
@property (weak, nonatomic) IBOutlet UIButton *avatarBtn;


@property (weak, nonatomic) IBOutlet UIView *avatarContainerView;

/**
 *  手机号label
 */
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
/**
 *  昵称textField
 */
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;

/**
 *  男士Btn
 */
@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
/**
 *  女士Btn
 */
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;
/**
 *  邮箱textField
 */
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (nonatomic)UserBiz*biz;
@property (nonatomic)NSDictionary*data;
@property (nonatomic)Photo *photo;
@end

@implementation ZRUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_avatarBtn roundWithRadius:_avatarBtn.width/2];
    self.navigationController.navigationBar.hidden = NO;
    self.saveUserInfoBtn.layer.cornerRadius = CornerRadius;
    self.saveUserInfoBtn.layer.masksToBounds = YES;
    _biz =[[UserBiz alloc] init];
    [_biz base:[UserBiz userId] callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        _data = json[@"results"];
        [self fill];
    }];
    [self initView];
    //取消tableView默认往下偏移量
    self.automaticallyAdjustsScrollViewInsets =  NO;
    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    
}

- (void)initView{
    UINavigationBar* navigationBar = [UINavigationBar appearance];
    navigationBar.barTintColor = GlobalTintColor;
    navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem* barItem=    [UIBarButtonItem appearance];
    UIImage *backButtonImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [barItem setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    [navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    NSDictionary *dict = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"MicrosoftYaHei" size:18.0f]};
    [navigationBar setTitleTextAttributes:dict];
    self.title = @"个人信息";
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 3;
    }else
    {
        return 2;
    }
}


- (IBAction)saveBtnClick:(id)sender {
    
    NSString*sex = @"男";
    if (_femaleBtn.selected) {
        sex = @"女";
    }
    [_biz editInfo:_emailTextField.text nickname:_nickNameTextField.text sex:sex callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            return ;
        }
        ALERT(@"修改成功");
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

-(void)fill{
    _nickNameTextField.text = FORMAT(@"%@",_data[@"nickname"]);
    _phoneNumberLabel.text = FORMAT(@"%@",_data[@"tel"]);
    _emailTextField.text = FORMAT(@"%@",_data[@"email"]);
    [_avatarBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:FORMAT(@"%@",_data[@"img"])] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeholder"]];
    if ([_data[@"sex"] integerValue]==0) {
        _femaleBtn.selected = YES;
    }else{
        _maleBtn.selected = YES;
    }
    
}
//性别按钮点击
- (IBAction)sexBtnClick:(UIButton *)sender {
    _maleBtn.selected =_femaleBtn.selected = NO;
    sender.selected = YES;
    
}
//头像按钮点击
- (IBAction)avatarBtnCLick:(id)sender {
    __weak ZRUserInfoViewController *self_ = self;
    _photo = [[Photo alloc] initWithOwner:self_];
    [_photo photoWithCallback:^(UIImage *resultImage) {
        _photo = nil;
        if (resultImage==nil) {
            return ;
        }
        [_biz upavatar:resultImage userid:[UserBiz userId] callback:^(BOOL isError, NSDictionary *json) {
            if (isError) {
                return ;
            }
            NSDictionary*results = json[@"results"];
            [_avatarBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:FORMAT(@"%@",results[@"img"])]  forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }];
    }];

}


-(void)dealloc{
    DLog(@"");
}








@end
