//
//  ZRProductCategoryController.h
//  IntellectDress
//
//  Created by 房 臻 on 16/9/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRProductCategoryController : UIViewController
@property(copy,nonatomic)void(^passValueBlock)(NSString* wareid);
@end
