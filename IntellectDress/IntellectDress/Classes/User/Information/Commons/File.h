//
//  File.h
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface File : NSObject
+(NSString*)getCachePath:(NSString*)fileName;
+ (NSString*)loadStringFromCachePath:(NSString*)fileName;
+ (BOOL)saveString:(NSString*)string fileName:(NSString*)fileName;
+(BOOL)saveFile:(NSData*)data fileName:(NSString*)fileName;
@end
