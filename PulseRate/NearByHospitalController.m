//
//  NearByHospitalController.m
//  PulseRate
//
//  Created by Aneesh on 22/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NearByHospitalController.h"
#import "HospitalCell.h"
#import "MapLocationController.h"
#import <QuartzCore/QuartzCore.h>

@implementation NearByHospitalController
@synthesize acView;
@synthesize mapLocationController;


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
    self.title=@"Near By Hospitals";
    locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
	locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
	[locationManager startUpdatingLocation];
    
    hospitalArray=[[NSMutableArray alloc]init];
       i=0;


    UIBarButtonItem *refreshButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(refreshResults)];
    refreshButton.title=@"reload";
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    self.view.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(239.0/255) blue:(213.0/255) alpha:1.0];
    receivedData=[[NSMutableData alloc] init];
}
- (void)refreshResults{
    [locationManager stopUpdatingLocation]; 
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation *)oldLocation { 
	lat = longt = 0;
	lat = newLocation.coordinate.latitude;
	longt = newLocation.coordinate.longitude;
    [self getHospitals];
    [locationManager stopUpdatingLocation];
}
-(void)getHospitals{
    acView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(30, 30, 37, 37)];
    progressView=[[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    progressView.layer.cornerRadius = 12; 
    progressView.backgroundColor=[UIColor blackColor];

    [progressView addSubview:acView];
    [self.view addSubview:progressView];
    
    [acView startAnimating];  
    NSString *temp=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=10000&types=hospital&sensor=false&key=%@",lat,longt,_APP_KEY];
  

    // NSString *temp1=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=37.785835,122.406418&radius=15000000&types=restaurant&sensor=false&key=AIzaSyCgtj9l3wRT41B8a-qM734v6F1r1Th7u-c"];
    

   
    NSURL *storeURL = [NSURL URLWithString:temp];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:storeURL];	
	[req setHTTPMethod:@"POST"];
     NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:req delegate:self];
   }

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [receivedData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{   NSError *error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:receivedData //1
                          
                          options:kNilOptions 
                          error:&error];
    
    NSArray* results = [json objectForKey:@"results"];
    int k;
    for(k=0;k<[results count];k++){
        NSDictionary *dict=[results objectAtIndex:k];
        
        [hospitalArray addObject:dict];
    }
    [self.tableView reloadData];
    [acView stopAnimating];    
    [progressView removeFromSuperview];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{  
  
    [acView stopAnimating];    
    [progressView removeFromSuperview];
    UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"Connection Failed" message:error.localizedDescription  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [av show];
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
    return [hospitalArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HospitalCell";
    
    HospitalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HospitalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.hospitalName.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    cell.lb1.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
    cell.hospitalName.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
    cell.lb1.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];

    cell.lb1.text=[[hospitalArray objectAtIndex:indexPath.row] valueForKey:@"vicinity"];
    cell.hospitalName.text=[[hospitalArray objectAtIndex:indexPath.row] valueForKey:@"name"];//@"ashu";//
    cell.contentView.backgroundColor=[UIColor colorWithRed:(255.0/255.0) green:(239.0/255) blue:(213.0/255) alpha:1.0];
    return cell;
}



#pragma mark -
#pragma mark NSURLConnectionDelegete






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
    mapLocationController = [self.storyboard instantiateViewControllerWithIdentifier:@"MapLocationController"];
    NSDictionary *dict= [[hospitalArray objectAtIndex:indexPath.row] valueForKey:@"geometry"];
    NSDictionary *loc=[dict valueForKey:@"location"];
    mapLocationController.lat=[loc valueForKey:@"lat"];
    mapLocationController.longt=[loc valueForKey:@"lng"];
    [self.navigationController pushViewController:mapLocationController animated:YES];
   

}

@end
