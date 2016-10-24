//
//  DeviceCell.h
//  IntellectDress
//
//  Created by zerom on 16/10/9.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceCell : UITableViewCell
//设备名
@property (weak, nonatomic) IBOutlet UILabel *deviceName;
//设备编号
@property (weak, nonatomic) IBOutlet UILabel *deviceNum;
//设备状态
@property (weak, nonatomic) IBOutlet UILabel *deviceState;

+ (instancetype)deviceCell:(UITableView *)tableView;

@end
