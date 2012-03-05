//
//  ViewRecordController.m
//  PulseRate
//
//  Created by Aneesh on 04/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewRecordController.h"
#import "AppDelegate.h"
#import "PulseRecord.h"
#import "CustomCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation ViewRecordController
@synthesize cell;
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
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"PulseRecord" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entityDesc];
    
    NSError *error;
    
   recordsArray = [context executeFetchRequest:request error:&error];
    
    if ([recordsArray count] == 0) {
        
    } 
    else {
        
        NSLog(@" matches-----%d",[recordsArray count]);
    }
    
    i=0;
    self.view.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(239.0/255) blue:(213.0/255) alpha:1.0];
;
    
}
-(IBAction)done:(id)sender{
  
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

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [recordsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    PulseRecord *pulseRecord=(PulseRecord *)[recordsArray objectAtIndex:indexPath.row];
  
    
      
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
 
    
    cell.tmp.text=[NSString stringWithFormat:@"%.02f °F ",[[pulseRecord valueForKey:@"temprature"] floatValue]];
    cell.bp.text=[NSString stringWithFormat:@"%.02f mmHg",[[pulseRecord valueForKey:@"bloodPresssure"] floatValue]];
    cell.pulse.text=[NSString stringWithFormat:@"%d BPM",[[pulseRecord valueForKey:@"pulse"] intValue]];
    cell.date.text= [NSString stringWithString:(NSString *)[pulseRecord valueForKey:@"entrytime"]];
    
    float tmp = [[pulseRecord valueForKey:@"temprature"] floatValue];
    float bp  = [[pulseRecord valueForKey:@"bloodPresssure"] floatValue];
    int pulse = [[pulseRecord valueForKey:@"pulse"] intValue];
    int age=[[[NSUserDefaults standardUserDefaults] objectForKey:@"age"]intValue];
    cell.bp.layer.cornerRadius = 6; 
    cell.tmp.layer.cornerRadius = 6; 
    cell.pulse.layer.cornerRadius = 6; 
    cell.date.layer.cornerRadius = 6; 
    
    
    cell.tmp.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    cell.bp.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    cell.pulse.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    cell.date.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    
    cell.tmp.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
    cell.bp.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
    cell.pulse.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
    cell.date.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
    
    
    
    
    
     cell.lb1.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
     cell.lb2.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
     cell.lb3.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
     cell.lb4.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    
     cell.lb1.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
     cell.lb2.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
     cell.lb3.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
     cell.lb4.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
     cell.contentView.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(239.0/255) blue:(213.0/255) alpha:1.0];

    if (tmp > 99.5) {
        [cell.tmp setBackgroundColor:[UIColor redColor]];
    }
    
    //blood Pressure
    if(age==1){
         if(!(bp > 65 || bp < 95)) {
         [cell.bp setBackgroundColor:[UIColor redColor]];
         } 
    }
    else if(age >1 && age <=10){
         if(!(bp > 65 || bp < 100)) {
         [cell.bp setBackgroundColor:[UIColor redColor]];
         } 
    }
    
    else{
        if (!(bp>=90  && bp <=140)) {
        [cell.bp setBackgroundColor:[UIColor redColor]];
        }  
    }
    
    
    //Pulse setting
    if(age ==1){
        if (!(pulse>=100  && pulse <=160)) {
            [cell.pulse setBackgroundColor:[UIColor redColor]];
        }  
    
     }
     else if(age >1 && age <=10){
        if (!(pulse>=60  && pulse <=140)) {
            [cell.pulse setBackgroundColor:[UIColor redColor]];
        }  
    } 
     else if(age >=11 && age <=17){
        if (!(pulse>=60  && pulse <=100)) {
            [cell.pulse setBackgroundColor:[UIColor redColor]];
        }  
    }
    
    else{
        if (!(pulse>=60  && pulse <=100)) {
            [cell.pulse setBackgroundColor:[UIColor redColor]];
        }  
        
    }
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (i==0) {
        CGSize sz=[scrollView contentSize];
        sz.height=sz.height+60;
        [scrollView setContentSize:sz];
        i=1;
        NSLog(@"done");
   
    }
    
    
    
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
