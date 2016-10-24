//
//  Config.m
//

//

#import "Config_.h"

@implementation Config_
+(void)set:(NSString*)key value:(id)value
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)get:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
@end
