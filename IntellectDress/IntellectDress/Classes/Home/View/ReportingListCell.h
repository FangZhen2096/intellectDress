//
//  ReportingListCell.h
//  IntellectDress
//
//  Created by zerom on 16/9/30.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportingListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *reportingContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UIView *containerView;

+ (instancetype)reportingListCell:(UITableView *)tableView;
@end
