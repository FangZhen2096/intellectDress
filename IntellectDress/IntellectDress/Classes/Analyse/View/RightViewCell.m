//
//  RightViewCell.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "RightViewCell.h"

@implementation RightViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)rightViewCell:(UITableView *)tableView{
    static NSString *ID = @"leftViewCell";
    RightViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RightViewCell" owner:self options:nil] lastObject];
    }
    return cell;
    
}
@end
