//
//  EditReminderViewController.m
//  PulseRate
//
//  Created by Aneesh on 22/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditReminderViewController.h"


#import "EventViewController.h"
#import "AppDelegate.h"
#import "Event.h"
#import <QuartzCore/QuartzCore.h>
@implementation EditReminderViewController
@synthesize description;
@synthesize nameField,dateField;
@synthesize dateFormatter;
@synthesize tag;
@synthesize descriptionstr,nameFieldstr,dateFieldstr;


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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    nameField.text=nameFieldstr;
    description.text=descriptionstr;
    dateField.text=dateFieldstr;
    self.title=@"Reminder details";
    self.view.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(239.0/255) blue:(213.0/255) alpha:1.0];
    description.layer.cornerRadius = 12; 
    NSLog(@"tag is %d",tag);


}
 - (IBAction)updateRecord{
      AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
      NSManagedObjectContext *context = [appDelegate managedObjectContext];
      NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Event" 
                                                  inManagedObjectContext:context];
    
      NSFetchRequest *request = [[NSFetchRequest alloc] init];
     [request setEntity:entityDesc];
     NSPredicate *pred = 
     [NSPredicate predicateWithFormat:@"date = %@", 
     [[self dateFormatter] dateFromString:dateFieldstr]];
     [request setPredicate:pred];
     NSLog(@"hey ");
     NSError *error;
     NSArray *objects = [context executeFetchRequest:request 
                                              error:&error];
      NSLog(@"objects count are %d",[objects count]); 
     if([objects count]>0){
        Event *obj=[objects objectAtIndex:0];
        obj.name=nameField.text;
        obj.desc=description.text; 
        obj.date=[[self dateFormatter] dateFromString:dateField.text]; 
     }
     NSError *localError;
     [context save:&localError]; 
      [[NSNotificationCenter defaultCenter] postNotificationName:@"ContextDidSave" object:context];
     [self.navigationController popViewControllerAnimated:YES];
    
     //[NSThread detachNewThreadSelector:@selector(updateRecord:) toTarget:self withObject:nil];

}
- (IBAction)deleeRecord{
   
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Event" 
                                                  inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = 
    [NSPredicate predicateWithFormat:@"date = %@", 
     [[self dateFormatter] dateFromString:dateFieldstr]];
    [request setPredicate:pred];
    NSLog(@"hey ");
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request 
                                              error:&error];
    NSLog(@"objects count are %d",[objects count]); 
    Event *obj;
    if([objects count]>0){
    obj=[objects objectAtIndex:0];
    }
    [context deleteObject:obj];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ContextDidSave" object:context];
    [self.navigationController popViewControllerAnimated:YES];
  
    //[NSThread detachNewThreadSelector:@selector(deleeRecord:) toTarget:self withObject:nil];
    
}
-(void)update{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Event" 
                                                  inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = 
    [NSPredicate predicateWithFormat:@"date = %@", 
     [[self dateFormatter] dateFromString:dateFieldstr]];
    [request setPredicate:pred];
    NSLog(@"hey ");
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request 
                                              error:&error];
    NSLog(@"objects count are %d",[objects count]); 
    if([objects count]>0){
        Event *obj=[objects objectAtIndex:0];
        obj.name=nameField.text;
        obj.desc=description.text; 
        obj.date=[[self dateFormatter] dateFromString:dateField.text]; 
    }
    NSError *localError;
    [context save:&localError]; 
    [self.navigationController popViewControllerAnimated:YES];
    

}
-(void)deleted{

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Event" 
                                                  inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = 
    [NSPredicate predicateWithFormat:@"date = %@", 
     [[self dateFormatter] dateFromString:dateFieldstr]];
    [request setPredicate:pred];
    NSLog(@"hey ");
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request 
                                              error:&error];
    NSLog(@"objects count are %d",[objects count]); 
    Event *obj;
    if([objects count]>0){
        obj=[objects objectAtIndex:0];
    }
    [context deleteObject:obj];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ContextDidSave" object:context];
    [self.navigationController popViewControllerAnimated:YES];



}
- (NSDateFormatter *)dateFormatter {	
	if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss'Z'"];
	}
	return dateFormatter;
}
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

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"ashu sharma");
  if(textField==dateField){
        [textField resignFirstResponder];
        picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,95,100,100)];
        bar=[[UIToolbar alloc] initWithFrame:CGRectMake(0,70,320,25)];
        UIButton* setTimeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        setTimeButton.titleLabel.text=@"Set Time";
        UIBarButtonItem *barButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(do)];
        bar.items=[NSArray arrayWithObjects: barButton, nil];
        [self.view addSubview:picker];
        [self.view addSubview:bar];
        return NO;
        
    }
	return YES;
}
-(void)do{
    dateField.text=[self.dateFormatter stringFromDate:[picker date]];
    [picker setDatePickerMode:UIDataDetectorTypeCalendarEvent];
    [picker removeFromSuperview];
    [bar removeFromSuperview];
    
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
