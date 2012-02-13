//
//  RecordsViewController.m
//  PulseRate
//
//  Created by Aneesh on 31/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecordsViewController.h"
#import "AppDelegate.h"
#import "PulseRecord.h"
#import <QuartzCore/QuartzCore.h>
#import <ViewRecordController.h>
@implementation RecordsViewController
@synthesize sc,uv;
@synthesize leftArrow,rightArrow,vc;
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
    
    
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 420, 45)];
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:5];
    UIBarButtonItem *backButton =  [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered  target:self action:@selector(done:)];
    UIBarButtonItem *monthrecords = [[UIBarButtonItem alloc] initWithTitle:@"Monthly" style:UIBarButtonItemStyleBordered target:self action:@selector(monthWiseListing:)];
    UIBarButtonItem *weakrecords = [[UIBarButtonItem alloc] initWithTitle:@"Weakly" style:UIBarButtonItemStyleBordered target:self action:@selector(weakWiseListing:)];
    UIBarButtonItem *dayReords = [[UIBarButtonItem alloc] initWithTitle:@"Daily" style:UIBarButtonItemStyleBordered  target:self action:@selector(dateListing:)];//(dayWiseListing:)];
    UIBarButtonItem *allReords = [[UIBarButtonItem alloc] initWithTitle:@"All" style:UIBarButtonItemStyleBordered  target:self action:@selector(showAllRecords)];
    
    [buttons addObject:backButton];
    [buttons addObject:monthrecords];
    [buttons addObject:weakrecords];
    [buttons addObject:dayReords];
    [buttons addObject:allReords];
    
    [toolbar setItems:buttons animated:NO];
    
    [self.view addSubview:toolbar];
    montharray =[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Aprail",@"may",@"jun",@"july",@"august",@"sep",@"oct",@"nov",@"dec", nil];
    weakarray=[NSArray arrayWithObjects:@"First",@"Second",@"Third",@"Fourth",@"Fifth",nil];
    uv.backgroundColor=[UIColor clearColor];
    leftArrow.hidden=YES;
    vc= [self.storyboard instantiateViewControllerWithIdentifier:@"ViewRecordController"];
    vc.view.frame=CGRectMake(0, 45, 320, 470);
    [self.view addSubview:vc.view];
    
}
-(void)showAllRecords{
    NSArray *buttons=[toolbar items];
    int i;
    for (i=0; i<[buttons count]; i++) {
        UIBarButtonItem *bt=[buttons objectAtIndex:i];
        if (i==4) {
            bt.enabled=NO;
        }
        else{
            bt.enabled=YES;
        }
        
    }
    
    vc.view.frame=CGRectMake(0, 45, 320, 470);
    [self.view addSubview:vc.view];
}
-(void)layOutScroll:(NSArray *)recordsArray{
    
    for (UIView *subView in [sc subviews]) {
        [subView removeFromSuperview];
    }
    
    
    int i;
    for (i=0; i<[recordsArray count]; i++) {
        PulseRecord *pulseRecord=[recordsArray objectAtIndex:i];
        UIView  *uv1;  
        UIView  *uv2;      
        if (i==0) {
            uv2=[[UIView alloc]  initWithFrame:CGRectMake(0,0, 267, 190)];    
            uv1=[[UIView alloc]  initWithFrame:CGRectMake(0,0, 257, 190)];
        }
        else{
            uv1=[[UIView alloc]  initWithFrame:CGRectMake(10,0, 257, 190)];
            uv2=[[UIView alloc]  initWithFrame:CGRectMake(i*(267),0, 267, 190)]; 
        }
        uv1.layer.cornerRadius = 12;    
        [uv2 addSubview:uv1]; 
        
        UILabel *lb1=[[UILabel alloc] initWithFrame:CGRectMake(10,10, 140, 40)];
        UILabel *lb2=[[UILabel alloc] initWithFrame:CGRectMake(10,50, 140, 40)];
        UILabel *lb3=[[UILabel alloc] initWithFrame:CGRectMake(10,90, 150, 40)]; 
        [uv1 addSubview:lb1]; 
        [uv1 addSubview:lb2]; 
        [uv1 addSubview:lb3];
        lb1.text=@"Pulse";
        lb2.text=@"Temprature";
        lb3.text=@"Blood Pressure";
        
        UILabel *lb11=[[UILabel alloc] initWithFrame:CGRectMake(140, 10, 110, 40)];
        UILabel *lb12=[[UILabel alloc] initWithFrame:CGRectMake(140, 50, 110, 40)];
        UILabel *lb13=[[UILabel alloc] initWithFrame:CGRectMake(140, 90, 110, 40)]; 
        UILabel *lb14=[[UILabel alloc] initWithFrame:CGRectMake(40, 140, 200, 30)];     
        [uv1 addSubview:lb11]; 
        [uv1 addSubview:lb12]; 
        [uv1 addSubview:lb13];
        [uv1 addSubview:lb14];    
        lb11.text=[NSString stringWithFormat:@"%d BPM",[[pulseRecord valueForKey:@"pulse"] intValue]];;
        lb12.text=[NSString stringWithFormat:@"%.02f °F ",[[pulseRecord valueForKey:@"temprature"] floatValue]];
        lb13.text=[NSString stringWithFormat:@"%.02f mmHg",[[pulseRecord valueForKey:@"bloodPresssure"] floatValue]];  
        lb14.text=[[NSString stringWithString:(NSString *)[pulseRecord valueForKey:@"entrytime"]] substringToIndex:19];     
        uv1.tag=i+1;
        
        [sc addSubview:uv2];
        [uv1 setBackgroundColor:[UIColor grayColor]]; 
        [lb1 setBackgroundColor:[UIColor grayColor]]; 
        [lb2 setBackgroundColor:[UIColor grayColor]]; 
        [lb3 setBackgroundColor:[UIColor grayColor]];     
        [lb11 setBackgroundColor:[UIColor grayColor]]; 
        [lb12 setBackgroundColor:[UIColor grayColor]]; 
        [lb13 setBackgroundColor:[UIColor grayColor]];
        [lb14 setBackgroundColor:[UIColor grayColor]];    
    } 
    [sc setContentSize:CGSizeMake(([recordsArray count])*(267), 190)];
    sc.pagingEnabled=YES;
    //sc.frame=CGRectMake(25, 170, 267, 286);
    
}

/*
 *-----------------------------------------------------------------------------
 *
 * IBAction Methods  
 *
 *-----------------------------------------------------------------------------
 */

/*
 *-----------------------------------------------------------------------------
 *
 *  Handling monthwise reporting  
 *
 *-----------------------------------------------------------------------------
 */

-(IBAction)showmonthresult:(id)sender{
    [vc.view removeFromSuperview];
    int num=[montharray indexOfObject:tF.text];
    NSLog(@"month is%d",(num+1));
    NSString *predicatStr;
    if (num<=8) {
        predicatStr=[NSString stringWithFormat:@"????-0%d-*",(num+1)];
    }
    else{
        predicatStr=[NSString stringWithFormat:@"????-%d-*",num];
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"PulseRecord" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSLog(@"predicate is %@",predicatStr);
    NSPredicate *myPred=[NSPredicate predicateWithFormat:@"entrytime like %@",predicatStr];
    request.predicate=myPred;  
    NSError *error;
    NSArray *recordsArray = [context executeFetchRequest:request error:&error]; 
    totalRecords=[recordsArray count];
    if ([recordsArray count]==0) {
        UIAlertView *alt=[[UIAlertView alloc] initWithTitle:@"No Result Found" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alt show];
        NSLog(@"no result month found");
        rightArrow.hidden=YES; 
        leftArrow.hidden=YES;
    }
    else{
        rightArrow.hidden=NO; 
        leftArrow.hidden=NO;
        if ([recordsArray count]==1) {
            rightArrow.hidden=YES;
            leftArrow.hidden=YES;
        }
    }
    [self layOutScroll:recordsArray];
    
    
    
    
}


-(IBAction)monthWiseListing:(id)sender{
    NSArray *buttons=[toolbar items];
    int i;
    for (i=0; i<[buttons count]; i++) {
        UIBarButtonItem *bt=[buttons objectAtIndex:i];
        if (i==1) {
            bt.enabled=NO;
        }
        else{
            bt.enabled=YES;
        }
        
    }
    [vc.view removeFromSuperview];
    for (UIView *subView in  [uv subviews]) {
        [subView removeFromSuperview];
    }  
    UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(40,45,100,40)]; 
    lb.text=@"Select Month";
    lb.backgroundColor=[UIColor clearColor];
    tF=[[UITextField alloc] initWithFrame:CGRectMake(150, 50, 100, 30)];
    tF.borderStyle=UITextBorderStyleRoundedRect;
    tF.delegate=self;
    [uv addSubview:lb];
    [uv addSubview:tF];
    
    UIButton *bt=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    bt.frame=CGRectMake(65, 95, 140, 40);
    [bt setTitle:@"Show Results" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(showmonthresult:) forControlEvents:UIControlEventTouchUpInside];
    [bt setBackgroundColor:[UIColor clearColor]];
    [sc setBackgroundColor:[UIColor whiteColor]];
    [uv addSubview:bt];
    rightArrow.hidden=YES; 
    leftArrow.hidden=YES;  
    
    
    
    
}

/*
 *-----------------------------------------------------------------------------
 *
 *  Handling weakwise reporting  
 *
 *-----------------------------------------------------------------------------
 */

-(IBAction)weakWiseListing:(id)sender{
    
    NSArray *buttons=[toolbar items];
    int i;
    for (i=0; i<[buttons count]; i++) {
        UIBarButtonItem *bt=[buttons objectAtIndex:i];
        if (i==2) {
            bt.enabled=NO;
        }
        else{
            bt.enabled=YES;
        }
        
    }
    
    [vc.view removeFromSuperview];
    for (UIView *subView in  [uv subviews]) {
        [subView removeFromSuperview];
    }    
    
    for(i=0;i< [[uv subviews]count];i++){
        UIView *sbView=[[uv subviews] objectAtIndex:i];
        [sbView removeFromSuperview];
    }
    UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(20,45,100,40)]; 
    lb.text=@"Select Month";
    
    UILabel *lb2=[[UILabel alloc] initWithFrame:CGRectMake(20,85,100,40)]; 
    lb2.text=@"Select Weak";
    [lb setBackgroundColor:[UIColor clearColor]];
    [lb2 setBackgroundColor:[UIColor clearColor]];
    
    UIButton *bt=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    bt.frame=CGRectMake(70, 128, 140, 35);
    [bt setTitle:@"Show Results" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(showweakresult:) forControlEvents:UIControlEventTouchUpInside];
    [bt setBackgroundColor:[UIColor clearColor]];
    weakField=[[UITextField alloc] initWithFrame:CGRectMake(140, 90, 100, 30)];
    weakField.borderStyle=UITextBorderStyleRoundedRect;
    tF=[[UITextField alloc] initWithFrame:CGRectMake(140, 52, 100, 30)];
    tF.borderStyle=UITextBorderStyleRoundedRect;
    
    tF.delegate=self;
    weakField.delegate=self;
    [uv addSubview:lb];
    [uv addSubview:lb2];
    [uv addSubview:tF];
    [uv addSubview:weakField];
    [uv addSubview:bt];
    rightArrow.hidden=YES; 
    leftArrow.hidden=YES; 
    
    
}
-(IBAction)showweakresult:(id)sender{
    [vc.view removeFromSuperview];
    int num=[montharray indexOfObject:tF.text];
    int weaknum=[weakarray indexOfObject:weakField.text]+1;
    NSString *predicatStr;
    if (num<=8) {
        predicatStr=[NSString stringWithFormat:@"-0%d-",(num+1)];
    }
    else{
        predicatStr=[NSString stringWithFormat:@"-%d-",num];
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"PulseRecord" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *myPred=[NSPredicate predicateWithFormat:@"entrytime CONTAINS[cd] %@",predicatStr];
    request.predicate=myPred;  
    NSError *error;
    NSArray *recordsArray = [context executeFetchRequest:request error:&error]; 
    totalRecords=[recordsArray count];
    NSMutableArray *resultsArray = [[NSMutableArray alloc] init]; 
    
    //NSLog(@"weak number is %d  and toatalrecords--%d",weaknum,[recordsArray count]);
    for (PulseRecord *rc in recordsArray) {
        NSArray *dateArray=[rc.entrytime componentsSeparatedByString:@"-"];
        int date=[[dateArray objectAtIndex:2]intValue];
        if (date>(weaknum-1)*7 && date <=weaknum*7) {
            [resultsArray addObject:rc];
        }
        
    }
    if ([resultsArray count]==0) {
        rightArrow.hidden=YES; 
        leftArrow.hidden=YES;
        UIAlertView *alt=[[UIAlertView alloc] initWithTitle:@"No Result Found" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alt show];
        
    }
    else{
        rightArrow.hidden=NO; 
        leftArrow.hidden=NO;
        if ([recordsArray count]==1) {
            rightArrow.hidden=YES;
            leftArrow.hidden=YES;
        }
    }
    totalRecords=[resultsArray count];
    [self layOutScroll:resultsArray];
    
    
}

/*
 *-----------------------------------------------------------------------------
 *
 * Handling datewise reporting  
 *
 *-----------------------------------------------------------------------------
 */

-(IBAction)showresultforDate:(id)sender{
    [vc.view removeFromSuperview];
    int num=[montharray indexOfObject:tF.text];
   // NSLog(@"month is%d",(num+1));
    NSString *predicatStr;
    
    predicatStr=[NSString stringWithFormat:@"%@*",[dateField.text substringToIndex:10]];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"PulseRecord" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSLog(@"predicate is %@",predicatStr);
    NSPredicate *myPred=[NSPredicate predicateWithFormat:@"entrytime like %@",predicatStr];
    request.predicate=myPred;  
    NSError *error;
    NSArray *recordsArray = [context executeFetchRequest:request error:&error]; 
    totalRecords=[recordsArray count];
    if ([recordsArray count]==0) {
        UIAlertView *alt=[[UIAlertView alloc] initWithTitle:@"No Result Found" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alt show];
      //  NSLog(@"no result found");
        rightArrow.hidden=YES; 
        leftArrow.hidden=YES;
    }
    else{
        
        
        rightArrow.hidden=NO; 
        leftArrow.hidden=NO;
        if ([recordsArray count]==1) {
            rightArrow.hidden=YES;
            leftArrow.hidden=YES;
        }
        
    }
    [self layOutScroll:recordsArray];
}

-(IBAction)dateListing:(id)sender{
    NSLog(@"date listing");
    NSArray *buttons=[toolbar items];
    int i;
    for (i=0; i<[buttons count]; i++) {
        UIBarButtonItem *bt=[buttons objectAtIndex:i];
        if (i==3) {
            bt.enabled=NO;
        }
        else{
            bt.enabled=YES;
        }
        
    }
    
    [vc.view removeFromSuperview];
    for (UIView *subView in  [uv subviews]) {
        [subView removeFromSuperview];
    }
    UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(30,45,100,40)]; 
    lb.text=@"Select Date";
    lb.backgroundColor=[UIColor clearColor];
    dateField=[[UITextField alloc] initWithFrame:CGRectMake(140, 50, 120, 30)];
    dateField.borderStyle=UITextBorderStyleRoundedRect;
    dateField.delegate=self;
    [uv addSubview:lb];
    [uv addSubview:dateField];
    
    UIButton *bt=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    bt.frame=CGRectMake(60, 95, 140, 40);
    [bt setTitle:@"Show Results" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(showresultforDate:) forControlEvents:UIControlEventTouchUpInside];
    [bt setBackgroundColor:[UIColor clearColor]];
    [sc setBackgroundColor:[UIColor whiteColor]];
    [uv addSubview:bt];
    rightArrow.hidden=YES; 
    leftArrow.hidden=YES;  
    
    
}
-(IBAction)showdateresult:(id)sender{
    [vc.view removeFromSuperview];
    int num=[montharray indexOfObject:tF.text];
    NSString *predicatStr;
    if (num<=8) {
        predicatStr=[NSString stringWithFormat:@"????-0%d-*",(num+1)];
    }
    else{
        predicatStr=[NSString stringWithFormat:@"????-%d-*",num];
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"PulseRecord" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
   // NSLog(@"predicate is %@",predicatStr);
    NSPredicate *myPred=[NSPredicate predicateWithFormat:@"entrytime like %@",predicatStr];
    request.predicate=myPred;  
    NSError *error;
    NSArray *recordsArray = [context executeFetchRequest:request error:&error]; 
    totalRecords=[recordsArray count];
    if ([recordsArray count]==0) {
        UIAlertView *alt=[[UIAlertView alloc] initWithTitle:@"No Result Found" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alt show];
        //NSLog(@"no result found");
        rightArrow.hidden=YES; 
        leftArrow.hidden=YES;
    }
    else{
        rightArrow.hidden=NO; 
        leftArrow.hidden=NO;
    }
    [self layOutScroll:recordsArray];
}


-(IBAction)done:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
}

/*
 *-----------------------------------------------------------------------------
 *
 * UITextField Delegate  Methods  
 *
 *-----------------------------------------------------------------------------
 */

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    sc.userInteractionEnabled=NO;;
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    tag=0;
    pcView=[[UIPickerView alloc] initWithFrame:CGRectMake(0, 480, 320,40)];
    pcView.showsSelectionIndicator=YES;
    pcView.delegate=self;
    pcView.dataSource=self;
    bar2.frame = CGRectMake(0, 454, 320,26);
    [self.view addSubview:bar2];
    if (textField==weakField) {
        pcView.tag=2;
        [self.view addSubview:pcView];
        //
       // [self.view addSubview:bar1];
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        pcView.frame = CGRectMake(0, 296, 320,40); 
        bar2.frame = CGRectMake(0, 276, 320,26);
        [UIView commitAnimations];
        
        
    }
    else if(textField==dateField){
        pcView.tag=3;
        dateField.userInteractionEnabled=NO;
        
        
        dpc=[[UIDatePicker alloc] initWithFrame:CGRectMake(0,480,320 , 26)];
        [self.view addSubview:dpc];
        dpc.datePickerMode=UIDatePickerModeDate;
        bar1=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 454, 320,26)];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone  target:self action:@selector(setDateFiled)];
        NSArray *myToolbarItems = [[NSArray alloc] initWithObjects: item, nil];                 
        bar1.items=myToolbarItems;
        
        [self.view addSubview:bar1];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        dpc.frame = CGRectMake(0,300,320 , 120); 
        bar1.frame = CGRectMake(0, 274, 320,26);
        [UIView commitAnimations];
        
        
        
        
    }
    else{
        pcView.tag=1;
        [pcView reloadAllComponents];
        bar2=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 454, 320,26)];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone  target:self action:@selector(setDate:)];
        NSArray *myToolbarItems = [[NSArray alloc] initWithObjects: item, nil];                 
        bar2.items=myToolbarItems;
        [self.view addSubview:pcView];  
        [self.view addSubview:bar2];  
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        pcView.frame = CGRectMake(0, 296, 320,40); 
        bar2.frame = CGRectMake(0, 276, 320,26);
        [UIView commitAnimations];

    }
    
    
    [pcView reloadAllComponents];
    [uv reloadInputViews];
        
    
    return NO;
}
-(void)setDateFiled{
    dateField.userInteractionEnabled=YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss ZZZ"];
    NSString *dateString=[dateFormatter stringFromDate:[dpc date]];
    [dateField setText:dateString];
    [dpc removeFromSuperview];
    [bar1 removeFromSuperview];
}
-(IBAction)setDate:(id)sender{
    if (pcView.tag==1) {
        [tF setText:[montharray objectAtIndex:tag]];
    }
    else if(pcView.tag==2){
        [weakField setText:[weakarray objectAtIndex:tag]];
    }
    sc.userInteractionEnabled=YES;
    pcView.frame = CGRectMake(0, 296, 320,40); 
    bar2.frame = CGRectMake(0, 276, 320,26);
    
    [bar2 removeFromSuperview];
    [pcView removeFromSuperview];
    
    
}
/*
 *-----------------------------------------------------------------------------
 *
 * UIScrollView Delegate  Methods  
 *
 *-----------------------------------------------------------------------------
 */



-(IBAction)scrollMeForeward:(id)sender{
    
    CGPoint pt=[sc contentOffset];
    pt.x=pt.x+267;
    [sc setContentOffset:pt animated:YES];
    if ([sc contentOffset].x==0) {
        leftArrow.hidden=YES;
    }
    if ([sc contentOffset].x==(totalRecords-1)*267) {
        rightArrow.hidden=YES;
    }
    [leftArrow setUserInteractionEnabled:NO];
    [rightArrow setUserInteractionEnabled:NO];
    
}

-(IBAction)scrollMeBackward:(id)sender{
    
    CGPoint pt=[sc contentOffset];
    pt.x=pt.x-267;
    [sc setContentOffset:pt animated:YES];
    if ([sc contentOffset].x==0) {
        leftArrow.hidden=YES;
    }
    else{
        leftArrow.hidden=NO;
    }
    NSLog(@"sc content offset is %f",[sc contentOffset].x);
    if ([sc contentOffset].x==(totalRecords-1)*267) {
        rightArrow.hidden=YES;
    }
    else{
        rightArrow.hidden=NO;
    }
    [leftArrow setUserInteractionEnabled:NO];
    [rightArrow setUserInteractionEnabled:NO];
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([sc contentOffset].x==0) {
        leftArrow.hidden=YES;
    }
    else{
        leftArrow.hidden=NO;
    }
    
    if ([sc contentOffset].x==(totalRecords-1)*267) {
        rightArrow.hidden=YES;
    }
    else{
        rightArrow.hidden=NO;
    }
    //NSLog(@"content offset is %f",[sc contentOffset].x);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [leftArrow setUserInteractionEnabled:YES];
    [rightArrow setUserInteractionEnabled:YES];
}

/*
 *-----------------------------------------------------------------------------
 *
 * UIPickerView Delegate  Methods  
 *
 *-----------------------------------------------------------------------------
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    tag=row;
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pcView.tag==2){
        return [weakarray count];
    }
    else{
        return [montharray count];
    }    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(pcView.tag==1){
        return [montharray objectAtIndex:row];
    }
    else{
        return [weakarray objectAtIndex:row];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
