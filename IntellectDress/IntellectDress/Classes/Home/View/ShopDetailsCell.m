//
//  ShopDetailsCell.m
//  IntellectDress
//
//  Created by zerom on 16/10/20.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ShopDetailsCell.h"

@implementation ShopDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)ShopDetailsCell:(UITableView *)tableView{
    static NSString *ID = @"ShopDetailsCell";
    ShopDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShopDetailsCell" owner:self options:nil] lastObject];
    }
    return cell;
}
@end
