//
//  ShopDetailsCell.h
//  IntellectDress
//
//  Created by zerom on 16/10/20.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *pencilImage;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
+ (instancetype)ShopDetailsCell:(UITableView *)tableView;
@end
