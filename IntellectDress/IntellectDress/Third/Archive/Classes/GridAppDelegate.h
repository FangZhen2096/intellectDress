//
//  GridAppDelegate.h
//  Grid
//
//  Created by lee jory on 09-10-22.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GridViewController;

@interface GridAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GridViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GridViewController *viewController;

@end

