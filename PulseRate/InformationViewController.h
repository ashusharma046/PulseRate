//
//  InformationViewController.h
//  BookkeeperApp


#import <UIKit/UIKit.h>


@interface InformationViewController : UIViewController {
	IBOutlet UITextView *informationText;
	
}

@property (nonatomic, retain) IBOutlet UITextView *informationText;
-(IBAction)done:(id)sender;



@end
