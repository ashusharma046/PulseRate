//
//  AddNotesViewController.m
//  PulseRate
//
//  Created by Aneesh on 23/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddNotesViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
@implementation AddNotesViewController
@synthesize nameField,description;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
 */
/*
 // text field delegtae methods
 
 */
- (BOOL) textFieldShouldEndEditing:(UITextField *)textField{
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  	
    [textField resignFirstResponder];
	return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    [textView resignFirstResponder];
	return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
- (NSDateFormatter *)dateFormatter {	
	
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss'Z'"];
	
	return dateFormatter;
}
-(IBAction)addNote:(id)sender{
 
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"Notes" 
                                                            inManagedObjectContext:context];
    [object setValue:nameField.text forKey:@"name"];
    [object setValue:description.text forKey:@"desc"];
    NSLog(@"11");
    [object setValue:[[self dateFormatter] stringFromDate:[NSDate date]] forKey:@"date"];
    
    NSError *error;
    NSLog(@"date is %@",[NSDate date]);
    if (![context save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    description.layer.cornerRadius = 12; 
    self.title = @"Add Notes";
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
