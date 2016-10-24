//
//  TryClothesCell.h
//  IntellectDress
//
//  Created by zerom on 16/10/14.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TryClothesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cupImageView;
@property (weak, nonatomic) IBOutlet UILabel *clothesNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;
+ (instancetype)tryClothesCell:(UITableView *)tableView;
@end
