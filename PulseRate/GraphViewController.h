//
//  GraphViewController.h
//  PulseRate
//
//  Created by Aneesh on 06/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPTPlot.h"
#import "CorePlot-CocoaTouch.h"  
@interface GraphViewController : UIViewController<CPTPlotDataSource>{
    
//    CPTXYGraph *graph;  
//    NSArray *points;  
//    int pointsCountMinusStartingPoint;  
//    int intYNumberOfCharacters;  
    NSMutableArray *samples;
    
    
    CPTGraphHostingView *_hostingView;
    CPTXYGraph *_graph;
    NSMutableArray *_graphData;
}
@property (nonatomic, retain) CPTGraphHostingView *hostingView;
@property (nonatomic, retain) CPTXYGraph *graph;
@property (nonatomic, retain) NSMutableArray *graphData; 
-(IBAction)done:(id)sender;
@end
