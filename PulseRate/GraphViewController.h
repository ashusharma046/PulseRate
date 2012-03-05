//
//  TUTViewController.h
//  Core Plot Introduction
//
//  Created by John Wordsworth on 20/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "CustomPlot.h"
#import "CustomPlot2.h"
#import <MessageUI/MessageUI.h>


@interface GraphViewController : UIViewController<MFMailComposeViewControllerDelegate,CustomPlotDelegate> {
    IBOutlet CPTGraphHostingView *_graphHostingView;
    CustomPlot *_scatterPlot;
    NSArray *recordsArray;
    NSMutableArray *data;
    
    NSString *xax;
    NSString *yax;
    IBOutlet UILabel *lb1;
    IBOutlet UILabel *lb2;
    IBOutlet UILabel *lb3;
    IBOutlet UILabel *lb4;
    IBOutlet UIView *vw1;
    IBOutlet UIView *vw2;
    IBOutlet UIView *vw3;
    IBOutlet UIView *vw4;
    
    //date string for daywise reprting
    NSString *dateString;
    BOOL isDayWiseReporting;
    NSMutableArray *timeStampArray;
    UIToolbar* toolbar;
    CustomPlot2 *_scatterPlot1;
    float angle;
}
@property (copy)  NSString *xax;
@property (copy)  NSString *yax;
@property (copy)  NSString *graphtype;
@property (assign)  NSInteger monthnum;
@property (assign)  NSInteger weaknum;
@property (copy) NSString *dateString;
@property (assign) BOOL isDayWiseReporting;

@property(nonatomic,retain) IBOutlet UILabel *lb1;
@property(nonatomic,retain) IBOutlet UILabel *lb2;
@property(nonatomic,retain) IBOutlet UILabel *lb3;
@property(nonatomic,retain) IBOutlet UILabel *lb4;


@property(nonatomic,retain) IBOutlet UIView *vw1;
@property(nonatomic,retain) IBOutlet UIView *vw2;
@property(nonatomic,retain) IBOutlet UIView *vw3;
@property(nonatomic,retain) IBOutlet UIView *vw4;

@property (nonatomic, retain) CustomPlot *scatterPlot;
@property (nonatomic, retain) CustomPlot2 *scatterPlot1;
- (IBAction)done:(id)sender;
- (void)setDatatForDayWiseReporting;
- (void)plotTempratureBackground;
- (void)plotpulseBackground;
- (void)drawPdf;
- (void)mailReport;
CABasicAnimation *makeRotateAnimation(float fromValue, float toValue);

@end
