//
//  ZRMemoController.h
//  IntellectDress
//
//  Created by 房 臻 on 16/9/23.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZRMemoControllerDelegate <NSObject>

-(void)passTrendValues:(NSString *)bid;

@end

@interface ZRMemoController : UIViewController
@property (weak,nonatomic) id <ZRMemoControllerDelegate> delegate;
@end
