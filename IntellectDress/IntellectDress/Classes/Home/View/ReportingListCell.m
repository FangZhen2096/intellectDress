//
//  ReportingListCell.m
//  IntellectDress
//
//  Created by zerom on 16/9/30.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ReportingListCell.h"

@implementation ReportingListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)reportingListCell:(UITableView *)tableView{
    static NSString *ID = @"reportingListCell";
    ReportingListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ReportingListCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
