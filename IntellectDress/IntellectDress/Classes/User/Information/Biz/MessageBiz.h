//
//  MessageBiz.h
//  clothesnews
//
//  Created by 小强 on 16/5/16.
//  Copyright © 2016年 persona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppAjax.h"
@interface MessageBiz:NSObject
-(void)userinfo:(NSString*)userid page:(NSInteger)page calback:(CallBack)callback;
-(void)unread:(NSString*)userid callback:(CallBack) callback;
-(void)read:(NSString*)id_ userid:(NSString*)userid callback:(CallBack) callback;
-(void)delinfo:(NSString*)ids userid:(NSString*)userid callback:(CallBack) callback;
@end
