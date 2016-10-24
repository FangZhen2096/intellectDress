
//  Created by 小强  on 15/9/17.
//

#import <Foundation/Foundation.h>


typedef void(^convertResultBlock)(NSArray *array);
@interface Convert : NSObject

+(NSArray *)convertToPinyinWithArray:(NSArray *)array key:(NSString *)key;
/**
 *  异步转换
 *
 */
+(void)convertToPinyinWithArray:(NSArray *)array key:(NSString *)key UsingBlock:(convertResultBlock)resultBlock;
@end
