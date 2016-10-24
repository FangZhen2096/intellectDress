

#import "File.h"
@implementation File

+ (NSString*)loadStringFromCachePath:(NSString*)path{
    NSError* error;
    NSString *string = [NSString stringWithContentsOfFile:path
                                                 encoding:NSUTF8StringEncoding
                                                    error:&error];
    if (!error) {
        return string;
    }
    return @"";
}
+(NSString*)getCachePath:(NSString*)fileName{
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString*path = paths[0];
    NSString* filePath = [NSString stringWithFormat:@"%@/%@",path,fileName];
    return  filePath;
}
+(BOOL)saveFile:(NSData*)data fileName:(NSString*)fileName{
     NSString*filePath = [self getCachePath:fileName];
    return [data writeToFile:filePath atomically:YES];
}
+ (BOOL)saveString:(NSString*)string fileName:(NSString*)fileName{
    NSString*filePath = [self getCachePath:fileName];
    NSData* data  =[string dataUsingEncoding:NSUTF8StringEncoding];
    BOOL result= [data writeToFile:filePath atomically:YES];
    return  result;
}

@end
