//
//  CreateGraphcontroller.h
//  PulseRate
//
//  Created by Aneesh on 06/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphViewController.h"
@interface CreateGraphcontroller : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    int tag,rownum;
    IBOutlet UITextField *xaxis;
    IBOutlet UITextField *yaxis;
    IBOutlet UITextField *graphtype;
    IBOutlet UITextField *monthType;
    IBOutlet UITextField *weakType;
    IBOutlet UIPickerView *pcview;
    IBOutlet UITextField *selectDate;
    UIToolbar *bar;
    UIToolbar *bar2;
    NSArray *montharray;
    NSArray *weakArray;
    UIDatePicker *datePicker ;
    IBOutlet UILabel *lb1;
    IBOutlet UILabel *lb2;
    
    IBOutlet UIButton *arrow; 
    BOOL arrrowSate;
    BOOL arrrowSate1;
    BOOL arrrowSate2;
    UIView *monthView;
    UIView *dayView;
    UIView *weakView;
    IBOutlet UIButton *arrow1; 
    IBOutlet UIButton *arrow2; 
    IBOutlet UIButton *showGraph;
    int dayViewHidden;
}
@property(strong,nonatomic) IBOutlet UITextField *xaxis;
@property(strong,nonatomic) IBOutlet UITextField *yaxis;
@property(strong,nonatomic) IBOutlet UIPickerView *pcview;
@property(strong,nonatomic) IBOutlet UITextField *graphtype;
@property(strong,nonatomic) IBOutlet UITextField *monthType;
@property(strong,nonatomic) IBOutlet UITextField *weakType;
@property(strong,nonatomic) IBOutlet UITextField *selectDate;
@property(strong,nonatomic) GraphViewController *tUTViewController;
@property(strong,nonatomic) IBOutlet UILabel *lb1;
@property(strong,nonatomic) IBOutlet UILabel *lb2;
@property(strong,nonatomic) IBOutlet UIButton *arrow;
@property(strong,nonatomic) IBOutlet UIButton *arrow1;
@property(strong,nonatomic) IBOutlet UIButton *arrow2;
@property(strong,nonatomic) IBOutlet UIView *monthView;;
@property(strong,nonatomic) IBOutlet UIView *dayView;
@property(strong,nonatomic) IBOutlet UIView *weakView;
@property(strong,nonatomic) IBOutlet UIButton *showGraph;
-(IBAction)done:(id)sender;
-(IBAction)arrowTapped:(UIButton *)sender;
@end
