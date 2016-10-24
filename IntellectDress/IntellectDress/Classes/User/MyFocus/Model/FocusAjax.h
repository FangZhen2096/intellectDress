//
//  FocusAjax.h
//  IntellectDress
//
//  Created by zerom on 16/10/24.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FocusAjax : NSObject
+ (void)FocusListWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;
@end
