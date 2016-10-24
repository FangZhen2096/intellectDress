//
//  ZRMBProgressHUDTool.m
//  IntellectDress
//
//  Created by zerom on 16/10/11.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRMBProgressHUDTool.h"

@implementation ZRMBProgressHUDTool
+ (void)showDataFromView:(UIView *)view showMode:(MBProgressHUDMode)showMode labelText:(NSString *)labelText hideDelay:(NSTimeInterval)hideDelay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = showMode;
    hud.labelText = labelText;
    hud.margin = 10.f;
    hud.yOffset = 0.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:hideDelay];
}
@end
