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
@synthesize lb1,lb2,lb3;
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
//    [textField resignFirstResponder];
//    return YES;
     if (textField==age ) {
        
        
        scView.frame = CGRectMake( scView.frame.origin.x,  scView.frame.origin.y-30, 
                                  scView.frame.size.width,  scView.frame.size.height);
         [weight becomeFirstResponder]; 
        return NO;
     }
    else if (textField==weight) {
        
        
        scView.frame = CGRectMake( scView.frame.origin.x,  scView.frame.origin.y-30, 
                                  scView.frame.size.width,  scView.frame.size.height); 
        [height becomeFirstResponder];
        return NO;
    }
    else{
        [textField resignFirstResponder];
        scView.frame = CGRectMake(0, 0, 
                                  320,231); 
        return YES;
      
        
    }

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
    
    UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 69, 30)];//[UIButton buttonWithType:101];//://101]; // left-pointing shape!
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    //backButton.imageView.image=[UIImage imageNamed:@"step-buttons.png"];
    [backButton setImage:[UIImage imageNamed:@"step-buttons.png"] forState:UIControlStateNormal];
   
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem=backItem;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem.image=[UIImage imageNamed:@"step-buttons.png"];
    lb1.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    lb2.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    lb3.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    
    
    lb1.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
    lb2.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
    lb3.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
    //self.view.backgroundColor=[UIColor grayColor];
    scView.backgroundColor=[UIColor clearColor];;
     
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
   }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
