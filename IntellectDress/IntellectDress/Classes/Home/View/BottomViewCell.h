//
//  BottomViewCell.h
//  IntellectDress
//
//  Created by zerom on 16/10/8.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
+ (instancetype)bottomViewCell:(UITableView *)tableView;
@end
