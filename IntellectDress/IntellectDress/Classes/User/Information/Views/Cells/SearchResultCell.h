//
//  SearchResultCell.h
//  clothesnews
//
//  Created by 小强 on 16/5/20.
//  Copyright © 2016年 persona. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultCell : UITableViewCell
-(void)fillWithDic:(NSDictionary*)dic searchKey:(NSString*)searchKey;
@end
