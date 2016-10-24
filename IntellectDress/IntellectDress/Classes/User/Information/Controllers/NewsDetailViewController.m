//
//  NewsDetailViewController.m
//  clothesnews
//
//  Created by 小强 on 16/5/18.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "MJRefresh.h"
#import "JSDropmenuView.h"
#import "ArticleBiz.h"
#import "MBProgressHUD.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface NewsDetailViewController()<JSDropmenuViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic)CGFloat totalHeight;
@property (nonatomic)NSMutableArray*menusArray;
@property (nonatomic)ArticleBiz*biz;
@end
@implementation NewsDetailViewController


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.webView.scrollView setContentInset:UIEdgeInsetsZero];
}

-(void)viewDidLoad{
    [super viewDidLoad ];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tableView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
    _biz = [[ArticleBiz alloc] init];
    _totalHeight = SCREENHEIGHT;
    _menusArray = [[NSMutableArray alloc] init];
    [_menusArray addObject:@{@"imageName":@"ico_list_memo_star_off",@"title":@"收藏文章"}];
    [_menusArray addObject:@{@"imageName":@"ico_share",@"title":@"分享文章"}];
    NSURLRequest*request= [NSURLRequest requestWithURL:[NSURL URLWithString:FORMAT(@"%@",_data[@"url"])]];
    [ _webView loadRequest:request];
    _webView.scrollView.bounces = NO;
    _webView.scrollView.scrollEnabled = NO;
    [_webView sizeToFit];
    __weak NewsDetailViewController*self_ = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSURLRequest*request= [NSURLRequest requestWithURL:[NSURL URLWithString:FORMAT(@"%@",_data[@"url"])]];
        [ self_.webView loadRequest:request];
    }];
    if ([UserBiz logined]) {
        [_biz getfavorite:FORMAT(@"%@",_data[@"id"]) userid:[UserBiz userId] callback:^(BOOL isError, NSDictionary *json) {
            if (isError) {
                return ;
            }
            NSDictionary*results = json[@"results"];
            if ([results[@"flag"] boolValue]) {
                NSMutableDictionary*item0 = [_menusArray[0] mutableCopy];
                item0[@"imageName"] = @"ico_list_memo_star_on";
                [_menusArray replaceObjectAtIndex:0 withObject:item0];
            }else{
                NSMutableDictionary*item0 = [_menusArray[0] mutableCopy];;
                item0[@"imageName"] = @"ico_list_memo_star_off";
                [_menusArray replaceObjectAtIndex:0 withObject:item0];
                
            }
        }];
    }
    
}
- (void)dropmenuView:(JSDropmenuView*)dropmenuView didSelectedRow:(NSInteger)index{
    if (index==0) {
        [_biz favorite:FORMAT(@"%@",_data[@"id"]) userid:[UserBiz userId] callback:^(BOOL isError, NSDictionary *json) {
            if (isError) {
                return ;
            }
            NSDictionary*results = json[@"results"];
            if ([results[@"flag"] boolValue]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                hud.labelText = @"收藏成功";
                hud.mode = MBProgressHUDModeText;
                // 隐藏时候从父控件中移除
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1.3];
                
                NSMutableDictionary*item0 = [_menusArray[0] mutableCopy];
                item0[@"imageName"] = @"ico_list_memo_star_on";
                [_menusArray replaceObjectAtIndex:0 withObject:item0];
            }else{
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow  animated:YES];
                hud.labelText = @"取消收藏";
                hud.mode = MBProgressHUDModeText;
                // 隐藏时候从父控件中移除
                hud.removeFromSuperViewOnHide = YES;
                
                [hud hide:YES afterDelay:1.3];
                
                NSMutableDictionary*item0 = [_menusArray[0] mutableCopy];
                item0[@"imageName"] = @"ico_list_memo_star_off";
                [_menusArray replaceObjectAtIndex:0 withObject:item0];
            }
        }];
    }
    if (index==1) {
        //share
        [self share];
    }
}
-(void)share{
    //    //1、创建分享参数
    NSArray* imageArray = @[FORMAT(@"%@",_data[@"img"])];
    ////    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:FORMAT(@"%@",_data[@"info"])
                                         images:imageArray
                                            url:[NSURL URLWithString:FORMAT(@"%@",_data[@"url"])]
                                          title:FORMAT(@"%@",_data[@"title"])
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               [SVProgressHUD showErrorWithStatus:@"分享失败"];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
    }
}

/**
 *  下拉菜单数据源
 *
 *  @return
 */
- (NSArray*)dropmenuDataSource{
    return _menusArray;
}
-(IBAction)menuClick:(id)sender{
    JSDropmenuView *dropmenuView = [[JSDropmenuView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, 64-12, 140, 44*2+12)];
    dropmenuView.delegate = self;
    [dropmenuView showViewInView:self.navigationController.view];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _totalHeight;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (IBAction)backBtnClick:(id)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [SVProgressHUD show];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    _totalHeight = [clientheight_str floatValue]+40;
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    [SVProgressHUD dismiss];

    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [self.tableView.mj_header endRefreshing];
    [SVProgressHUD show];
}

@end
