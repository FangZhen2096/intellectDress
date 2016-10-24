//
//  Sheet.m
//  FK
//
//  Created by 小强 on 15/12/5.
//  Copyright © 2015年 xiaoshag. All rights reserved.
//

#import "Sheet.h"
@implementation Sheet
-(instancetype)initWithTitle:(NSString*)title callback:(SCallback)callback titles:(NSArray*)titles{
    self = [super initWithTitle:title delegate:self
              cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for (NSInteger i = 0; i<titles.count; i++) {
        [self addButtonWithTitle:titles[i]];
    }
    [self addButtonWithTitle:@"取消"];
    self.destructiveButtonIndex = self.numberOfButtons-1;
    self.delegate = self;
    self.callback = callback;
    return  self;
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 8_3){
    if(self.callback){
        if(buttonIndex!=self.numberOfButtons-1){
        self.callback(actionSheet,buttonIndex);
        }
    }
}
@end
