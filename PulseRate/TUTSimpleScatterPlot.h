//
//  TUTSimpleScatterPlot.h
//  Core Plot Introduction
//
//  Created by John Wordsworth on 20/10/2011.
//

#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"


@interface TUTSimpleScatterPlot : NSObject <CPTBarPlotDelegate,CPTBarPlotDataSource,CPTPlotDataSource> {
	CPTGraphHostingView *_hostingView;	
	CPTXYGraph *_graph;
	NSMutableArray *_graphData;
    NSString *xax;
    NSString *yax;
    NSString *graphtype;
}

@property (nonatomic, retain) CPTGraphHostingView *hostingView;
@property (nonatomic, retain) CPTXYGraph *graph;
@property (nonatomic, retain) NSMutableArray *graphData;
@property (nonatomic, retain) NSString *xax;
@property (nonatomic, retain) NSString *yax;
@property (nonatomic, retain) NSString *graphtype;;

// Methods to create this object and attach it to it's hosting view.
+(TUTSimpleScatterPlot *)plotWithHostingView:(CPTGraphHostingView *)hostingView andData:(NSMutableArray *)data;
-(id)initWithHostingView:(CPTGraphHostingView *)hostingView andData:(NSMutableArray *)data andXax:(NSString *) xax andYax :(NSString *)yax andGraphtype : (NSString *)type;

// Specific code that creates the scatter plot.
-(void)initialisePlot;

@end
