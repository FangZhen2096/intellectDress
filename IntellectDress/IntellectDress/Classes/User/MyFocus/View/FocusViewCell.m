//
//  FocusViewCell.m
//  IntellectDress
//
//  Created by zerom on 16/9/29.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "FocusViewCell.h"

@interface FocusViewCell ()


@end


@implementation FocusViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectedBtnClick:(id)sender {
    _selectedBtn.selected = !_selectedBtn.selected;
}


+(instancetype)focusCell:(UITableView *)tableView{
    static NSString *ID = @"focusCell";
    FocusViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FocusViewCell" owner:self options:nil] lastObject];
    }
    return cell;
    
}



@end
