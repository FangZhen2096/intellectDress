//
//  ShopChoseCell.h
//  IntellectDress
//
//  Created by zerom on 16/10/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopChoseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property(nonatomic,assign) BOOL isSelected;
+ (instancetype)ShopChoseCell:(UITableView *)tableView;
@end
