//
//  ManagerCell.h
//  IntellectDress
//
//  Created by zerom on 16/10/12.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *managerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *managerJobLabel;
+(instancetype)managerCell:(UITableView *)tableView;
@end
