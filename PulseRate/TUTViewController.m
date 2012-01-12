//
//  TUTViewController.m
//  Core Plot Introduction
//
//  Created by John Wordsworth on 20/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TUTViewController.h"
#import "AppDelegate.h"
#import "PulseRecord.h"
@implementation TUTViewController
@synthesize scatterPlot = _scatterPlot;
@synthesize xax,yax;
@synthesize lb1,lb2,lb3,lb4;
@synthesize vw1,vw2,vw3,vw4;
@synthesize graphtype;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"PulseRecord" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    data=[[NSMutableArray alloc] init];
    [request setEntity:entityDesc];
    
    NSError *error;
    
    recordsArray = [context executeFetchRequest:request error:&error];
    
    if ([recordsArray count] == 0) {
        NSLog(@"No matches");
    } 
    else {
  
            int i;
            for(i=0;i < [recordsArray count];i++){
            PulseRecord *pulseRecord=(PulseRecord *)[recordsArray objectAtIndex:i];   
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *str =[dateFormatter stringFromDate:pulseRecord.entrytime];
            NSArray *datecomps =[str componentsSeparatedByString:@"-"];
          
             if([yax isEqualToString:@"Blood Pressure"])
              {
               [data addObject:[NSValue valueWithCGPoint:CGPointMake(i*[[datecomps objectAtIndex:2] floatValue], pulseRecord.bloodPresssure)]];
              }
             if([yax isEqualToString:@"Pulse"]){
               [data addObject:[NSValue valueWithCGPoint:CGPointMake(i*[[datecomps objectAtIndex:2] floatValue], pulseRecord.pulse)]];
              }
            if([yax isEqualToString:@"Temprature"]){
            [data addObject:[NSValue valueWithCGPoint:CGPointMake(i*[[datecomps objectAtIndex:2] floatValue], pulseRecord.temprature)]];
                
            lb1.frame=CGRectMake(-2, 0, 59, 98);
            lb1.text=@"HyperThermia";
            lb2.frame=CGRectMake(-2, 102, 59, 400);
            lb2.text=@"HypoThermia";
            lb3.hidden=YES;
            lb4.hidden=YES;
            vw1.frame=CGRectMake(56, 0, 264, 98);
            vw2.frame=CGRectMake(56, 102, 264,400);
            vw3.hidden=YES;;
            vw4.hidden=YES;;
                
                
            }

            
        }
        
        
        
        
        
        self.scatterPlot= [[TUTSimpleScatterPlot alloc] initWithHostingView:_graphHostingView andData:data andXax:xax andYax :yax andGraphtype:self.graphtype];
        self.scatterPlot.xax=xax;
        self.scatterPlot.yax=yax;
        [self.scatterPlot initialisePlot];
        
        
    }
         self.view.backgroundColor=[UIColor yellowColor];
    }

- (void)viewDidUnload
{
    [super viewDidUnload];
    
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
    // Return YES for supported orientations
	return YES;
}

@end
