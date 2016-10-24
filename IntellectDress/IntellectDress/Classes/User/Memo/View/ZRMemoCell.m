//
//  ZRMemoCell.m
//  IntellectDress
//
//  Created by 房 臻 on 16/9/23.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import "ZRMemoCell.h"

@interface ZRMemoCell ()


@end


@implementation ZRMemoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)selectedBtnCLick:(id)sender {
    self.selectedBtn.selected = !self.selectedBtn.selected;
}

+(instancetype)memoCell:(UITableView *)tableView
{
    static NSString *ID = @"memoCell";
    ZRMemoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZRMemoCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
