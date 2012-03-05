//
//  EventViewController.m
//  Schedular
//
//  Created by Aneesh on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EventViewController.h"
#import "EventCell.h"
#import "Event.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "EditReminderViewController.h"
@implementation EventViewController
@synthesize managedObjectContext = managedObjectContext_, addingManagedObjectContext;
@synthesize event;
@synthesize newCategoryID;
@synthesize eventListArray;
@synthesize btn;
@synthesize controller;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
   
    
   
    newTag=0;
    
    NSError *error;
    
    eventListArray = [context executeFetchRequest:request error:&error];
    
    if ([eventListArray count] == 0) {
      NSLog(@"No matches");
    } 
    else {
      
     NSLog(@" matches-----%d",[eventListArray count]);
    }
    self.view.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(239.0/255) blue:(213.0/255) alpha:1.0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextDidSave:) name:@"ContextDidSave" object:nil];

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [eventListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventCell";
    
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Event *event1=[eventListArray objectAtIndex:indexPath.row];
    
    cell.nameLabel.text=[event1 valueForKey:@"name"];
    cell.descLabel.text=[event1 valueForKey:@"desc"];
    cell.descLabel.layer.cornerRadius = 12; 
    cell.delegate=self;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
     [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss'Z'"];
    cell.timeLabel.text=[dateFormatter stringFromDate:[event1 valueForKey:@"date"]];
    /*
    UITapGestureRecognizer *taprecognizer;
     taprecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openEditView:)];
     cell.contentView.tag=indexPath.row;
     taprecognizer.numberOfTapsRequired=2;
     cell.contentView.userInteractionEnabled=YES;
     [cell.contentView addGestureRecognizer:taprecognizer];
    // [taprecognizer release];
    */
    
    cell.nameLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    cell.descLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    cell.timeLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    cell.lb1.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    cell.lb2.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    
    
    cell.nameLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
    cell.descLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
    cell.timeLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
    cell.lb1.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
    cell.lb2.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
    cell.contentView.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(239.0/255) blue:(213.0/255) alpha:1.0];
    return cell;
}

-(void) openEditView:(UITapGestureRecognizer *) recognizer
{
    tag=recognizer.view.tag;
    for (UIView *uv in [recognizer.view subviews]) {
        if([uv isKindOfClass:[UIButton class]]){
            uv.hidden=NO;
        
        }
    }
}
//-(void)deletecell{
//    NSLog(@"delete callled");
//     [eventListArray removeObjectAtIndex:tag];
//   // [eventListArray removeObjectAtIndex:0];
//    [self.tableView reloadData];
//    NSInteger t1=tag;
//}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     newTag=indexPath.row;
    NSLog(@"didselect row called");
    
    Event *event1=[eventListArray objectAtIndex:indexPath.row];
   
    controller = [self.storyboard instantiateViewControllerWithIdentifier:@"EditReminderViewController"];
  
    
    newTag=indexPath.row;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss'Z'"];

    controller.tag=indexPath.row+1;
    controller.nameFieldstr=[event1 valueForKey:@"name"];
    controller.descriptionstr=[event1 valueForKey:@"desc"];;
    controller.dateFieldstr=[dateFormatter stringFromDate:[event1 valueForKey:@"date"]];
    [self.navigationController pushViewController:controller animated:YES];
  
    }



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"EditSeague"] ){
       NSLog(@"new tag is %d",newTag);
         Event *event1=[eventListArray objectAtIndex:newTag];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss'Z'"];
        controller.dateFieldstr=[dateFormatter stringFromDate:[event1 valueForKey:@"date"]];
        controller = [segue destinationViewController]; 
        controller.nameFieldstr=[event1 valueForKey:@"name"];
        controller.descriptionstr=[event1 valueForKey:@"desc"];;
       // controller.dateFieldstr=[dateFormatter stringFromDate:[event1 valueForKey:@"date"]];
        controller.tag=newTag;
        
    }
       
     
 
 }
    
- (void)contextDidSave:(NSNotification *)notification
{
    
    NSLog(@"contextDidSave");
    //    SEL selector = @selector(mergeChangesFromContextDidSaveNotification:);
    //    [[[[UIApplication sharedApplication] delegate] managedObjectContext] performSelectorOnMainThread:selector withObject:notification waitUntilDone:YES];
    //    
    [self viewDidLoad];
    [self.tableView reloadData];
}

@end
