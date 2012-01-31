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
@synthesize age,weight,height,scView;
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


-(IBAction)back:(id)sender{
[self dismissModalViewControllerAnimated:YES];
}
-(IBAction)done:(id)sender{
   
    
    
    [[NSUserDefaults standardUserDefaults] setValue:age.text forKey:@"age"];
    [[NSUserDefaults standardUserDefaults] setValue:weight.text forKey:@"weight"];
    [[NSUserDefaults standardUserDefaults] setValue:height.text forKey:@"height"];
    [self dismissModalViewControllerAnimated:YES];    
}


    

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField { 
    if (textField==weight) {
        
        
        scView.frame = CGRectMake( scView.frame.origin.x,  scView.frame.origin.y-30, 
                                  scView.frame.size.width,  scView.frame.size.height); 
    }
    if (textField==height) {
        
        
        scView.frame = CGRectMake( scView.frame.origin.x,  scView.frame.origin.y-90, 
                                  scView.frame.size.width,  scView.frame.size.height); 
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField==weight) {
        scView.frame = CGRectMake(scView.frame.origin.x,  scView.frame.origin.y+30, 
                                  scView.frame.size.width,  scView.frame.size.height ); 
    }
    if (textField==height) {
        
        
        scView.frame = CGRectMake( scView.frame.origin.x,  scView.frame.origin.y+90, 
                                  scView.frame.size.width,  scView.frame.size.height); 
    }
    
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    age.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"age"];
    weight.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"weight"];
    height.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"height"];
    self.title=@"User Setting";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
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
