//
//  SearchResultCell.m
//  clothesnews
//
//  Created by 小强 on 16/5/20.
//  Copyright © 2016年 persona. All rights reserved.
//

#import "SearchResultCell.h"
@interface SearchResultCell()
@property (weak, nonatomic) IBOutlet UILabel *searchResultTitle;
@property (weak, nonatomic) IBOutlet UILabel *time;


@end
@implementation SearchResultCell


-(void)fillWithDic:(NSDictionary*)dic searchKey:(NSString*)searchKey{
    NSString*targetStr = FORMAT(@"%@",dic[@"title"]);
    NSMutableAttributedString*mutstr = [[NSMutableAttributedString alloc] initWithString:targetStr];
    NSRange range = [targetStr rangeOfString:searchKey];
    [mutstr setAttributes:@{NSForegroundColorAttributeName:GlobalTintColor} range:range];
    _time.text = FORMAT(@"%@",dic[@"time"]);
    _searchResultTitle.attributedText = mutstr;
}


@end
