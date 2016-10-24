//
//  SZTextView.h
//  APopDemo
//
//  Created by 小强 on 16/5/13.
//  Copyright © 2016年 geluya. All rights reserved.
//



#import <UIKit/UIKit.h>




//IB_DESIGNABLE

@interface PlaceHolderTextView : UITextView

@property (copy, nonatomic) IBInspectable NSString *placeholder;
@property (nonatomic) IBInspectable double fadeTime;
@property (copy, nonatomic) NSAttributedString *attributedPlaceholder;
@property (retain, nonatomic) UIColor *placeholderTextColor UI_APPEARANCE_SELECTOR;

@end