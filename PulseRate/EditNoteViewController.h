//
//  EditNoteViewController.h
//  PulseRate
//
//  Created by Aneesh on 25/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditNoteViewController.h"

@interface EditNoteViewController : UIViewController{
    IBOutlet UITextField *nameField;
    IBOutlet UITextView *description;
    NSString *nameFieldstr;
    NSString *descriptionstr;
    NSString *dateFieldstr;

}
@property (nonatomic,retain) IBOutlet UITextField *nameField;
@property (nonatomic,retain) IBOutlet UITextView *description;


@property (nonatomic, retain) NSString *nameFieldstr;
@property (nonatomic, retain) NSString *descriptionstr;
@property (nonatomic, retain) NSString *dateFieldstr;
- (NSDateFormatter *)dateFormatter;
- (IBAction)updateRecord;
- (IBAction)deleeRecord;
//-(void)update;
//-(void)deleted;
@end
