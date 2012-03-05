//
//  NotificationController.m
//  PulseRate
//
//  Created by Aneesh on 21/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NotificationController.h"
#import "EventViewController.h"
#import "AppDelegate.h"
#import "Event.h"
#import <QuartzCore/QuartzCore.h>

@implementation NotificationController


//@implementation FlipsideViewController

//@synthesize delegate = _delegate;
@synthesize description;
@synthesize nameField,dateField;
@synthesize dateFormatter;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Schedule Reminders";
	self.view.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(239.0/255) blue:(213.0/255) alpha:1.0];
    description.layer.cornerRadius = 12; 
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
#pragma mark -
#pragma mark textField delegate methods

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


- (void)scheduleNotificationwithEvent :(Event *)event{
	
    
    
    Class cls = NSClassFromString(@"UILocalNotification");
    if (cls != nil) {
		
        UILocalNotification *notif = [[cls alloc] init];
        
        notif.fireDate =[[self dateFormatter] dateFromString:dateField.text];
        notif.timeZone = [NSTimeZone defaultTimeZone];
		
        notif.alertBody = event.desc;
        notif.alertAction = event.name;
        notif.soundName = UILocalNotificationDefaultSoundName;
        notif.applicationIconBadgeNumber = 1;
		
        
		
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        
    }
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

- (NSDateFormatter *)dateFormatter {	
	if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss'Z'"];
	}
	return dateFormatter;
}
#pragma mark - Actions
- (IBAction)back:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)done:(id)sender
{    NSLog(@"done called");
    if([nameField.text length]>0 && [description.text length]>0){
          NSLog(@"insede  done called");
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"Event" 
                                                                inManagedObjectContext:context];
        [object setValue:nameField.text forKey:@"name"];
        [object setValue:description.text forKey:@"desc"];
        NSLog(@"11");
        [object setValue:[self.dateFormatter dateFromString:dateField.text] forKey:@"date"];
        NSLog(@"2222222222");
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Failed to save - error: %@", [error localizedDescription]);
        }
        [self scheduleNotificationwithEvent:(Event *)object];
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Event schedulded"
                                                          message:@"Your event has been scheduled successfully."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        message.delegate=self;
        [message show];   

 }
    else{
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Fill carefully"
                                                          message:@"Please fill all fields carefully."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        message.delegate=self;
        
        [message show];    }
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    [self done:self];    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
