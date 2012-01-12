//
//  CreateGraphcontroller.h
//  PulseRate
//
//  Created by Aneesh on 06/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TUTViewController.h"
@interface CreateGraphcontroller : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    int tag,rownum;
    IBOutlet UITextField *xaxis;
    IBOutlet UITextField *yaxis;
    IBOutlet UITextField *graphtype;
    IBOutlet UIPickerView *pcview;
    UIToolbar *bar;
}
@property(strong,nonatomic)IBOutlet UITextField *xaxis;
@property(strong,nonatomic)IBOutlet UITextField *yaxis;
@property(strong,nonatomic) IBOutlet UIPickerView *pcview;
@property(strong,nonatomic) IBOutlet UITextField *graphtype;
@property(strong,nonatomic) TUTViewController *tUTViewController;
-(IBAction)show;
-(IBAction)done:(id)sender;
@end
