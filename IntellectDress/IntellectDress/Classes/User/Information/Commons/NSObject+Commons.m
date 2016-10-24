//
//  NSObject+Commons.m
//  YeLaiBan
//
//  Created by 小强 on 16/5/6.
//  Copyright © 2016年 geluya. All rights reserved.
//

#import "NSObject+Commons.h"

@implementation NSObject (Commons)
-(NSString*)toString{
    NSError*error;
    NSData* data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error) {
        return  nil;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end
