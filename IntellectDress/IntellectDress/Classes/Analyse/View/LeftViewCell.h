//
//  LeftViewCell.h
//  IntellectDress
//
//  Created by 房 臻 on 16/9/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *total;

@property (nonatomic,assign)BOOL isSelected;
+ (instancetype)leftViewCell:(UITableView *)tableView;
@end
