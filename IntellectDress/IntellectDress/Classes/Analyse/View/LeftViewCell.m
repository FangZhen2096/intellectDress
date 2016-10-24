//
//  LeftViewCell.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/21.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "LeftViewCell.h"


@interface LeftViewCell ()
@property (weak, nonatomic) IBOutlet UIView *backGroundView;


@end


@implementation LeftViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _backGroundView.backgroundColor = defaultColor;
    [_total roundWithRadius:9];
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (isSelected) {
        _backGroundView.backgroundColor = [UIColor whiteColor];
        [_title setTextColor:defaultColor];
        [_total setTextColor:[UIColor whiteColor]];
        [_total setBackgroundColor:defaultColor];
    }else{
        _backGroundView.backgroundColor = defaultColor;
        [_title setTextColor:[UIColor whiteColor]];
        [_total setTextColor:defaultColor];
        [_total setBackgroundColor:[UIColor whiteColor]];
    }

}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//    self.selected = !self.selected;
//    if (selected) {
//        _backGroundView.backgroundColor = [UIColor whiteColor];
//        [_allProductLabel setTextColor:defaultColor];
//        [_productCountLabel setTextColor:[UIColor whiteColor]];
//        [_productCountLabel setBackgroundColor:defaultColor];
//    }else{
//        _backGroundView.backgroundColor = defaultColor;
//        [_allProductLabel setTextColor:[UIColor whiteColor]];
//        [_productCountLabel setTextColor:defaultColor];
//        [_productCountLabel setBackgroundColor:[UIColor whiteColor]];
//    }
//}





+ (instancetype)leftViewCell:(UITableView *)tableView{
    static NSString *ID = @"leftViewCell";
    LeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LeftViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}
@end
