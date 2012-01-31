//
//  InformationView.m
//  BookkeeperApp


#import "InformationViewController.h"


@implementation InformationViewController

@synthesize informationText;





// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	informationText.backgroundColor = [UIColor clearColor];
	
	//Text
	NSString *line1 = @"Features";
	NSString *line2 = @"• Record your blood pressure, heart rate, temprature, and measurement time.";
	NSString *line3 = @". Check your results and blood pressure,pulse rate,temprature changing in graphical format.";

    NSString *line4 = @". Maintains a database of every record.";
	NSString *line8 = @"How to use.";
	NSString *line9 = @"";
	
				   
		
    NSString *line22 = @"• To enter user settig click on enter user setting detais and enter user information such as age weight and height since user's health report depends on these parameters";
	NSString *line23 = @" • To view records click on view records,record entry in red color denotes record reading lies in danger zone.";
    NSString *line24 = @" • To view graphical report click on show graph";
    NSString *text = [NSString stringWithFormat:@"%@\n\n%@\n\n%@\n\n%@\n\n%@\n%@\n%@\n\n%@\n\n%@", line1, line2, line3,line4, line8, line22, line23, line24, line9];
	informationText.text = text;

	self.title=@"Quick Guide";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.navigationController setToolbarHidden:YES];
}
-(IBAction)done:(id)sender{
    NSLog(@"heeeeeeee");
    [self dismissModalViewControllerAnimated:YES];
}
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}






@end
