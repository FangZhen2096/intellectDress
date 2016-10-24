//
//  MaxViewCell.m
//  IntellectDress
//
//  Created by zerom on 16/10/13.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "MaxViewCell.h"

@implementation MaxViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)maxViewCell:(UITableView *)tableView{
    static NSString *ID = @"maxViewCell";
    MaxViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MaxViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
