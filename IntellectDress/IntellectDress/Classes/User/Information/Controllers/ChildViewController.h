//
//  ChildViewController.h
//  clothesnews
//
//  Created by 小强 on 16/5/16.
//  Copyright © 2016年 persona. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildViewController : UIViewController
@property (nonatomic)NSString*typeId;
-(void)reloadData;
@property (nonatomic)BOOL loaded;;
@end
