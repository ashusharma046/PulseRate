//
//  TUTViewController.m
//  Core Plot Introduction
//
//  Created by John Wordsworth on 20/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"
#import "AppDelegate.h"
#import "PulseRecord.h"
@implementation GraphViewController
@synthesize scatterPlot = _scatterPlot;
@synthesize xax,yax;
@synthesize lb1,lb2,lb3,lb4;
@synthesize vw1,vw2,vw3,vw4;
@synthesize graphtype;
@synthesize monthnum;
@synthesize weaknum;
@synthesize dateString;
@synthesize isDayWiseReporting;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Graph";

    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 360, 37)];
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:5];
    UIBarButtonItem *backButton =  [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    UIBarButtonItem *emptLb=[[UIBarButtonItem alloc] initWithTitle:@"                             " style:UIBarButtonItemStylePlain target:self action:nil]; 
    emptLb.enabled=NO;
    UIBarButtonItem *dayReords = [[UIBarButtonItem alloc] initWithTitle:@"Email Pdf" style:UIBarButtonItemStyleBordered target:self action:@selector(drawPdf)];
    
   [buttons addObject:backButton];
   [buttons addObject:emptLb];
   [buttons addObject:dayReords];
  
   [toolbar setItems:buttons animated:NO];
   [self.view addSubview:toolbar];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"PulseRecord" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    data=[[NSMutableArray alloc] init];
    [request setEntity:entityDesc];
    
    NSError *error;
    NSString *predicatestr;
    if (monthnum <10) {
       // predicatestr=[NSString stringWithFormat:@"-0%d-",monthnum];
        predicatestr=[NSString stringWithFormat:@"????-0%d-*",monthnum];
        NSLog(@"pster is --%@",predicatestr);
    }
    else{
        //predicatestr=[NSString stringWithFormat:@"-%d-",monthnum];
        predicatestr=[NSString stringWithFormat:@"????-0%d-*",monthnum];
    }
    
    
    
    NSPredicate *myPred;
    if(!isDayWiseReporting){
        myPred=[NSPredicate predicateWithFormat:@"entrytime like %@",predicatestr];
        request.predicate=myPred;    
        recordsArray = [context executeFetchRequest:request error:&error];   
        NSLog(@"  number ----");
    }
    
    else{
        myPred=[NSPredicate predicateWithFormat:@"entrytime CONTAINS[cd] %@",[dateString substringToIndex:10]];
        request.predicate=myPred;    
        recordsArray = [context executeFetchRequest:request error:&error];
        [self setDatatForDayWiseReporting];
        NSLog(@"  number of records are %d",[recordsArray count]);
        NSLog(@" entrytime CONTAINS[cd] %@",[dateString substringToIndex:10]);
        
    }
    
    
    
    
    
    if ([recordsArray count] == 0) {
        UIAlertView *al=[[UIAlertView alloc] initWithTitle:nil message:@"No Record Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    } 
    
    else {
        
        if(!isDayWiseReporting){
            
            if (weaknum ==6) {
                
                //set backgorund
                if([yax isEqualToString:@"Pulse"]){
                    [self plotpulseBackground];
                }
                else if([yax isEqualToString:@"Temprature"]) {
                    [self plotTempratureBackground];
                }  
                
                
                /// Data for monthly graphical report           
                int i;
                for(i=0;i < [recordsArray count];i++){
                    
                    PulseRecord *pulseRecord=(PulseRecord *)[recordsArray objectAtIndex:i];  
                    NSArray *datecomps =[pulseRecord.entrytime componentsSeparatedByString:@"-"];
                    NSInteger k= [[datecomps objectAtIndex:2] intValue];
                    NSLog(@"k is %d",k);
                    if([yax isEqualToString:@"Blood Pressure"])
                    {
                        [data addObject:[NSValue valueWithCGPoint:CGPointMake([[NSDecimalNumber numberWithFloat:k*1.15] floatValue], pulseRecord.bloodPresssure)]];
                        
                    }
                    if([yax isEqualToString:@"Pulse"]){
                        [data addObject:[NSValue valueWithCGPoint:CGPointMake([[NSDecimalNumber numberWithFloat:k*1.15] floatValue], pulseRecord.pulse)]];
                        
                        
                    }
                    if([yax isEqualToString:@"Temprature"]){
                        [data addObject:[NSValue valueWithCGPoint:CGPointMake([[NSDecimalNumber numberWithFloat:k*1.15] floatValue], (pulseRecord.temprature-94)*2.50)]];
                        NSLog(@"y avlue is-------%f",(pulseRecord.temprature-94)*2.50) ;
                    }
                    
                }
            }          
            
            
            
            else{
                int i;
                //set backgorund
                if([yax isEqualToString:@"Pulse"]){
                    [self plotpulseBackground];
                }
                else if([yax isEqualToString:@"Temprature"]) {
                    [self plotTempratureBackground];
                }  
                
                /// Data for weakly graphical report   
                for(i=0;i < [recordsArray count];i++){
                    
                    PulseRecord *pulseRecord=(PulseRecord *)[recordsArray objectAtIndex:i];  
                    NSArray *datecomps =[pulseRecord.entrytime componentsSeparatedByString:@"-"];
                    int date =[[datecomps objectAtIndex:2]intValue];
                    int k=date-(weaknum-1)*7;
                    
                    if(date>=((weaknum-1)*7+1) && date<=(weaknum*7) ){
                        if([yax isEqualToString:@"Blood Pressure"])
                        {
                            [data addObject:[NSValue valueWithCGPoint:CGPointMake([[NSDecimalNumber numberWithInt:4*k] floatValue], pulseRecord.bloodPresssure)]];
                        }
                        if([yax isEqualToString:@"Pulse"]){
                            [data addObject:[NSValue valueWithCGPoint:CGPointMake([[NSDecimalNumber numberWithInt:4*k] floatValue], pulseRecord.pulse)]];
                            
                            
                        }
                        if([yax isEqualToString:@"Temprature"]){
                            [data addObject:[NSValue valueWithCGPoint:CGPointMake([[NSDecimalNumber numberWithInt:4*k] floatValue], (pulseRecord.temprature-94)*2.50)]];
                        }
                        
                    }
                }
                
            }       
            
            
        }    
        
        
        
        
        self.scatterPlot= [[CustomPlot alloc] initWithHostingView:_graphHostingView andData:data andXax:xax andYax :yax andGraphtype:self.graphtype];
        ///self.scatterPlot.delegate=self;
        self.scatterPlot.xax=xax;
        self.scatterPlot.yax=yax;
        
        if(weaknum <6){
            self.scatterPlot.graphPeriod=1;
            
        }
        if (isDayWiseReporting) {
            self.scatterPlot.graphPeriod=3;
            self.scatterPlot.timeStamparray=timeStampArray;
            
        }
        [self.scatterPlot initialisePlot];
        
        
        
        
    }
  
    self.view.backgroundColor=[UIColor colorWithRed:(211.0/255.0) green:(211.0/255) blue:(211.0/255) alpha:1.0];
    vw1.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(239.0/255) blue:(213.0/255) alpha:1.0];
    lb1.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(239.0/255) blue:(213.0/255) alpha:1.0]; 
    
    vw2.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(255.0/255) blue:(240.0/255) alpha:1.0];
    lb2.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(255.0/255) blue:(240.0/255) alpha:1.0]; 
    
    vw3.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(228.0/255) blue:(225.0/255) alpha:1.0];
    lb4.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(228.0/255) blue:(225.0/255) alpha:1.0]; 
    
    vw4.backgroundColor=[UIColor colorWithRed:(238.0/255.0) green:(238.0/255) blue:(224.0/255) alpha:1.0];
    lb3.backgroundColor=[UIColor colorWithRed:(235.0/255.0) green:(238.0/255) blue:(224.0/255) alpha:1.0]; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}



- (void)setDatatForDayWiseReporting
{       
    //set   background 
    if([yax isEqualToString:@"Pulse"]){
        [self plotpulseBackground];    
    }
    if([yax isEqualToString:@"Temprature"]){
        
        [self plotTempratureBackground];
    }
    
    //data for plotting graph
    timeStampArray=[[NSMutableArray alloc] init]; 
    int i;
    for(i=0;i < [recordsArray count];i++){
        PulseRecord *pulseRecord=(PulseRecord *)[recordsArray objectAtIndex:i];  
        NSArray *datecomps =[pulseRecord.entrytime componentsSeparatedByString:@"-"];    
        NSString *timestamp =[datecomps objectAtIndex:3];
        [timeStampArray addObject:timestamp];    
        
        [timeStampArray addObject:timestamp];        
        if([yax isEqualToString:@"Blood Pressure"])
        {
            [data addObject:[NSValue valueWithCGPoint:CGPointMake([[NSDecimalNumber numberWithInt:(4*(i+1))] floatValue], pulseRecord.bloodPresssure)]];
        }
        if([yax isEqualToString:@"Pulse"]){
            [data addObject:[NSValue valueWithCGPoint:CGPointMake([[NSDecimalNumber numberWithInt:(4*(i+1))] floatValue], pulseRecord.pulse)]];
            
            
        }
        if([yax isEqualToString:@"Temprature"]){
            [data addObject:[NSValue valueWithCGPoint:CGPointMake([[NSDecimalNumber numberWithInt:(4*(i+1))] floatValue], (pulseRecord.temprature-94)*2.50)]];
            
        }
        [self drawPdf];    
        
        
    }
    
}
-(void)drawPdf{
    toolbar.hidden=YES;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * pdfFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithString:@"Report.pdf"]];    UIGraphicsBeginPDFContextToFile(pdfFilePath, CGRectZero, nil);
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    UIGraphicsBeginPDFPageWithInfo([[UIScreen mainScreen] bounds], nil);	
    [self.view.layer renderInContext:context1];
    UIGraphicsEndPDFContext();
    [self mailReport];
    toolbar.hidden=NO;
   
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:pdfFilePath];
    if (fileExists) {
       [self mailReport];
       
    }
    else{
      NSLog(@"file not exist");
    }
}
-(void)mailReport{
   
    MFMailComposeViewController* mailComposer = [[MFMailComposeViewController alloc] init] ;
    mailComposer.mailComposeDelegate = self;
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0]stringByAppendingPathComponent:@"Report.pdf"];
    NSLog(@"path is %@",path);
    [mailComposer addAttachmentData:[NSData dataWithContentsOfFile:path]
                           mimeType:@"application/pdf" fileName:@"Report.pdf"];
    [mailComposer setSubject:@"Reports"];
    
    [self presentModalViewController:mailComposer animated:YES];  
    
    
}

- (void)plotTempratureBackground
{
    
    lb1.frame=CGRectMake(129, 5, 129,20);
    lb1.alpha=.35;
    lb2.alpha=.35;
    lb3.alpha=.35;
    lb4.alpha=.35;
    lb1.text=@"Normal";
    lb2.frame=CGRectMake(129, 0, 129, 20);
    lb4.frame=CGRectMake(129, 5, 129,20);
    lb2.text=@"HypoThermia";
    lb4.text=@"Fever";
    //lb3.hidden=YES;
    //lb4.hidden=YES;
    vw1.frame=CGRectMake(0, 250, 330,40);
    vw2.frame=CGRectMake(0, 340, 330,25);
    vw3.frame=CGRectMake(0, 220, 330,30);
    vw4.hidden=YES;;
    
}

- (void)plotpulseBackground{
    lb1.alpha=.35;
    lb2.alpha=.35;
    lb3.alpha=.35;
    lb4.alpha=.35;
    int age=[[[NSUserDefaults standardUserDefaults] objectForKey:@"age"]intValue]; 
    if(age ==1){
        lb1.frame=CGRectMake(96, 0, 59, 85);
        lb1.text=@"High";
        vw1.frame=CGRectMake(0, 0, 320, 85);
        lb2.text=@"Normal \n (100-160)";
        lb2.lineBreakMode=UILineBreakModeWordWrap;
        lb2.numberOfLines = 0;
        lb2.frame=CGRectMake(96, 0, 59, 85);// lb2.frame=CGRectMake(86, 85, 59, 85);
        vw2.frame=CGRectMake(0, 85, 320, 101);   
        lb3.text=@"Low";
        lb3.frame=CGRectMake(96, 0, 59, 85);//lb3.frame=CGRectMake(56, 186, 59, 85);
        vw4.frame=CGRectMake(0, 320, 264, 150);
        lb4.hidden=YES;
        vw3.hidden=YES;
    }
    
    
    else if(age >1 && age <=10){
        lb1.frame=CGRectMake(96, 0, 59, 120);// lb1.frame=CGRectMake(56, 0, 59, 120);
        lb1.text=@"High";
        vw1.frame=CGRectMake(0, 0, 320, 120);
        lb2.text=@"Normal\n(60-140) ";
        lb2.lineBreakMode=UILineBreakModeWordWrap;
        lb2.numberOfLines = 0;
        lb2.frame=CGRectMake(96, 0, 59, 126);//CGRectMake(56, 120, 59, 126);
        vw2.frame=CGRectMake(0, 120, 320, 126);   
        lb3.text=@"Low";
        lb3.frame=CGRectMake(96, 0, 59, 90);//(56, 246, 59, 90);
        vw4.frame=CGRectMake(0, 246, 320, 90);
        lb4.hidden=YES;
        vw3.hidden=YES;
    }
    
    else if(age >=11 && age <=17){
        NSLog(@"age 11-17");
        lb1.frame=CGRectMake(86, 0, 59, 98);//CGRectMake(86, 0, 59, 98);
        lb1.text=@"High";
        vw1.frame=CGRectMake(0, 0, 320, 182);
        lb2.text=@"Normal\n(60-100)";
        lb2.lineBreakMode=UILineBreakModeWordWrap;
        lb2.numberOfLines = 0;
        lb2.frame=CGRectMake(96, 0, 59, 79);//CGRectMake(56, 182, 59, 79);
        vw2.frame=CGRectMake(0, 182, 320, 79);   
        lb3.text=@"Low";
        lb3.frame=CGRectMake(96, 0, 59, 90);//lb3.frame=CGRectMake(56, 246, 59, 90);
        vw4.frame=CGRectMake(0, 246, 320, 90);
        lb4.hidden=YES;
        vw3.hidden=YES;
    }
    
    
    
    
    
}
// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
    
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			
			break;
		case MFMailComposeResultSaved:
			
			break;
		case MFMailComposeResultSent:
			
			break;
		case MFMailComposeResultFailed:
			
			break;
		default:
			
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
-(IBAction)done:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait); 
	//return YES;
}

@end
