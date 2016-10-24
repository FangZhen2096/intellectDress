//
//  ProductDetailsViewCell.m
//  IntellectDress
//
//  Created by zerom on 16/9/28.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ProductDetailsViewCell.h"

@implementation ProductDetailsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_colorLabel setTextColor:RGB(139, 139, 139)];
    [_sizeLabel setTextColor:RGB(139, 139, 139)];
    [_tryClothesLabel setTextColor:RGB(67, 190, 198)];
    [_tryOnLabel setTextColor:RGB(67, 190, 198)];
    [_disPlayLabel setTextColor:RGB(67, 190, 198)];
}

+ (instancetype)productDetailsCell:(UITableView *)tableView{
    static NSString *ID = @"productDetails";
    ProductDetailsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailsViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
