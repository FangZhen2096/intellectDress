//
//  Config.h
//


//

#import <Foundation/Foundation.h>

@interface Config_ : NSObject
+(void)set:(NSString*)key value:(id)value;
+(id)get:(NSString*)key;
@end
