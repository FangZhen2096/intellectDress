//
//  ZRMemoCell.h
//  IntellectDress
//
//  Created by 房 臻 on 16/9/23.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRMemoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UIButton *markBtn;


+(instancetype)memoCell:(UITableView *)tableView;
@end
