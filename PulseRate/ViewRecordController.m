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
    
    self.title=@"View  Records";
    UIBarButtonItem *_backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationController.navigationItem.backBarButtonItem = _backButton;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    
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
