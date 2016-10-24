//
//  InfoListCell.h
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *time;
+ (instancetype)InfoListCell:(UITableView *)tableView;
@end
