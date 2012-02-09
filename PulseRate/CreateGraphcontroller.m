//
//  CreateGraphcontroller.m
//  PulseRate
//
//  Created by Aneesh on 06/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateGraphcontroller.h"
#import "GraphViewController.h"

@implementation CreateGraphcontroller
@synthesize xaxis,yaxis,pcview;
@synthesize tUTViewController;
@synthesize graphtype;
@synthesize monthType,weakType,selectDate;
@synthesize lb1,lb2;
@synthesize arrow,arrow1,arrow2;
@synthesize monthView,dayView,weakView;
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




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
      arrrowSate=YES;
    arrrowSate1=YES;
    arrrowSate2=YES;
    pcview.hidden=YES;
    graphtype.tag=3;
    monthType.tag=4;
    weakType.tag=5;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    monthView.frame=CGRectMake(0, 216, 320, 0);
    weakView.frame=CGRectMake(0, 253, 356, 0);
    dayView.frame=CGRectMake(0, 296, 320, 0);
    monthView.hidden=YES;
    weakView.hidden=YES;
    dayView.hidden=YES;
    [self.view setBackgroundColor:[UIColor grayColor]];
    [monthView setBackgroundColor:[UIColor grayColor]];
    [weakView setBackgroundColor:[UIColor grayColor]];
    [dayView setBackgroundColor:[UIColor grayColor]];
    }
- (void)viewDidUnload
{
    [super viewDidUnload];
    
}
-(IBAction)arrowTapped:(UIButton *)sender{
   
    if(sender==arrow){
    
    if (arrrowSate==YES) {
      
        [arrow setImage:[UIImage imageNamed:@"carat-open.png"] forState:UIControlStateNormal];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:monthView cache:YES];
        monthView.hidden=NO;
       monthView.frame=CGRectMake(0, 216, 320,33);

        [UIView commitAnimations];
        
    }
    else{
    [arrow setImage:[UIImage imageNamed:@"carat.png"] forState:UIControlStateNormal];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:monthView cache:YES];
        
        monthView.frame=CGRectMake(0, 216, 320, 0);
        monthView.hidden=YES;
        [UIView commitAnimations];  
    }
    
     arrrowSate=!arrrowSate;
        
    }
    else if(sender==arrow1){
        
        
        if (arrrowSate1==YES) {
            
            [arrow1 setImage:[UIImage imageNamed:@"carat-open.png"] forState:UIControlStateNormal];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:weakView cache:YES];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:monthView cache:YES];
             weakView.hidden=NO;
             weakView.frame=CGRectMake(0, 253, 320, 35);
            monthView.hidden=NO;
            monthView.frame=CGRectMake(0, 216, 320, 33);
            [UIView commitAnimations];
            
        }
        else{
            [arrow1 setImage:[UIImage imageNamed:@"carat.png"] forState:UIControlStateNormal];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:weakView cache:YES];
             [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:monthView cache:YES];
            
            weakView.frame=CGRectMake(0, 253, 320,35);
            weakView.hidden=YES;
            monthView.hidden=YES;
            monthView.frame=CGRectMake(0, 216, 320, 0);
            [UIView commitAnimations];  
        }
        
        arrrowSate1=!arrrowSate1;
        

        
    }
    else{
        arrrowSate=NO;
        arrrowSate1=NO;
        monthView.hidden=YES;
        weakView.hidden=YES;
        [arrow setImage:[UIImage imageNamed:@"carat.png"] forState:UIControlStateNormal];
        [arrow1 setImage:[UIImage imageNamed:@"carat.png"] forState:UIControlStateNormal];
        if (arrrowSate2==YES) {
            
            [arrow2 setImage:[UIImage imageNamed:@"carat-open.png"] forState:UIControlStateNormal];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:dayView cache:YES];
            dayView.hidden=NO;
            dayView.frame=CGRectMake(0, 296, 320,36);
            
            [UIView commitAnimations];
            
        }
        else{
            [arrow2 setImage:[UIImage imageNamed:@"carat.png"] forState:UIControlStateNormal];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:dayView cache:YES];
            
            dayView.frame=CGRectMake(0, 296, 320,36);
            dayView.hidden=YES;
            [UIView commitAnimations];  
        }
        
        arrrowSate2=!arrrowSate2;
        

    
    }
}
 /*
 *-----------------------------------------------------------------------------
 *
 * UITExtFiled delegate  Methods   *
 *-----------------------------------------------------------------------------
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"row number is %d",rownum);
    tag=textField.tag;
    [textField resignFirstResponder];
    // rownum=0;
    [pcview reloadAllComponents];
    
   
    if (textField==selectDate) {
        lb1.hidden=YES;
        lb2.hidden=YES;
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, 325, 250)];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.hidden = NO;
        datePicker.date = [NSDate date];
        [datePicker addTarget:self
                       action:nil
             forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:datePicker];
         
        
        bar2=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 225, 325, 25)];
      
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone  target:self action:@selector(setDate:)];
        
        NSArray *myToolbarItems = [[NSArray alloc] initWithObjects: item, nil];                 
        bar2.items=myToolbarItems;
        
        [self.view addSubview:bar2];
        monthType.text=@"";
        weakType.text=@"";
        
        return NO;
       
        
    }
    else{
    [pcview reloadAllComponents];
    pcview.hidden=NO;
    xaxis.hidden=YES;
    yaxis.hidden=YES;
    graphtype.hidden=YES;
    monthType.hidden=YES;
    weakType.hidden=YES;
    lb1.hidden=YES;
    lb2.hidden=YES;    
   
  
    bar=[[UIToolbar alloc] initWithFrame:CGRectMake(114, 20, 211, 25)];
    [self.view addSubview:bar];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone  target:self action:@selector(setGraphAxis)];
    
    NSArray *myToolbarItems = [[NSArray alloc] initWithObjects: item, nil];                 
    bar.items=myToolbarItems;
   
    return NO;
    }
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
    monthType.hidden=NO;
    weakType.hidden=NO;
    lb1.hidden=NO;
    lb2.hidden=NO;
     if (tag==3) {

        if(rownum==0){
            graphtype.text=@"Line Graph";
        }
        else if(rownum==1){
           graphtype.text=@"Histogram";      
        }
       
    }
    
    else if(tag ==4){
       
        monthType.text=[montharray objectAtIndex:rownum];
    }
    else if (tag==5) {
    
        weakType.text=[weakArray objectAtIndex:rownum];
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
   
    pcview.hidden=YES;
    [bar removeFromSuperview];

}
/*
 *-----------------------------------------------------------------------------
 *
 *IBAction  Methods   *
 *-----------------------------------------------------------------------------
 */
-(IBAction)setDate:(id)sender{
    lb1.hidden=NO;
    lb2.hidden=NO;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss ZZZ"];
    NSString *dateString=[dateFormatter stringFromDate:[datePicker date]];
    [selectDate setText:dateString];
    [bar2 removeFromSuperview];
    [datePicker removeFromSuperview];
}


-(IBAction)done:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES]; 
}




/*
 *-----------------------------------------------------------------------------
 *
 * Picker delegate and datasource Methods   *
 *-----------------------------------------------------------------------------
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    rownum=row;
    
}
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = 3;
    if (tag==4) {
        numRows=12;
    }
    else if(tag==5){
        numRows=6;
    }
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
   
    montharray =[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Aprail",@"may",@"jun",@"july",@"august",@"sep",@"oct",@"nov",@"dec", nil];
    weakArray  =[NSArray arrayWithObjects:@"First",@"Second",@"Third",@"Fourth",@"Fifth",@"Whole Month" ,nil];
     if(tag==3){
        if(row==0){
            title=@"Line Graph";
        }
        else if(row==1){
            title = @"Histogram";
        }
    }
    
     else if(tag==4){
     title=[montharray objectAtIndex:row];
      }
    
     else if(tag==5){
     title=[weakArray objectAtIndex:row];
 
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
      
            tUTViewController=[[GraphViewController alloc] init];
            tUTViewController =[segue destinationViewController];
            tUTViewController.xax=@"Blood Pressuere";
            tUTViewController.yax=yaxis.text;
            tUTViewController.graphtype=graphtype.text;
            tUTViewController.monthnum=[montharray indexOfObject:monthType.text]+1;
            if ([weakType.text length]>0) {
             tUTViewController.weaknum=[weakArray indexOfObject:weakType.text]+1;
             }
            else{
                tUTViewController.weaknum=6;
            }
            tUTViewController.dateString=selectDate.text;

            if ([selectDate.text length]>0) {
            tUTViewController.isDayWiseReporting=YES;
           }
    }
    
}


@end
