//
//  NotificationController.h
//  PulseRate
//
//  Created by Aneesh on 21/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
@interface NotificationController : UIViewController<UIAlertViewDelegate>{
IBOutlet UITextField *nameField;
IBOutlet UITextView *description;
IBOutlet UITextField *dateField;    
UIDatePicker *picker;  
UIToolbar *bar;
}
//@property (nonatomic,retain) IBOutlet id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic,retain) IBOutlet UITextField *nameField;
@property (nonatomic,retain) IBOutlet UITextView *description;
@property (nonatomic,retain) IBOutlet UITextField *dateField;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
- (IBAction)done:(id)sender;
- (IBAction)back:(id)sender;
- (void)scheduleNotificationwithEvent :(Event *)event ;

@end


