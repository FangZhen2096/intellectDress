//
//  MaxViewCell.h
//  IntellectDress
//
//  Created by zerom on 16/10/13.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaxViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *joinMaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *passMaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *joinmaxTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *passMaxTimeLabel;
+ (instancetype)maxViewCell:(UITableView *)tableView;
@end
