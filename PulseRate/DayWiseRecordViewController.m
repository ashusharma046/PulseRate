//
//  DayWiseRecordViewController.m
//  PulseRate
//
//  Created by Aneesh on 31/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DayWiseRecordViewController.h"
#import "PulseRecord.h"
@implementation DayWiseRecordViewController

@synthesize recordArray;
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
    UIScrollView *sc=[[UIScrollView alloc]init];
    int i;
    for (i=0; i<[recordArray count]; i++) {
        UIView *tileView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)]  ;
        
        PulseRecord *pulseRecord=[recordArray objectAtIndex:i];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        
        NSString *tmp  =[NSString stringWithFormat:@"%.02f °F ",[[pulseRecord valueForKey:@"temprature"] floatValue]];
        NSString *bp =[NSString stringWithFormat:@"%.02f mmHg",[[pulseRecord valueForKey:@"bloodPresssure"] floatValue]];
        NSString *pulse=[NSString stringWithFormat:@"%d BPM",[[pulseRecord valueForKey:@"pulse"] intValue]];
       

        [sc addSubview:tileView];
        
      
    }
    
    
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
