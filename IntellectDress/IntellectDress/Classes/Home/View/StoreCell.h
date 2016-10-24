//
//  StoreCell.h
//  IntellectDress
//
//  Created by zerom on 16/9/30.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *choseBtn;
@property (weak, nonatomic) IBOutlet UILabel *title;

+ (instancetype)storeCell:(UITableView *)tableView;

@end
