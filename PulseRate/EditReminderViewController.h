//
//  EditReminderViewController.h
//  PulseRate
//
//  Created by Aneesh on 22/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditReminderViewController : UIViewController{
    IBOutlet UITextField *nameField;
    IBOutlet UITextView *description;
    IBOutlet UITextField *dateField;    
    UIDatePicker *picker;  
    UIToolbar *bar;
    NSInteger tag;
    NSString *nameFieldstr;
    NSString *descriptionstr;
    NSString *dateFieldstr;

}
@property (nonatomic,retain) IBOutlet UITextField *nameField;
@property (nonatomic,retain) IBOutlet UITextView *description;
@property (nonatomic,retain) IBOutlet UITextField *dateField;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSString *nameFieldstr;
@property (nonatomic, retain) NSString *descriptionstr;
@property (nonatomic, retain) NSString *dateFieldstr;

@property (nonatomic, assign) NSInteger tag;
- (NSDateFormatter *)dateFormatter;
 - (IBAction)updateRecord;
- (IBAction)deleeRecord;
-(void)update;
-(void)deleted;
@end
