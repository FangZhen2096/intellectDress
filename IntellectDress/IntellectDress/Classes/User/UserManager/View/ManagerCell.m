//
//  ManagerCell.m
//  IntellectDress
//
//  Created by zerom on 16/10/12.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ManagerCell.h"

@implementation ManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(instancetype)managerCell:(UITableView *)tableView{
    static NSString *ID = @"managerCell";
    ManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ManagerCell" owner:self options:nil] lastObject];
    }
    return cell;
    
}
@end
