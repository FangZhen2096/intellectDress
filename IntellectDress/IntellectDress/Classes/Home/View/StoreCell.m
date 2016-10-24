//
//  StoreCell.m
//  IntellectDress
//
//  Created by zerom on 16/9/30.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "StoreCell.h"

@implementation StoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.choseBtn.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



+ (instancetype)storeCell:(UITableView *)tableView{
    static NSString *ID = @"storeCell";
    StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StoreCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
