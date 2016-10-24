//
//  GetHeader.m
//
//  Created by 小强 on 14-10-15.
//

#import "Photo.h"
#import "Sheet.h"
#import "Permission.h"
@implementation Photo
-(id)initWithOwner:(UIViewController*)owner{
    if (self=[super init]) {
    }
    if (self) {
        _owner = owner;
    }
    return self;
}
-(void)photoWithCallback:(PCallback) callback{
    _callback = callback;
    [[[Sheet alloc] initWithTitle:@"选择照片" callback:^(UIActionSheet *sheet, NSInteger buttonIndex) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (buttonIndex==0) {
            if ([Permission haveCameraPermission]) {
            sourceType = UIImagePickerControllerSourceTypeCamera;
            }else{
                return ;
            }
            
        }else if(buttonIndex==1){
            //
            if (![Permission havePhotoLibraryPermission]) {
                return;
            }
        }
        
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
        
        imagePickerController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        
        
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self.owner presentViewController:imagePickerController animated:YES completion:^{}];
        
    } titles:@[@"拍照",@"从相册选择"]] showInView:self.owner.view];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = info[UIImagePickerControllerEditedImage];
    _callback(image);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    _callback(nil);
}

@end
