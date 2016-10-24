//
//  HotRankShopCell.m
//  IntellectDress
//
//  Created by zerom on 16/10/13.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "HotRankShopCell.h"

@implementation HotRankShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)HotRankShopCell:(UITableView *)tableView{
    static NSString *ID = @"hotRankShopCell";
    HotRankShopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HotRankShopCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
