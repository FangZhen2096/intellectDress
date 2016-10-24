//
//  ShopViewCell.m
//  IntellectDress
//
//  Created by zerom on 16/10/8.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ShopViewCell.h"

@implementation ShopViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)shopViewCell:(UITableView *)tableView{
    static NSString *ID = @"shopViewCell";
    ShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShopViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



@end
