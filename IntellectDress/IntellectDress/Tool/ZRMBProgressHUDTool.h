//
//  ZRMBProgressHUDTool.h
//  IntellectDress
//
//  Created by zerom on 16/10/11.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRMBProgressHUDTool : NSObject
+ (void)showDataFromView:(UIView *)view showMode:(MBProgressHUDMode)showMode labelText:(NSString *)labelText hideDelay:(NSTimeInterval)hideDelay;
@end
