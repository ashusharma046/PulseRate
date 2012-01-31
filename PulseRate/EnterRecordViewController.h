//
//  EnterRecordViewController.h
//  PulseRate
//
//  Created by Aneesh on 19/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ViewRecordController.h"
@interface EnterRecordViewController : UIViewController <UITextFieldDelegate,UIAlertViewDelegate>{
    
    IBOutlet UITextField *temprature;
    IBOutlet UITextField *pulse;
    IBOutlet UITextField *bloodPressure;
    IBOutlet UIScrollView *scView;
    ViewRecordController *viewRecordController;
    BOOL keyboardIsShown;
    
}

@property (strong, nonatomic) IBOutlet UITextField *temprature;
@property (strong, nonatomic) IBOutlet UITextField *pulse;
@property (strong, nonatomic) IBOutlet UITextField *bloodPressure;
@property (strong, nonatomic) ViewRecordController *viewRecordController;
@property (strong, nonatomic) IBOutlet UIScrollView *scView;
-(IBAction)subMit:(id)sender;
-(IBAction)done:(id)sender;

@end
