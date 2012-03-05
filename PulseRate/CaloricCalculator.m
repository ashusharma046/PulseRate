//
//  CaloricCalculator.m
//  PulseRate
//
//  Created by Aneesh on 28/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CaloricCalculator.h"

@implementation CaloricCalculator
@synthesize message;
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
     NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];;
     int age=[[defaults valueForKey:@"age"] intValue];
     float weight=[[defaults valueForKey:@"weight"] floatValue];
     float height =[[defaults valueForKey:@"height"] floatValue];
      NSLog(@"age is %d weight is %f and weight %f",age,weight,height);
     float bmr= 655.1 + 9.563 *weight+  1.850 * height  - 4.676 * age;
     float bmrMan=66 +  6.23 * weight + 12.7 * height  - 6.8 * age;
     message.text=[NSString stringWithFormat:@"%f calories for women",bmr];
     message2.text=[NSString stringWithFormat:@"%f calories for men",bmrMan];
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
