//
//  GraphViewController.m
//  PulseRate
//
//  Created by Aneesh on 06/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"
#import "CPTXYGraph.h"
#import "CPTGraphHostingView.h"
#import "CPTGraphHostingView.h"
#define START_POINT -2.0
#define END_POINT 2.0
#define NUM_SAMPLES 30

#define X_VAL @"X_VAL"
#define Y_VAL @"Y_VAL"

@implementation GraphViewController
@synthesize hostingView = _hostingView;
@synthesize graph = _graph;
@synthesize graphData = _graphData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) generateDataSamples
{
	double length = (END_POINT - START_POINT);
	double delta = length / (NUM_SAMPLES - 1);
	
	samples = [[NSMutableArray alloc] initWithCapacity:NUM_SAMPLES];
	
	for (int i = 0; i < NUM_SAMPLES; i++){
		double x = START_POINT + (delta * i);
		double y = x * x;
		NSDictionary *sample = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSNumber numberWithDouble:x],X_VAL,
								[NSNumber numberWithDouble:y],Y_VAL,
								nil];
		[samples addObject:sample];
	}	
}
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot; 
{
	return NUM_SAMPLES;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum 
			   recordIndex:(NSUInteger)index;
{
	NSDictionary *sample = [samples objectAtIndex:index];
	
	if (fieldEnum == CPTScatterPlotFieldX)
		return [sample valueForKey:X_VAL];
	else
		return [sample valueForKey:Y_VAL];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(IBAction)done:(id)sender{
   
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


- (void)viewDidLoad
{
    [super viewDidLoad];
    	
    double xAxisStart = START_POINT;
	double xAxisLength = END_POINT - START_POINT;
	
	double maxY = 20;
	double yAxisStart = -maxY;
	double yAxisLength = 2 * maxY;
//    CPTLayerHostingView *hostingview=[[CPTLayerHostingView alloc] initWithFrame:self.view.bounds];
//	CPTGraphHostingView *hostingView = [[CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
//	[self.view addSubview:hostingView];
//    
//	graph = [[CPTXYGraph alloc] initWithFrame:self.view.bounds];
//	hostingView.hostedGraph = graph;
//    
//	
	/*
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
	plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(xAxisStart)
												   length:CPTDecimalFromDouble(xAxisLength)];
	
	plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(yAxisStart)
												   length:CPTDecimalFromDouble(yAxisLength)];	
    
    
    
    NSLog(@"-----------%d----------%d",plotSpace.xRange,plotSpace.yRange);
	*/
    
    /*
	CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
	dataSourceLinePlot.dataSource = self;
	
	[graph addPlot:dataSourceLinePlot];
    
    
    
    
    
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-6) 
                                                   length:CPTDecimalFromFloat(12)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-5) 
                                                   length:CPTDecimalFromFloat(30)];
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    
    CPTLineStyle *lineStyle = [CPTLineStyle lineStyle];
 //   lineStyle.lineColor = [CPTColor blackColor];
   // lineStyle.lineWidth = 2.0f;
    
   // axisSet.xAxis.majorIntervalLength = [NSDecimalNumber decimalNumberWithString:@"5"];
    axisSet.xAxis.minorTicksPerInterval = 4;
    axisSet.xAxis.majorTickLineStyle = lineStyle;
    axisSet.xAxis.minorTickLineStyle = lineStyle;
    axisSet.xAxis.axisLineStyle = lineStyle;
    axisSet.xAxis.minorTickLength = 5.0f;
    axisSet.xAxis.majorTickLength = 7.0f;
    //axisSet.xAxis.axisLabelOffset = 3.0f;
    
 //   axisSet.yAxis.majorIntervalLength = [NSDecimalNumber decimalNumberWithString:@"5"];
    axisSet.yAxis.minorTicksPerInterval = 4;
    axisSet.yAxis.majorTickLineStyle = lineStyle;
    axisSet.yAxis.minorTickLineStyle = lineStyle;
    axisSet.yAxis.axisLineStyle = lineStyle;
    axisSet.yAxis.minorTickLength = 5.0f;
    axisSet.yAxis.majorTickLength = 7.0f;
    //axisSet.yAxis.axisLabelOffset = 3.0f;
    
    CPTScatterPlot *xSquaredPlot = [[CPTScatterPlot alloc] 
                                    initWithFrame:self.view.bounds];
    xSquaredPlot.identifier = @"X Squared Plot";
     xSquaredPlot.dataLineStyle.lineWidth = 1.0f;
   xSquaredPlot.dataLineStyle.lineColor = [CPTColor redColor];
    xSquaredPlot.dataSource = self;
    [graph addPlot:xSquaredPlot];
    
    CPTPlotSymbol *greenCirclePlotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    greenCirclePlotSymbol.fill = [CPTFill fillWithColor:[CPTColor greenColor]];
    greenCirclePlotSymbol.size = CGSizeMake(2.0, 2.0);
  //  xSquaredPlot.defaultPlotSymbol = greenCirclePlotSymbol;  
    
    CPTScatterPlot *xInversePlot = [[CPTScatterPlot alloc] 
                                    initWithFrame:self.view.bounds];
    xInversePlot.identifier = @"X Inverse Plot";
   // xInversePlot.dataLineStyle.lineWidth = 1.0f;
   // xInversePlot.dataLineStyle.lineColor = [CPTColor blueColor];
    xInversePlot.dataSource = self;
    [graph addPlot:xInversePlot];
*/   
    
    
    // Start with some simple sanity checks before we kick off
      
  
    // Create a graph object which we will use to host just one scatter plot.
    CGRect frame = [self.hostingView bounds];
    _graph = [[CPTXYGraph alloc] initWithFrame:frame];
    
    // Add some padding to the graph, with more at the bottom for axis labels.
    self.graph.plotAreaFrame.paddingTop = 20.0f;
    self.graph.plotAreaFrame.paddingRight = 20.0f;
    self.graph.plotAreaFrame.paddingBottom = 50.0f;
    self.graph.plotAreaFrame.paddingLeft = 20.0f;
    
    // Tie the graph we've created with the hosting view.
    self.hostingView.hostedGraph = self.graph;
    
    // If you want to use one of the default themes - apply that here.
    //[self.graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
    
    // Create a line style that we will apply to the axis and data line.
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineColor = [CPTColor whiteColor];
    lineStyle.lineWidth = 2.0f;
    
    // Create a text style that we will use for the axis labels.
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.fontName = @"Helvetica";
    textStyle.fontSize = 14;
    textStyle.color = [CPTColor whiteColor];
    
    // Create the plot symbol we're going to use.
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol crossPlotSymbol];
    plotSymbol.lineStyle = lineStyle;
    plotSymbol.size = CGSizeMake(8.0, 8.0);
    
    // Setup some floats that represent the min/max values on our axis.
    float xAxisMin = -10;
    float xAxisMax = 10;
    float yAxisMin = 0;
    float yAxisMax = 100;
    
    // We modify the graph's plot space to setup the axis' min / max values.
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)self.graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xAxisMin) length:CPTDecimalFromFloat(xAxisMax - xAxisMin)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yAxisMin) length:CPTDecimalFromFloat(yAxisMax - yAxisMin)];
    
    // Modify the graph's axis with a label, line style, etc.
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)self.graph.axisSet;
    
    axisSet.xAxis.title = @"Data X";
    axisSet.xAxis.titleTextStyle = textStyle;
    axisSet.xAxis.titleOffset = 30.0f;
    axisSet.xAxis.axisLineStyle = lineStyle;
    axisSet.xAxis.majorTickLineStyle = lineStyle;
    axisSet.xAxis.minorTickLineStyle = lineStyle;
    axisSet.xAxis.labelTextStyle = textStyle;
    axisSet.xAxis.labelOffset = 3.0f;
    axisSet.xAxis.majorIntervalLength = CPTDecimalFromFloat(2.0f);
    axisSet.xAxis.minorTicksPerInterval = 1;
    axisSet.xAxis.minorTickLength = 5.0f;
    axisSet.xAxis.majorTickLength = 7.0f;
    
    axisSet.yAxis.title = @"Data Y";
    axisSet.yAxis.titleTextStyle = textStyle;
    axisSet.yAxis.titleOffset = 40.0f;
    axisSet.yAxis.axisLineStyle = lineStyle;
    axisSet.yAxis.majorTickLineStyle = lineStyle;
    axisSet.yAxis.minorTickLineStyle = lineStyle;
    axisSet.yAxis.labelTextStyle = textStyle;
    axisSet.yAxis.labelOffset = 3.0f;
    axisSet.yAxis.majorIntervalLength = CPTDecimalFromFloat(10.0f);
    axisSet.yAxis.minorTicksPerInterval = 1;
    axisSet.yAxis.minorTickLength = 5.0f;
    axisSet.yAxis.majorTickLength = 7.0f;
    
    // Add a plot to our graph and axis. We give it an identifier so that we
    // could add multiple plots (data lines) to the same graph if necessary.
    CPTScatterPlot *plot = [[CPTScatterPlot alloc] init] ;
    plot.dataSource = self;
    plot.identifier = @"mainplot";
    plot.dataLineStyle = lineStyle;
    plot.plotSymbol = plotSymbol;
    [self.graph addPlot:plot];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
