//
//  GridAppDelegate.m
//  Grid
//
//  Created by lee jory on 09-10-22.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "GridAppDelegate.h"
#import "GridViewController.h"

@implementation GridAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}




@end
