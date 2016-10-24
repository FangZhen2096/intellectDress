//
//  ProductInfoCell.h
//  IntellectDress
//
//  Created by 房 臻 on 16/9/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *piece;
@property (weak, nonatomic) IBOutlet UILabel *trying;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *fitt;
@property (weak, nonatomic) IBOutlet UILabel *ber;
@property (weak, nonatomic) IBOutlet UILabel *price;



+(instancetype)productInfoCell:(UITableView *)tableView;
@end
