//
//  ReportListView.h
//  IntellectDress
//
//  Created by zerom on 16/10/20.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportListView : UIView
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *title;
@property (weak, nonatomic) IBOutlet UILabel *start;
@property (weak, nonatomic) IBOutlet UILabel *end;

@end
