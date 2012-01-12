//
//  CreateGraphcontroller.m
//  PulseRate
//
//  Created by Aneesh on 06/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateGraphcontroller.h"
#import "TUTViewController.h"

@implementation CreateGraphcontroller
@synthesize xaxis,yaxis,pcview;
@synthesize tUTViewController;
@synthesize graphtype;
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
    self.view.backgroundColor=[UIColor yellowColor];
    pcview.hidden=YES;
    graphtype.tag=3;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField==yaxis || textField==graphtype) {
        
        [pcview reloadAllComponents];
    pcview.hidden=NO;
    xaxis.hidden=YES;
    yaxis.hidden=YES;
    graphtype.hidden=YES;    
    tag=textField.tag;
    //[pcview selectRow:2 inComponent:0 animated:YES];    
  
    bar=[[UIToolbar alloc] initWithFrame:CGRectMake(110, 20, 211, 25)];
    [self.view addSubview:bar];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone  target:self action:@selector(setGraphAxis)];
    
    NSArray *myToolbarItems = [[NSArray alloc] initWithObjects: item, nil];                 
    bar.items=myToolbarItems;
    }
    return YES;

}
-(IBAction)done:(id)sender{
    NSLog(@"done pressed");
    [self dismissModalViewControllerAnimated:YES]; 
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


-(void)setGraphAxis{
    xaxis.hidden=NO;
    yaxis.hidden=NO;
    graphtype.hidden=NO;
    if (tag==3) {
        if(rownum==0){
            graphtype.text=@"Line Graph";
        }
        else if(rownum==1){
           graphtype.text=@"Histogram";      
        }
        else if(rownum==2){
            graphtype.text=@"Pie Chart";
        }
    }
    
    
    else{
        if(rownum==0){
            yaxis.text=@"Pulse";
        }
        else if(rownum==1){
            yaxis.text = @"Temprature";
        }
        else if(rownum==2){
            yaxis.text=@"Blood Pressure";
        }
        
        
    }
    NSLog(@"pppppp-----%d",tag);
    pcview.hidden=YES;
    [bar removeFromSuperview];

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    rownum=row;
    
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = 3;
    
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    NSLog(@"tag is ------%d",tag);
    if(tag==3){
        if(row==0){
            title=@"Line Graph";
        }
        else if(row==1){
            title = @"Histogram";
        }
        else if(row==2){
            title=@"Pie Chart";
        }

    
    
    }
    else{

       if(row==0){
        title=@"Pulse";
        }
       else if(row==1){
        title = @"Temprature";
        }
       else if(row==2){
        title=@"Blood Pressuere";
       }
    }
    return title;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"Graph"] )
    {   
       // if ([yaxis.text length]>0) {
            tUTViewController=[[TUTViewController alloc] init];
            tUTViewController =[segue destinationViewController];
            tUTViewController.xax=@"Blood Pressuere";
            tUTViewController.yax=yaxis.text;
           tUTViewController.graphtype=graphtype.text;
//        }
//        
//        
//        else{
//            UIAlertView *aview=[[UIAlertView alloc] initWithTitle:@"" message:@"Please fill all details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
//            [aview show];
//        }
    }
    
}


-(IBAction)show{
    
   // [self.navigationController pushViewController:tUTViewController animated:YES];
}

@end
