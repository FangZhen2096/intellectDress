//
//  UIColor+colorChange.h
//  IntellectDress
//
//  Created by zerom on 16/10/18.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (colorChange)
// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;
@end
