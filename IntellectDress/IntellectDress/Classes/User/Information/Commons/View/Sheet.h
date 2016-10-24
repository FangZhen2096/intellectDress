//
//  Sheet.h
//  FK
//
//  Created by 小强 on 15/12/5.
//  Copyright © 2015年 xiaoshag. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SCallback) (UIActionSheet*sheet,NSInteger buttonIndex);
@interface Sheet : UIActionSheet<UIActionSheetDelegate>
-(instancetype)initWithTitle:(NSString*)title callback:(SCallback)callback titles:(NSArray*)titles;
@property (strong)SCallback callback;
@end
