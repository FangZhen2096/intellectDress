//
//  NSString+Kit.m
//  GoodTeacher
//
//  Created by 小强 on 15/5/22.
//  Copyright (c) 2015年 XiaoShang. All rights reserved.
//

#import "NSString+Commons.h"
#import "CommonCrypto/CommonDigest.h"
@implementation NSString (Commons)
-(NSString*)trim{
    NSCharacterSet *whitespace = [NSCharacterSet  whitespaceAndNewlineCharacterSet];
    [self  stringByTrimmingCharactersInSet:whitespace];
    return self;
}
-(BOOL)isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:self];
}
-(BOOL)containsChinese{
    
    for(int i=0; i< self.length;i++) {
        
        int a = [self characterAtIndex:i];
        
        if( a >0x4e00 && a < 0x9fff) {
            
            return YES;
            
        }
        
    }
    return NO;
    
}
-(BOOL)isempty{
    if (!self) {
        return YES;
    }
    if (![self isKindOfClass:[NSString class]]) {
        return  YES;
    }
    if ([self trim].length==0) {
        return YES;
    }
    return NO;
}
-(BOOL)contains:(NSString*) str{
    NSRange range = [self rangeOfString:str];
    return range.length != 0;
}
- (NSString *)md5_32{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)self.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}
-(BOOL)isPhone{
    if (self.length < 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:self];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:self];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:self];
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
}
-(CGFloat)heightWithSize:(CGSize)size font:(UIFont*)font{
      NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    return [self boundingRectWithSize:size options:options attributes:@{NSFontAttributeName:font} context:nil].size.height;
}

-(NSDictionary*)toDictionary {
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if(error){
        return nil;
    }
    return result;
}
//-(NSString*)dicToString:(NSDictionary*)dic{
//    if(!dic){
//        return nil;
//    }
//    NSError* error;
//    NSData* data = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:&error];
//    if(error){
//        return nil;
//    }
//    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//}
@end
