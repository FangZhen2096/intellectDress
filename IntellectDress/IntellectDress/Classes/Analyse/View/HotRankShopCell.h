//
//  HotRankShopCell.h
//  IntellectDress
//
//  Created by zerom on 16/10/13.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotRankShopCell : UITableViewCell
/**
 排行名次
 */
@property (weak, nonatomic) IBOutlet UILabel *rankNumLabel;
/**
 商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;

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
 商品热度进度条
 */
@property (weak, nonatomic) IBOutlet UIProgressView *shopProgressView;

/**
 进度条百分比
 */
@property (weak, nonatomic) IBOutlet UILabel *progressPercentLabel;

@property(nonatomic,assign) NSInteger gid;

+ (instancetype)HotRankShopCell:(UITableView *)tableView;

@end
