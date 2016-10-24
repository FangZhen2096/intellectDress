//
//  AppAjax.h
//  clothesnews
//
//  Created by 小强 on 16/5/16.
//  Copyright © 2016年 persona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppAjax : NSObject
-(void)dicWithUrl:(NSString*)url params:(NSDictionary *)params callback:(void (^)(BOOL isError, NSDictionary *json))callback post:(BOOL)isPost;
-(void)uploadImages:(NSString *)action images:(NSArray *)images params:(NSDictionary *)params callback:(CallBack) callback;
@end
