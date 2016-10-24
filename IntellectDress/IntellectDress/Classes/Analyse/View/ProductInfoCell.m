//
//  ProductInfoCell.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ProductInfoCell.h"


@interface ProductInfoCell ()


@end


@implementation ProductInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//喜欢按钮点击
- (IBAction)likeBtnClick:(id)sender {
    
    _likeBtn.selected = !_likeBtn.selected;
}

+ (instancetype)productInfoCell:(UITableView *)tableView{
    static NSString *ID = @"product";
    ProductInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductInfoCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
