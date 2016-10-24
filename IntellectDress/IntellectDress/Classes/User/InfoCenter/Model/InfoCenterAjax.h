//
//  InfoCenterAjax.h
//  IntellectDress
//
//  Created by zerom on 16/10/19.
//  Copyright © 2016年 zerom-FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoCenterAjax : NSObject
+ (void)infoCenterWithSuccess:(void (^)(NSDictionary *dict))success failed:(void (^)(NSError *error))failed;
@end
