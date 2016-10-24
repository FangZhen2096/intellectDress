//
//  ShopChoseCell.m
//  IntellectDress
//
//  Created by zerom on 16/10/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ShopChoseCell.h"

@implementation ShopChoseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _switchBtn.onTintColor = defaultColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)switchBtnClick:(UISwitch *)sender {
    if (sender.on == YES) {
        _isSelected = YES;
    }else{
        _isSelected = NO;
    }
}

+ (instancetype)ShopChoseCell:(UITableView *)tableView{
    static NSString *ID = @"ShopChoseCell";
    ShopChoseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShopChoseCell" owner:self options:nil] lastObject];
    }
    return cell;
}
@end
