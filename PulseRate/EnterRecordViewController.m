//
//  MainViewController.m
//  PulseRate
//
//  Created by Aneesh on 04/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EnterRecordViewController.h"
#import "AppDelegate.h"
#import "PulseRecord.h"
#import "ViewRecordController.h"

@implementation EnterRecordViewController
@synthesize temprature,bloodPressure,pulse;
@synthesize scView;
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
    scView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    
}
-(IBAction)subMit:(id)sender{
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    
    
    PulseRecord *newContact = [NSEntityDescription insertNewObjectForEntityForName:@"PulseRecord" inManagedObjectContext:context];
    int pul=[pulse.text intValue];
    float bp=[bloodPressure.text floatValue];
    float tmp=[temprature.text floatValue];
    
    newContact.pulse=pul;
    newContact.bloodPresssure=bp;
    newContact.temprature=tmp;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss ZZZ"];
    newContact.entrytime =[dateFormatter stringFromDate:[NSDate date]];
    
    
    if(pul> 220){
        
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"Pulse Value Out of range" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alertView show];
    }
    else if(bp>230.00){
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"Blood Pressure  Out of range" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alertView show];
        
    }
    else if(tmp>110.00 || tmp< 94){
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"Temprature  Out of range" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alertView show];
        
    }
    
    else{
        NSError *error;
        if([context save:&error]){
            UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"Your Record Inserted successfully" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
        
        [self dismissModalViewControllerAnimated:YES];    
    }
}



-(IBAction)done:(id)sender{
    
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




-(void)textFieldDidBeginEditing:(UITextField *)textField { 
    if (textField==bloodPressure) {
        
        
        scView.frame = CGRectMake( scView.frame.origin.x,  scView.frame.origin.y-30, 
                                  scView.frame.size.width,  scView.frame.size.height); 
    }
    if (textField==temprature) {
        
        
        scView.frame = CGRectMake( scView.frame.origin.x,  scView.frame.origin.y-90, 
                                  scView.frame.size.width,  scView.frame.size.height); 
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField==bloodPressure) {
        scView.frame = CGRectMake(scView.frame.origin.x,  scView.frame.origin.y+30, 
                                  scView.frame.size.width,  scView.frame.size.height ); 
    }
    if (textField==temprature) {
        
        
        scView.frame = CGRectMake( scView.frame.origin.x,  scView.frame.origin.y+90, 
                                  scView.frame.size.width,  scView.frame.size.height); 
    }
    
}
#pragma mark - Flipside View



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
