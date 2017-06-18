//
//  ViewNotesController.m
//  PulseRate
//
//  Created by Aneesh on 23/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewNotesController.h"
#import "AppDelegate.h"
#import "NotesCell.h"
#import "Notes.h"
#import <QuartzCore/QuartzCore.h>
#import "EditNoteViewController.h"
@implementation ViewNotesController
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
    NSLog(@"viewDidLoad add text");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Notes" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entityDesc];
    
    
    
    
    
    
    NSError *error;
    
    noteListArray = [context executeFetchRequest:request error:&error];
    
    if ([noteListArray count] == 0) {
        NSLog(@"No matches");
    } 
    else {
        
        NSLog(@" matches-----%d",[noteListArray count]);
    }
    self.view.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(239.0/255) blue:(213.0/255) alpha:1.0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextDidSave:) name:@"ContextSave" object:nil];
    self.title = @"View Notes";

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
    return [noteListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NotesCell";
    Notes *note1=[noteListArray objectAtIndex:indexPath.row];
    NotesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NotesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss'Z'"];
    cell.nameLabel.text=note1.name;
    cell.descLabel.text=note1.desc;
    cell.timeLabel.text=note1.date;//[dateFormatter stringFromDate:note1.date];
    cell.descLabel.layer.cornerRadius = 12; 
    cell.descLabel.backgroundColor= [UIColor grayColor];//[UIColor colorWithRed:(255.0/255.0) green:(239.0/255) blue:(213.0/255) alpha:1.0];
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

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   controller = [self.storyboard instantiateViewControllerWithIdentifier:@"EditNoteViewController"];
    
    
    Notes *note1=[noteListArray objectAtIndex:indexPath.row];
   
    
    
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss'Z'"];
    
    //controller.tag=indexPath.row+1;
    controller.nameFieldstr=[note1 valueForKey:@"name"];
    controller.descriptionstr=[note1 valueForKey:@"desc"];;
    controller.dateFieldstr=[note1 valueForKey:@"date"];;
    //[dateFormatter stringFromDate:[note1 valueForKey:@"date"]];
    [self.navigationController pushViewController:controller animated:YES];
    NSLog(@"AA---%@------%@",[note1 valueForKey:@"name"],[note1 valueForKey:@"desc"]);

}
- (void)contextDidSave:(NSNotification *)notification
{
    
    NSLog(@"contextSave******************");
       [self viewDidLoad];
    [self.tableView reloadData];
}
@end
