//
//  TryClothesCell.m
//  IntellectDress
//
//  Created by zerom on 16/10/14.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "TryClothesCell.h"

@implementation TryClothesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)tryClothesCell:(UITableView *)tableView{
    static NSString *ID = @"tryClothesCell";
    TryClothesCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TryClothesCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
