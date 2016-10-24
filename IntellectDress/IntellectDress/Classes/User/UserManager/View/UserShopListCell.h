//
//  UserShopListCell.h
//  IntellectDress
//
//  Created by zerom on 16/10/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserShopListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shopName;

@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;
+(instancetype)UserShopListCell:(UITableView *)tableView;
@end
