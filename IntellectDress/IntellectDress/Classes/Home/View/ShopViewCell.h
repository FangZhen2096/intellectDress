//
//  ShopViewCell.h
//  IntellectDress
//
//  Created by zerom on 16/10/8.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;


+ (instancetype)shopViewCell:(UITableView *)tableView;
@end
