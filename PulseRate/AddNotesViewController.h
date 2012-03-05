//
//  AddNotesViewController.h
//  PulseRate
//
//  Created by Aneesh on 23/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNotesViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>{
    IBOutlet UITextField *nameField;
    IBOutlet UITextView *description;
}
@property(nonatomic,retain) IBOutlet UITextField *nameField;
@property(nonatomic,retain) IBOutlet UITextView *description;
-(IBAction)addNote:(id)sender;
- (NSDateFormatter *)dateFormatter;
@end
