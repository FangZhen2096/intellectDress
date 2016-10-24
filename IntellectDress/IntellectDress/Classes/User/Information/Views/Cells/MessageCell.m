//
//  MessageCell.m
//  clothesnews
//
//  Created by 小强 on 16/5/20.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "MessageCell.h"
@interface MessageCell()
@property (weak, nonatomic) IBOutlet UIImageView *unreadMessage;
@property (weak, nonatomic) IBOutlet UILabel *messageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong,nonatomic) NSDictionary *dic;
@end
@implementation MessageCell


-(void)fillWithDic:(NSDictionary*)dic{
    _unreadMessage.hidden = [dic[@"see"] boolValue];
    [self.messageTitleLabel setText:  FORMAT(@"%@",dic[@"title"])];
    [self.timeLabel setText: FORMAT(@"%@ %@",dic[@"type"],dic[@"time"])];
    [self.infoLabel setText: FORMAT(@"%@",dic[@"info"])];
    NSLog(@"timelabel  ---%@",FORMAT(@"%@ %@",dic[@"type"],dic[@"time"]));
    _dic = dic;
    NSLog(@"timelabel.text------:%@",self.timeLabel.text);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
