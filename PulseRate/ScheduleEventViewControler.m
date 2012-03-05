//
//  ScheduleEventViewControler.m
//  PulseRate
//
//  Created by Aneesh on 21/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleEventViewControler.h"
#import "EventViewController.h"
#import "NotificationController.h"
#import "AddNotesViewController.h"
#import "ViewNotesController.h"
@implementation ScheduleEventViewControler
@synthesize nearByHospitalController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(IBAction)scheduleEvent:(id)sende{
    NSLog(@"view evemts");
    NotificationController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:controller animated:YES];

}
-(IBAction)viewEvent:(id)sender{
    NSLog(@"view evemts");
    EventViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"EventViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
-(IBAction)addNotes:(id)sender{

    NSLog(@"view evemts");
    AddNotesViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddNotesViewController"];
    [self.navigationController pushViewController:controller animated:YES];

}
-(IBAction)viewNotes:(id)sender{
   
    
    ViewNotesController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewNotesController"];
    [self.navigationController pushViewController:controller animated:YES];
     NSLog(@"fffffff");
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
-(IBAction)done:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Others";
	NSLog(@"VIEW DID LOAD");
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	self.navigationController.toolbar.tintColor = [UIColor blackColor];
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
}

- (void)contextDidSave:(NSNotification *)notification
{
    
    NSLog(@"contextDidSave");
    //    SEL selector = @selector(mergeChangesFromContextDidSaveNotification:);
    //    [[[[UIApplication sharedApplication] delegate] managedObjectContext] performSelectorOnMainThread:selector withObject:notification waitUntilDone:YES];
    //    
    [self viewDidLoad];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"NerByHospital"]) {
        nearByHospitalController=[self.storyboard instantiateViewControllerWithIdentifier:@"NearByHospitalController"];
        nearByHospitalController=[segue destinationViewController];
        NSLog(@"hi---prepare for seague");
        
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
