//
//  YeLaiBanCommon.m
//  YeLaiBan
//
//  Created by 小强 on 16/4/14.
//  Copyright © 2016年 geluya. All rights reserved.
//

#import "YeLaiBanCommon.h"

@implementation YeLaiBanCommon
-(NSAttributedString*)priceFormat:(NSString*)price{
    NSMutableAttributedString*result = [[NSMutableAttributedString alloc] initWithString:price];
    [result setAttributes:@{NSFontAttributeName:    [UIFont systemFontOfSize:12]} range:NSMakeRange(0, 1)];
    return result;
}
-(NSAttributedString*)oldPriceFormat:(NSString*)price{
       NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
      NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:price attributes:attribtDic];
    return attribtStr;
}
@end
