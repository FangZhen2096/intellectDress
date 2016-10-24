//
//  DeviceCell.m
//  IntellectDress
//
//  Created by zerom on 16/10/9.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "DeviceCell.h"

@implementation DeviceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)deviceCell:(UITableView *)tableView{
    static NSString *ID = @"deviceCell";
    DeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DeviceCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
