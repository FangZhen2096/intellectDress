//
//  ZRTimeCompareController.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRTimeCompareController.h"


@interface ZRTimeCompareController ()<HZQDatePickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *todayBtn;
@property (weak, nonatomic) IBOutlet UIButton *yestodayBtn;
@property (weak, nonatomic) IBOutlet UIButton *currentWeekBtn;
@property (weak, nonatomic) IBOutlet UIButton *lastWeekBtn;
@property (weak, nonatomic) IBOutlet UIButton *currentMonthBtn;
@property (weak, nonatomic) IBOutlet UIButton *lastMonthBtn;
@property (weak, nonatomic) IBOutlet UIButton *lastYearBtn;
@property (weak, nonatomic) IBOutlet UIButton *currentYearBtn;
@property (weak, nonatomic) IBOutlet UIButton *compareBtn;
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;
@property (weak, nonatomic) IBOutlet UISwitch *switch3;
@property (weak, nonatomic) IBOutlet UISwitch *switch4;
@property (weak, nonatomic) IBOutlet UIButton *compareBtn2;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIView *compareView;
@property (strong,nonatomic) HZQDatePickerView *pikerView;
@property (weak, nonatomic) IBOutlet UIButton *startDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *endDateBtn;

@end

@implementation ZRTimeCompareController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setView];
    _compareView.transform = CGAffineTransformMakeTranslation(375, 0);
    //取消返回按钮文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}
- (IBAction)confirmBtnClick:(id)sender {
    if ([_endDateBtn.titleLabel.text isEqualToString:@"点击选择时间"] || [_startDateBtn.titleLabel.text isEqualToString:@"点击选择时间"]) {
        [ZRMBProgressHUDTool showDataFromView:self.view showMode:MBProgressHUDModeText labelText:@"请选择时间" hideDelay:1];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)compareBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)compareBtn2Click:(id)sender {
    if ([_endDateBtn.titleLabel.text isEqualToString:@"点击选择时间"] || [_startDateBtn.titleLabel.text isEqualToString:@"点击选择时间"]) {
        [ZRMBProgressHUDTool showDataFromView:self.view showMode:MBProgressHUDModeText labelText:@"请选择时间" hideDelay:1];
        return;
    }
    NSDictionary *timedic = @{@"start":_startDateBtn.titleLabel.text,@"end":_endDateBtn.titleLabel.text};
//    if([self.delegate respondsToSelector:@selector(VCValuePass:)]){
//        
//        [self.delegate VCValuePass:timedic];
//        
//    }
    if (self.passValueBlock) {
        self.passValueBlock(timedic);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 日历选择器
/**********************       此处为日历选择功能    *************************/
- (IBAction)startDateBtnClick:(id)sender {
    [self setupDateView:DateTypeOfStart];
    
}
- (IBAction)endDateBtnClick:(id)sender {
    [self setupDateView:DateTypeOfEnd];
    
}
- (void)setupDateView:(DateType)type {
    
    _pikerView = [HZQDatePickerView instanceDatePickerView];
    
    _pikerView.frame = CGRectMake(0, 0,MainScreenWidth, MainScreenHeight);
    
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    
    _pikerView.delegate = self;
    
    _pikerView.type = type;
    
    // 今天起之后的日期
    
    [_pikerView.datePickerView setMinimumDate:[NSDate date]];
    
    // 今天之前的日期
    
    //    [_pikerView.datePickerView setMaximumDate:[NSDate date]];
    
    [self.view addSubview:_pikerView];
    
}

- (void)getSelectDate:(NSString *)date type:(DateType)type {
    NSLog(@"%d - %@", type, date);
    
    switch (type) {
        case DateTypeOfStart:
            [_startDateBtn setTitle:[NSString stringWithFormat:@":%@", date] forState:UIControlStateNormal];
            [_startDateBtn setTitleColor:defaultColor forState:UIControlStateNormal];
            break;
            
        case DateTypeOfEnd:
            [_endDateBtn setTitle:[NSString stringWithFormat:@":%@", date] forState:UIControlStateNormal];
            [_endDateBtn setTitleColor:defaultColor forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}
/**********************       此处为日历选择功能     *************************/
#pragma mark -- 初始化时间选择界面
- (void)setView{
    [_todayBtn roundWithRadius:_todayBtn.size.width/2];
    [_yestodayBtn roundWithRadius:_yestodayBtn.size.width/2];
    [_currentWeekBtn roundWithRadius:_currentWeekBtn.size.width/2];
    [_lastWeekBtn roundWithRadius:_lastWeekBtn.size.width/2];
    [_currentMonthBtn roundWithRadius:_currentMonthBtn.size.width/2];
    [_lastMonthBtn roundWithRadius:_lastMonthBtn.size.width/2];
    [_lastYearBtn roundWithRadius:_lastYearBtn.size.width/2];
    [_currentYearBtn roundWithRadius:_currentYearBtn.size.width/2];
    [_compareBtn roundWithRadius:16];
    _todayBtn.backgroundColor = defaultColor;
    _yestodayBtn.backgroundColor = defaultColor;
    _currentWeekBtn.backgroundColor = defaultColor;
    _lastWeekBtn.backgroundColor = defaultColor;
    _currentMonthBtn.backgroundColor = defaultColor;
    _lastMonthBtn.backgroundColor = defaultColor;
    _lastYearBtn.backgroundColor = defaultColor;
    _currentYearBtn.backgroundColor = defaultColor;
    _compareBtn.backgroundColor = defaultColor;
    _switch1.onTintColor = defaultColor;
    _switch2.onTintColor = defaultColor;
    _switch3.onTintColor = defaultColor;
    _switch4.onTintColor = defaultColor;
    [_compareBtn2 roundWithRadius:10];
    [_confirmBtn roundWithRadius:10];
    _compareBtn2.backgroundColor = defaultColor;
    _confirmBtn.backgroundColor = defaultColor;
    
}
- (IBAction)switch1Click:(id)sender {
    if (_switch1.on) {
        [_switch2 setOn:NO animated:YES];
        [_switch3 setOn:NO animated:YES];
        [_switch4 setOn:NO animated:YES];
    }
}
- (IBAction)switch2Click:(id)sender {
    if (_switch2) {
        [_switch1 setOn:NO animated:YES];
        [_switch3 setOn:NO animated:YES];
        [_switch4 setOn:NO animated:YES];
    }
}
- (IBAction)switch3Click:(id)sender {
    if (_switch3) {
        [_switch1 setOn:NO animated:YES];
        [_switch2 setOn:NO animated:YES];
        [_switch4 setOn:NO animated:YES];
    }
}
- (IBAction)switch4Click:(id)sender {
    if (_switch4) {
        [_switch1 setOn:NO animated:YES];
        [_switch3 setOn:NO animated:YES];
        [_switch2 setOn:NO animated:YES];
    }
}
- (IBAction)timeCompareViewClick:(id)sender {

//    _compareView.hidden = !_compareView.hidden;
    if (_compareView.frame.origin.x > 375) {
        [UIView animateWithDuration:0.5 animations:^{
            _compareView.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _compareView.transform = CGAffineTransformMakeTranslation(375, 0);
        }];
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


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

@end
