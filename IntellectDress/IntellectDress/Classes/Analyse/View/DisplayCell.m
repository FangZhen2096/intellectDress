//
//  DisplayCell.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/22.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "DisplayCell.h"

@interface DisplayCell ()


@end


@implementation DisplayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)likeBtnClick:(id)sender {
    _likeBtn.selected = !_likeBtn.selected;
}


+ (instancetype)displayCell:(UITableView *)tableView{
    static NSString *ID = @"displayCell";
    DisplayCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DisplayCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
