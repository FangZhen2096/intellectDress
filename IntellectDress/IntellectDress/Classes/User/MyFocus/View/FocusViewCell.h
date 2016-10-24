//
//  FocusViewCell.h
//  IntellectDress
//
//  Created by zerom on 16/9/29.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusViewCell : UITableViewCell
+(instancetype)focusCell:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *piece;
@property (weak, nonatomic) IBOutlet UILabel *trying;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *fitt;
@property (weak, nonatomic) IBOutlet UILabel *ber;
@property (weak, nonatomic) IBOutlet UILabel *price;


@end
