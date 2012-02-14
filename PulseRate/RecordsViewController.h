//
//  RecordsViewController.h
//  PulseRate
//
//  Created by Aneesh on 31/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ViewRecordController.h"
@class  ViewRecordController;
@interface RecordsViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate>{
    IBOutlet UIScrollView *sc;
    IBOutlet UIView *uv;
    NSArray *array;
    NSArray *montharray;
    NSArray *weakarray;
    UIPickerView *pcView;
    UIToolbar *bar2;
    UIToolbar *bar1;
    UITextField *tF;
    UITextField *weakField;
    UITextField *dateField;
    int tag;
    IBOutlet UIButton *leftArrow;
    IBOutlet UIButton *rightArrow;
    int totalRecords;
    ViewRecordController *vc;
    UIDatePicker *dpc;
    UIToolbar* toolbar; 
}
@property(nonatomic,retain) IBOutlet UIScrollView *sc;
@property(nonatomic,retain) IBOutlet UIView *uv;
@property(nonatomic,retain) IBOutlet UIButton *leftArrow;
@property(nonatomic,retain) IBOutlet UIButton *rightArrow;
@property(nonatomic,strong) ViewRecordController *vc;
-(void)layOutScroll:(NSArray *)recordsArray;
-(IBAction)monthWiseListing:(id)sender;
//-(IBAction)dayWiseListing:(id)sender;
-(IBAction)weakWiseListing:(id)sender;
- (IBAction)done:(id)sender;
-(IBAction)scrollMeForeward:(id)sender;
-(IBAction)scrollMeBackward:(id)sender;
@end
