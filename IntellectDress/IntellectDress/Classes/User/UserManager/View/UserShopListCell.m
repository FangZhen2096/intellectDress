//
//  UserShopListCell.m
//  IntellectDress
//
//  Created by zerom on 16/10/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "UserShopListCell.h"

@implementation UserShopListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)UserShopListCell:(UITableView *)tableView{
    static NSString *ID = @"UserShopListCell";
    UserShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserShopListCell" owner:self options:nil] lastObject];
    }
    return cell;
    
}
@end
