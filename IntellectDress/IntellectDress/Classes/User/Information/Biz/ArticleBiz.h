//
//  ArticleBiz.h
//  clothesnews
//
//  Created by 小强 on 16/5/16.
//  Copyright © 2016年 persona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleBiz : NSObject
-(void)favorites:(NSString*)userid page:(NSInteger) page callback:(CallBack) callback;
-(void)listinfo:(NSString*)classid page:(NSInteger)page userid:(NSString*)userid callback:(CallBack) callback;
-(void)search:(NSString*)search page:(NSInteger)page callback:(CallBack) callback;
-(void)favorite:(NSString*)aid userid:(NSString*)userid callback:(CallBack) callback;
-(void)delfavorite:(NSString*)ids userid:(NSString*)userid callback:(CallBack) callback;
-(void)getfavorite:(NSString*)aid userid:(NSString*)userid callback:(CallBack) callback;
-(void)type:(CallBack) callback;
-(void)hot:(NSInteger) page callback:(CallBack) callback;
-(void)pic:(NSString*)tid callback:(CallBack) callback;
@end
