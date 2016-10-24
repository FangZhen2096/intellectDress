//
//  GetHeader.h
//
//  Created by 小强 on 14-10-15.

//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Photo : NSObject<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property UIViewController*owner;
typedef void (^PCallback) ( UIImage*resultImage);
@property (nonatomic, strong)PCallback callback;
-(id)initWithOwner:(UIViewController*)owner;
-(void)photoWithCallback:(PCallback) callback;

@end
