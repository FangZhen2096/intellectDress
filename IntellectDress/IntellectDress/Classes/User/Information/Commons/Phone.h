//
//  Phone.h
//
//  Created by 小强 on 14-11-22.
//
#define KEY_UDID            @"KEY_UDID"
#define KEY_IN_KEYCHAIN     @"KEY_IN_KEYCHAIN"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface Phone : NSObject
- (void)callPhone:(NSString*)number;
-(void)sendSMS:(NSString*)number text:(NSString*)text owner:(UIViewController<MFMessageComposeViewControllerDelegate>*)owner;
-(void)playVideo:(NSString*)urlStr;
-(NSString*)AppVersion;
- (NSString*)readUDID;
@end
