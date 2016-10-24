//
//  Permission.m
//  FK
//
//  Created by 小强 on 15/12/4.
//  Copyright © 2015年 xiaoshag. All rights reserved.
//

#import "Permission.h"

#import <AssetsLibrary/ALAsset.h>//AssetsLibrary.framework
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>//CoreLocation.framework
@implementation Permission
+ (BOOL)havePhotoLibraryPermission
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
        
        ALERT(@"请在设备的“设置->隐私->照片”中打开本应用的访问权限");
        return NO;
    }
    return YES;
}
+ (BOOL)haveCameraPermission
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {

        ALERT(@"该设备不支持拍照");
        return NO;
    }
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {

        ALERT(@"请在设备的“设置->隐私->相机”中打开本应用的访问权限");
        return NO;
    }
    
    return YES;
}
+(BOOL)haveLocationPermission{
    
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
           
        }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        ALERT(@"请开启定位权限");
        return NO;
    }
    return  YES;

}

+ (BOOL)haveRecordPermission
{
    __block BOOL bCanRecord = YES;
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                } else {
                     ALERT(@"请开启录音权限");
                    bCanRecord = NO;
                }
            }];
        }

    return bCanRecord;
}
@end
