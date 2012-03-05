//
//  EditNoteViewController.m
//  PulseRate
//
//  Created by Aneesh on 25/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditNoteViewController.h"
#import "AppDelegate.h"
#import "Notes.h"
#import <QuartzCore/QuartzCore.h>
@implementation EditNoteViewController
@synthesize description;
@synthesize nameField;
@synthesize nameFieldstr,dateFieldstr,descriptionstr;

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
- (IBAction)updateRecord{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Notes" 
                                                  inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = 
    [NSPredicate predicateWithFormat:@"date = %@",dateFieldstr]; 
     //[[self dateFormatter] dateFromString:dateFieldstr]];
    [request setPredicate:pred];
  
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request 
                                              error:&error];
    NSLog(@"date str is %@  --objects count are %d",[[self dateFormatter] dateFromString:dateFieldstr],[objects count]); 
    if([objects count]>0){
       Notes *obj=[objects objectAtIndex:0];
        obj.name=nameField.text;
        obj.desc=description.text; 
       // obj.date=[[self dateFormatter] dateFromString:dateField.text]; 
    }
    NSError *localError;
    [context save:&localError]; 
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ContextSave" object:context];
    [self.navigationController popViewControllerAnimated:YES];
    
    //[NSThread detachNewThreadSelector:@selector(updateRecord:) toTarget:self withObject:nil];
    
}
- (IBAction)deleeRecord{
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Notes" 
                                                  inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = 
    [NSPredicate predicateWithFormat:@"date = %@",dateFieldstr]; 
    // [[self dateFormatter] dateFromString:dateFieldstr]];
    [request setPredicate:pred];
    NSLog(@"hey ");
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request 
                                              error:&error];
    NSLog(@"objects count are %d",[objects count]); 
    Notes *obj;
    if([objects count]>0){
        obj=[objects objectAtIndex:0];
    }
    [context deleteObject:obj];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ContextSave" object:context];
    [self.navigationController popViewControllerAnimated:YES];
    
    //[NSThread detachNewThreadSelector:@selector(deleeRecord:) toTarget:self withObject:nil];
    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    nameField.text=nameFieldstr;
    description.text=descriptionstr;
    self.title = @"Edit Notes";
     description.layer.cornerRadius = 12; 

}


- (NSDateFormatter *)dateFormatter {	
			NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss'Z'"];
	
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
   /* if(textField==dateField){
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
    */
	return YES;
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
