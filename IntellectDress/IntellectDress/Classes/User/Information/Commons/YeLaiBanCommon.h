//
//  YeLaiBanCommon.h
//  YeLaiBan
//
//  Created by 小强 on 16/4/14.
//  Copyright © 2016年 geluya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YeLaiBanCommon : NSObject
-(NSAttributedString*)priceFormat:(NSString*)price;
-(NSAttributedString*)oldPriceFormat:(NSString*)price;
@end
