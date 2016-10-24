//
//  ZRTimeCompareController.h
//  IntellectDress
//
//  Created by 房 臻 on 16/9/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZRTimeCompareControllerDelegate <NSObject>

@optional

- (void)VCValuePass:(NSDictionary *)timeDic;

@end

@interface ZRTimeCompareController : UIViewController
@property(assign,nonatomic)id<ZRTimeCompareControllerDelegate> delegate;
@property(copy,nonatomic)void(^passValueBlock)(NSDictionary* dict);
@end
