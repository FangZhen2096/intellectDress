//
//  BottomViewCell.m
//  IntellectDress
//
//  Created by zerom on 16/10/8.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "BottomViewCell.h"

@implementation BottomViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)bottomViewCell:(UITableView *)tableView{
    static NSString *ID = @"bottomViewCell";
    BottomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BottomViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
