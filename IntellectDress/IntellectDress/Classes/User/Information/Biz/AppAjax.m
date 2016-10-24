//
//  AppAjax.m
//  clothesnews
//
//  Created by 小强 on 16/5/16.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "AppAjax.h"
#import "Ajax.h"
@interface AppAjax()
@property (nonatomic)Ajax*ajax;
@end
@implementation AppAjax

-(instancetype)init{
    self = [super init];
    if (self) {
        _ajax = [[Ajax alloc] init];
    }
    return  self;
}
-(void)dicWithUrl:(NSString*)url params:(NSDictionary *)params callback:(void (^)(BOOL isError, NSDictionary *json))callback post:(BOOL)isPost{
    [SVProgressHUD show];
    NSMutableDictionary*mutaparam = [params mutableCopy];
    if ([UserBiz logined]) {
        NSDictionary*userInfo = [UserBiz userInfo];
        mutaparam[@"token"] =FORMAT(@"%@",userInfo[@"token"]);
    }
    [_ajax dicWithUrl:FORMAT(@"%@%@",APP_URL_BASE,url) params:mutaparam callback:^(BOOL isError, NSDictionary *json) {
        if (isError) {
            [SVProgressHUD dismiss];
            callback(YES,nil);
            return ;
        }
        if ([json[@"status"] boolValue]) {
            [SVProgressHUD dismiss];
            callback(NO,json);
        }else{
            [SVProgressHUD showInfoWithStatus:FORMAT(@"%@",json[@"info"])];
            callback(!isError,json);
        }
        
    } post:isPost];
}
-(void)uploadImages:(NSString *)action images:(NSArray *)images params:(NSDictionary *)params callback:(CallBack) callback{
    [_ajax uploadImages:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
        
    } url:FORMAT(@"%@%@",APP_URL_BASE,action) images:images params:params];
}
@end
