//
//  TUTViewController.h
//  Core Plot Introduction
//
//  Created by John Wordsworth on 20/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "TUTSimpleScatterPlot.h"

@interface TUTViewController : UIViewController {
    IBOutlet CPTGraphHostingView *_graphHostingView;
    TUTSimpleScatterPlot *_scatterPlot;
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
}
@property (copy)  NSString *xax;
@property (copy)  NSString *yax;
@property (copy)  NSString *graphtype;
@property(nonatomic,retain) IBOutlet UILabel *lb1;
@property(nonatomic,retain) IBOutlet UILabel *lb2;
@property(nonatomic,retain) IBOutlet UILabel *lb3;
@property(nonatomic,retain) IBOutlet UILabel *lb4;


@property(nonatomic,retain) IBOutlet UIView *vw1;
@property(nonatomic,retain) IBOutlet UIView *vw2;
@property(nonatomic,retain) IBOutlet UIView *vw3;
@property(nonatomic,retain) IBOutlet UIView *vw4;

@property (nonatomic, retain) TUTSimpleScatterPlot *scatterPlot;
-(IBAction)done:(id)sender;
@end
