//
//  Permission.h
//  FK
//
//  Created by 小强 on 15/12/4.
//  Copyright © 2015年 xiaoshag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Permission : NSObject
+ (BOOL)havePhotoLibraryPermission;
+ (BOOL)haveCameraPermission;
+ (BOOL)haveLocationPermission;
+ (BOOL)haveRecordPermission;
@end
