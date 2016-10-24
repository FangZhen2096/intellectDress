//
//  DisplayCell.h
//  IntellectDress
//
//  Created by 房 臻 on 16/9/22.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayCell : UITableViewCell

/**
 商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;

/**
 商品名字
 */
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

/**
 商品编号
 */
@property (weak, nonatomic) IBOutlet UILabel *shopNumLabel;

/**
 商品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *shopPriceLabel;

/**
 商品数量
 */
@property (weak, nonatomic) IBOutlet UILabel *shopCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

+ (instancetype)displayCell:(UITableView *)tableView;
@end
