//
//  GridViewController.m
//  Grid
//
//  Created by lee jory on 09-10-22.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "GridViewController.h"


@implementation GridViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	DataGridComponentDataSource *ds = [[DataGridComponentDataSource alloc] init];
	
	ds.columnWidth = [NSArray arrayWithObjects:@"80",@"70",@"120",@"70",@"70",@"120",@"70",nil];
	ds.titles = [NSArray arrayWithObjects:@"name",@"age",@"birthday",@"test",@"fff",@"fdfde",@"88"];
	ds.data = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   [NSArray arrayWithObjects:@"jory",@"21",@"1999.10.10",@"haha",@"r32141234",@"cvdfa332",@"88888"],
			   nil];
	DataGridComponent *grid = [[DataGridComponent alloc] initWithFrame:CGRectMake(0, 100, 320, 200) data:ds];
	
	[self.view addSubview:grid];
	
    [super viewDidLoad];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



@end
