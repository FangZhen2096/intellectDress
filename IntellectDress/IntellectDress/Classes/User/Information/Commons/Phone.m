//
//  Phone.m
//
//  Created by 小强 on 14-11-22.

//

#import "Phone.h"
#import <MediaPlayer/MediaPlayer.h>
#import <Security/Security.h>
@interface Phone()
@property  MPMoviePlayerViewController *moviePlayerView;
@end
@implementation Phone
- (void)callPhone:(NSString*)number
{
    if(number.length==0){
        return;
    }
    if (UI_USER_INTERFACE_IDIOM()!=UIUserInterfaceIdiomPhone)
    {
        //        [Dialog alert:@"您的设备不能拨打电话。"];
        return;
    }
    NSString* str = [NSString stringWithFormat:@"telprompt:%@", number];
    NSURL* url = [NSURL URLWithString:str];
    [[UIApplication sharedApplication] openURL:url];
}
- (void)sendSMS:(NSString *)number text:(NSString*)text owner:(UIViewController<MFMessageComposeViewControllerDelegate>*)owner;
{
    /*
     if([NSString isEmpty:number]){
     return;
     }
     NSString* str = [NSString stringWithFormat:@"sms:%@&content=%@", number,text];
     NSURL* url = [NSURL URLWithString:str];
     [[UIApplication sharedApplication] openURL:url];*/
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = owner;
            picker.recipients = @[number];
            picker.body = text;
            owner.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [owner presentViewController:picker animated:YES completion:nil];
        }
        else {
            //设备没有短信功能
        }
    }
    else {
        // iOS版本过低,iOS4.0以上才支持程序内发送短信
    }}
- (NSString *)openUDID
{
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    return identifierForVendor;
}
- (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service, (__bridge_transfer id)kSecAttrService,
            service, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible, nil];
}
- (void)save:(NSString *)service data:(id)data {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}
- (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            DLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    return ret;
}
- (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}
- (void)saveUDID:(NSString *)udid
{
    NSMutableDictionary *udidKVPairs = [NSMutableDictionary dictionary];
    [udidKVPairs setObject:udid forKey:KEY_UDID];
    [self save:KEY_IN_KEYCHAIN data:udidKVPairs];
}
- (NSString*)readUDID
{
    NSString*_uuid = @"";
    NSMutableDictionary *udidKVPairs = (NSMutableDictionary *)[self load:KEY_IN_KEYCHAIN];
    NSString *uuid = [udidKVPairs objectForKey:KEY_UDID];
    if (uuid == nil || uuid.length == 0) {
        uuid = [self openUDID];
        [self saveUDID:uuid];
        _uuid = uuid;
    }else{
        _uuid = uuid;
    }
    return _uuid;
}

-( void )playingDone
{
    [   _moviePlayerView.view removeFromSuperview ];
    _moviePlayerView = nil ;
}

-(NSString*)AppVersion{
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString *systemVersion = myDevice.systemVersion;
    return systemVersion;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)playVideo:(NSString*)urlStr{
    [[ NSNotificationCenter defaultCenter ] addObserver : self selector : @selector (playingDone) name : MPMoviePlayerPlaybackDidFinishNotification object : nil ];
    //视频URL
    _moviePlayerView = [[ MPMoviePlayerViewController alloc ] initWithContentURL :[NSURL URLWithString:urlStr]];
    // 设定播放模式
    _moviePlayerView.moviePlayer.controlStyle = MPMovieControlStyleFullscreen ;
    // 控制模式 ( 触摸 )
    _moviePlayerView.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    // 开始播放
    [[[ UIApplication sharedApplication ] keyWindow ] addSubview : _moviePlayerView . view ];
    //    [_moviePlayerView . moviePlayer play];
    
}
@end
