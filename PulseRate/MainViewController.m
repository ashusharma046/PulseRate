//
//  MainViewController.m
//  PulseRate
//
//  Created by Aneesh on 04/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "PulseRecord.h"
#import "ViewRecordController.h"

@implementation MainViewController
@synthesize temprature,bloodPressure,pulse;

@synthesize viewRecordController;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor=[UIColor purpleColor];
    self.title=@"Enter Records";
}
-(IBAction)subMit:(id)sender{

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
    
    
    PulseRecord *newContact = [NSEntityDescription insertNewObjectForEntityForName:@"PulseRecord" inManagedObjectContext:context];
    int pul=[pulse.text intValue];
    float bp=[bloodPressure.text floatValue];
    float tmp=[temprature.text floatValue];
    
    NSLog(@"-----%d--------%f-------%f",pul,bp,tmp);
    newContact.pulse=pul;
    newContact.bloodPresssure=bp;
    newContact.temprature=tmp;
    newContact.entrytime= [NSDate date];
 
     NSError *error;
    if([context save:&error]){
       /* UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"Your Record Inserted Successfully"
														  delegate:nil
												 cancelButtonTitle:@"OK"
												 otherButtonTitles:nil];
		*/
        
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"Your Record Inserted successfully" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alertView show];
    
    }
    
    [self dismissModalViewControllerAnimated:YES];    
    }



-(IBAction)done:(id)sender{
    NSLog(@"done1111 pressed");
    [self dismissModalViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
   }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
