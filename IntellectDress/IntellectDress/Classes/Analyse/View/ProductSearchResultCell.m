//
//  ProductSearchResultCell.m
//  IntellectDress
//
//  Created by zerom on 16/10/18.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ProductSearchResultCell.h"

@implementation ProductSearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)ProductSearchResultCellCell:(UITableView *)tableView{
    static NSString *ID = @"productSearchResultCell";
    ProductSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductSearchResultCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
