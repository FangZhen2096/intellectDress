//
//  Dialog.h
//  FK
//
//  Created by 小强 on 15/12/4.
//  Copyright © 2015年 xiaoshag. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  void (^DCallback) (UIAlertView*alertView,NSInteger buttonIndex);
@interface Dialog : UIAlertView<UIAlertViewDelegate>
@property (strong)DCallback callback;
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message callback:(DCallback)callback buttons:(NSArray*)buttons;
@end
