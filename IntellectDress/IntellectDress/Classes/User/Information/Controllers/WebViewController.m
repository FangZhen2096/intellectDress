//
//  WebViewController.m
//  clothesnews
//
//  Created by 小强 on 16/5/18.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (nonatomic)UIWebView*webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:_navTitle];
    _webView = [[UIWebView alloc] init];
    _webView.scrollView.bounces = NO;
//    _webView.opaque = NO;
//    _webView.backgroundColor = [UIColor clearColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.view.frame= CGRectMake(0, 0, 375, 667);
//    [_webView sizeToFit];
    [self.view addSubview:_webView];
//    [self.webView setScalesPageToFit:YES];
    NSLog(@"self.view.frame-----%@",NSStringFromCGRect( self.view.frame) );
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if (_url) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:FORMAT(@"%@",_url)]]];
    }else{
        [_webView loadHTMLString:_htmlStr baseURL:nil];
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"webView.frame-----%@",NSStringFromCGRect(_webView.frame));
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD show];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [SVProgressHUD dismiss];}



@end
