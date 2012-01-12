//
//  EnterUserDetailsViewController.m
//  PulseRate
//
//  Created by Aneesh on 09/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EnterUserDetailsViewController.h"
#import "AppDelegate.h"
#import "UserInfo.h"

@implementation EnterUserDetailsViewController
@synthesize age,weight,height;
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
-(IBAction)back:(id)sender{
[self dismissModalViewControllerAnimated:YES];
}
-(IBAction)done:(id)sender{
   /* AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    
    
    UserInfo *userInfo = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:context];
    
    userInfo.age =[age.text floatValue];
    userInfo.weight=[weight.text floatValue];
    userInfo.height=[height.text floatValue];
    NSError *error;
    if([context save:&error]){
       
        
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"Your Record Inserted successfully" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alertView show];
        
    }
    */
    
    
    [[NSUserDefaults standardUserDefaults] setValue:age.text forKey:@"age"];
    [[NSUserDefaults standardUserDefaults] setValue:weight.text forKey:@"weight"];
    [[NSUserDefaults standardUserDefaults] setValue:height.text forKey:@"height"];
    [self dismissModalViewControllerAnimated:YES];    
}


    

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    age.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"age"];
    weight.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"weight"];
    height.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"height"];
    self.title=@"User Setting";
    
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
