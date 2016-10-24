//
//  ProductDetailsViewCell.h
//  IntellectDress
//
//  Created by zerom on 16/9/28.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailsViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tryClothesLabel;
@property (weak, nonatomic) IBOutlet UILabel *tryOnLabel;
@property (weak, nonatomic) IBOutlet UILabel *disPlayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bottomSeperateLine;
@property (weak, nonatomic) IBOutlet UIImageView *TopSeperateLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineHeight;

+ (instancetype)productDetailsCell:(UITableView *)tableView;
@end
