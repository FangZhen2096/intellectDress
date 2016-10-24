//
//  NewsCell.m
//  clothesnews
//
//  Created by 小强 on 16/5/16.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "NewsCell.h"
@interface NewsCell()
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsDetailLabel;

@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@end
@implementation NewsCell


-(void)fillWithDic:(NSDictionary*)dic{
    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:FORMAT(@"%@",dic[@"img"])] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _newsImageView.contentMode=UIViewContentModeScaleAspectFit;
//    _newsImageView.frame=CGRectMake(8, 4, 122, 85.5);
    _newsTitleLabel.text = FORMAT(@"%@",dic[@"title"]);
    _newsDetailLabel.text = FORMAT(@"%@",dic[@"info"]);
    if ([dic[@"read"] boolValue]) {
        _newsTitleLabel.textColor = [UIColor lightGrayColor];
    }else{
        _newsTitleLabel.textColor = [UIColor blackColor];
    }
    
    //    "id": "528",
    //    "title": "雷军其实想用小米Max和MIUI 8告诉你：手握2亿用户，我们该怎么飞",
    //    "url": "http://m.ba-mgt.com/article/show/528",
    //    "info": "距离小米5发布两个半月，5月10日，小米公司正式发布了大屏旗舰手机小米Max与新一代手机操作系统MIUI 8。",
    //    "img": "http://pic.ba-mgt.com/images/20160516/14633671781729.jpg",
    //    "hot": "0",
    //    "time": "2016/05/16",
    //    "copyright": "0",
    //    "read": false
    
    
}


@end
