//
//  Dialog.m
//  FK
//
//  Created by 小强 on 15/12/4.
//  Copyright © 2015年 xiaoshag. All rights reserved.
//

#import "Dialog.h"
#import <UIKit/UIKit.h>
@implementation Dialog
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message callback:(DCallback)callback buttons:(NSArray*)buttons{
    self =  [super initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    for (NSInteger i = 0; i<buttons.count; i++) {
        [self addButtonWithTitle:buttons[i]];
    }
    self.delegate = self;
    self.callback = callback;
    return  self;
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    if(self.callback){

        self.callback(alertView,buttonIndex);
    }
}
@end
