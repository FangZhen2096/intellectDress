//
//  MessageBiz.m
//  clothesnews
//
//  Created by 小强 on 16/5/16.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "MessageBiz.h"
@interface MessageBiz()
@property (nonatomic)AppAjax*ajax;

@end
@implementation MessageBiz
-(instancetype)init{
    self = [super init];
    if (self) {
        _ajax = [[AppAjax alloc] init];
    }
    return  self;
}
-(void)userinfo:(NSString*)userid page:(NSInteger)page calback:(CallBack)callback{
    NSString *token = [UserBiz token];
    [_ajax dicWithUrl:@"message/userinfo" params:@{@"userid":userid,@"page":@(page),@"token":token} callback:^(BOOL isError, NSDictionary *json) {
        NSLog(@"信息中心请求成功--json:%@",json);
        callback(isError,json);
    } post:NO];
}
-(void)unread:(NSString*)userid callback:(CallBack) callback{
    [_ajax dicWithUrl:@"message/unread" params:@{@"userid":userid} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:NO];
}
-(void)read:(NSString*)id_ userid:(NSString*)userid callback:(CallBack) callback{
    NSDictionary*userInfo = [UserBiz userInfo];
    NSString*token=FORMAT(@"%@",userInfo[@"token"]);
    
    [_ajax dicWithUrl:FORMAT(@"message/read?userid=%@&token=%@",userid,token) params:@{@"userid":userid,@"id":id_} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:YES];
}
-(void)delinfo:(NSString*)ids userid:(NSString*)userid callback:(CallBack) callback{
    NSDictionary*userInfo = [UserBiz userInfo];
    NSString*token=FORMAT(@"%@",userInfo[@"token"]);
    [_ajax dicWithUrl:FORMAT(@"message/delinfo?userid=%@&token=%@",userid,token) params:@{@"userid":userid,@"ids":ids} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:YES];
}

@end
