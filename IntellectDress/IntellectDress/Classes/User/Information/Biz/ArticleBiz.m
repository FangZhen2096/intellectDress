//
//  ArticleBiz.m
//  clothesnews
//
//  Created by 小强 on 16/5/16.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "ArticleBiz.h"
#import "AppAjax.h"
@interface ArticleBiz()
@property (nonatomic)AppAjax*ajax;
@end
@implementation ArticleBiz
-(instancetype)init{
    self = [super init];
    if (self) {
        _ajax = [[AppAjax alloc] init];
    }
    return  self;
}
-(void)favorites:(NSString*)userid page:(NSInteger) page callback:(CallBack) callback{
    [_ajax dicWithUrl:@"article/favorites" params:@{@"userid":userid,@"page":@(page)} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:NO];
}
-(void)listinfo:(NSString*)classid page:(NSInteger)page userid:(NSString*)userid callback:(CallBack) callback{
    [_ajax dicWithUrl:@"article/listinfo" params:@{@"userid":userid,@"page":@(page),@"classid":classid} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:NO];
}
-(void)search:(NSString*)search page:(NSInteger)page callback:(CallBack) callback{
    [_ajax dicWithUrl:@"article/search" params:@{@"search":search,@"page":@(page)} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:NO];
}
-(void)favorite:(NSString*)aid userid:(NSString*)userid callback:(CallBack) callback{
    [_ajax dicWithUrl:@"article/favorite" params:@{@"aid":aid,@"userid":userid} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:NO];
}
-(void)delfavorite:(NSString*)ids userid:(NSString*)userid callback:(CallBack) callback{
    NSDictionary*userInfo = [UserBiz userInfo];
    NSString*token=FORMAT(@"%@",userInfo[@"token"]);
    [_ajax dicWithUrl:FORMAT(@"article/delfavorite?token=%@&userid=%@",token,userid) params:@{@"ids":ids,@"userid":userid} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:YES];
}

-(void)getfavorite:(NSString*)aid userid:(NSString*)userid callback:(CallBack) callback{
    [_ajax dicWithUrl:@"article/getfavorite" params:@{@"aid":aid,@"userid":userid} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:NO];
}
-(void)type:(CallBack) callback{
    [_ajax dicWithUrl:@"article/type" params:@{} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:NO];
}
-(void)hot:(NSInteger) page callback:(CallBack) callback{
    [_ajax dicWithUrl:@"article/hot" params:@{@"page":@(page)} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:NO];
}
-(void)pic:(NSString*)tid callback:(CallBack) callback{
    [_ajax dicWithUrl:@"picture/pic" params:@{@"tid":@"1",@"classid":tid} callback:^(BOOL isError, NSDictionary *json) {
        callback(isError,json);
    } post:NO];
}
@end
