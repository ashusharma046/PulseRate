//
//  CustomPlot.h
//  PulseRate
//
//  Created by Aneesh on 19/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"

@protocol CustomPlotDelegate

@end

@interface CustomPlot : NSObject <CPTBarPlotDataSource,CPTPlotDataSource,CPTScatterPlotDelegate> {
	CPTGraphHostingView *_hostingView;	
	CPTXYGraph *_graph;
	NSMutableArray *_graphData;
    NSString *xax;
    NSString *yax;
    NSString *graphtype;
    NSMutableArray *timeStamparray;
    id <CustomPlotDelegate> delegate;
    NSInteger max,min,dev,margin;
    
    int isRotaed;
     NSUInteger selectedBarIndex;
    CPTGraphHostingView *_hostingView1;	
	CPTXYGraph *_graph1;

}

@property (nonatomic, retain) CPTGraphHostingView *hostingView;
@property (nonatomic, retain) CPTXYGraph *graph;
@property (nonatomic, retain) NSMutableArray *graphData;
@property (nonatomic, retain) NSString *xax;
@property (nonatomic, retain) NSString *yax;
@property (nonatomic, retain) NSString *graphtype;
@property (nonatomic, assign) NSInteger graphPeriod;
@property (nonatomic, retain) NSMutableArray *timeStamparray;
@property (nonatomic,strong) id <CustomPlotDelegate> delegate;
@property (nonatomic,assign) NSInteger max,min,dev,margin;

@property (nonatomic, retain) CPTGraphHostingView *hostingView1;
@property (nonatomic, retain) CPTXYGraph *graph1;
-(id)initWithHostingView:(CPTGraphHostingView *)hostingView andData:(NSMutableArray *)data andXax:(NSString *) xax andYax :(NSString *)yax andGraphtype : (NSString *)type;

// Specific code that creates the scatter plot.
-(void)initialisePlot;
-(void)setAxisForRotation;
-(float)maxY;
-(float)minY;

-(void)reloadPlots;

@end
