//
//  InfoListCell.m
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "InfoListCell.h"

@implementation InfoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)InfoListCell:(UITableView *)tableView{
    static NSString *ID = @"infoListCell";
    InfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoListCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
