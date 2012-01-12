//
//  TUTSimpleScatterPlot.m
//  Core Plot Introduction
//
//  Created by John Wordsworth on 20/10/2011.
//

#import "TUTSimpleScatterPlot.h"
#import "CPTTheme.h"
@implementation TUTSimpleScatterPlot
@synthesize hostingView = _hostingView;
@synthesize graph = _graph;
@synthesize graphData = _graphData;
@synthesize xax,yax,graphtype;
// Initialise the scatter plot in the provided hosting view with the provided data.
// The data array should contain NSValue objects each representing a CGPoint.
-(id)initWithHostingView:(CPTGraphHostingView *)hostingView andData:(NSMutableArray *)data andXax:(NSString *) xax1 andYax :(NSString *)yax1 andGraphtype : (NSString *)type
{
    self = [super init];
    
    if ( self != nil ) {
        self.hostingView = hostingView;
        self.graphData = data;
        self.graph = nil;
        self.xax=xax1;
        self.yax=yax1;
        self.graphtype=type;
    }
  
    return self;
}

// This does the actual work of creating the plot if we don't already have a graph object.
-(void)initialisePlot
{
    // Start with some simple sanity checks before we kick off
    if ( (self.hostingView == nil) || (self.graphData == nil) ) {
        NSLog(@"TUTSimpleScatterPlot: Cannot initialise plot without hosting view or data.");
        return;
    }
    
    if ( self.graph != nil ) {
        NSLog(@"TUTSimpleScatterPlot: Graph object already exists.");
        return;
    }
    
    // Create a graph object which we will use to host just one scatter plot.
    CGRect frame = [self.hostingView bounds];
    self.graph = [[CPTXYGraph alloc] initWithFrame:frame] ;
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
	lineStyle.lineColor = [CPTColor blackColor];
	lineStyle.lineWidth = 2.0f;
	
    // Create a text style that we will use for the axis labels.
	CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
	textStyle.fontName = @"Helvetica";
	textStyle.fontSize = 14;
	textStyle.color = [CPTColor blackColor];
	
    // Create the plot symbol we're going to use.
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol crossPlotSymbol];
    plotSymbol.lineStyle = lineStyle;
    plotSymbol.size = CGSizeMake(8.0, 8.0); 	
	
    // Setup some floats that represent the min/max values on our axis.
    float xAxisMin = -7;
    float xAxisMax = 30;
    float yAxisMin = -20;
    float yAxisMax;
    double ymax=19; 
    
   	    // Modify the graph's axis with a label, line style, etc.
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)self.graph.axisSet;
    axisSet.xAxis.title = @"Date";
    
    axisSet.yAxis.title = yax;
    if([yax isEqualToString:@"Pulse"] ){
        yAxisMax = 200;
        axisSet.yAxis.majorIntervalLength = CPTDecimalFromFloat(30.0f);
        axisSet.yAxis.title = @"Pulse";
        
    }
    else if([yax isEqualToString:@"Temprature"]){
        yAxisMax = 50;
        axisSet.yAxis.majorIntervalLength = CPTDecimalFromFloat(5.0f);
        axisSet.yAxis.title = @"Temprature";
    }
    else if([yax isEqualToString:@"Blood Pressure"]){
        yAxisMax = 230;
        axisSet.yAxis.majorIntervalLength = CPTDecimalFromFloat(30.0f);
        axisSet.yAxis.title = @"Blood Pressure";
    }
    
    
    // We modify the graph's plot space to setup the axis' min / max values.
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)self.graph.defaultPlotSpace;
	plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xAxisMin) length:CPTDecimalFromFloat(xAxisMax - xAxisMin)];
	plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yAxisMin) length:CPTDecimalFromFloat(yAxisMax - yAxisMin)];
    axisSet.xAxis.titleTextStyle = textStyle;
	axisSet.xAxis.titleOffset = 40.0f;
	axisSet.xAxis.axisLineStyle = lineStyle;
	axisSet.xAxis.majorTickLineStyle = lineStyle;
	axisSet.xAxis.minorTickLineStyle = lineStyle;
	axisSet.xAxis.labelTextStyle = textStyle;
	axisSet.xAxis.labelOffset = 3;	
	axisSet.xAxis.majorIntervalLength = CPTDecimalFromFloat(5);
	axisSet.xAxis.minorTicksPerInterval = 1;
	axisSet.xAxis.minorTickLength = 5;
	axisSet.xAxis.majorTickLength = 7;
	
  
     
	axisSet.yAxis.titleTextStyle = textStyle;	
	axisSet.yAxis.titleOffset = 40.0f;	
	axisSet.yAxis.axisLineStyle = lineStyle;	
	axisSet.yAxis.majorTickLineStyle = lineStyle;
	axisSet.yAxis.minorTickLineStyle = lineStyle;
	axisSet.yAxis.labelTextStyle = textStyle;	
	axisSet.yAxis.labelOffset = 3.0f;	
	
	axisSet.yAxis.minorTicksPerInterval = 1;
	axisSet.yAxis.minorTickLength = 5.0f;
	axisSet.yAxis.majorTickLength = 7.0f;	
	


    if([self.graphtype isEqualToString:@"Histogram" ]){
    CPTBarPlot *plot = [[CPTBarPlot alloc] initWithFrame:CGRectZero];
	plot.plotRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.0)
                                                  length:CPTDecimalFromDouble(ymax)];
	plot.barOffset =  CPTDecimalFromFloat(2.5f);;
	plot.dataSource = self;
    plot.identifier = @"mainplot";
    plot.delegate=self;
    plot.barWidth = CPTDecimalFromFloat(1.50f);
	
	[self.graph addPlot:plot]; 
    
    }
    else{
    
        	CPTScatterPlot *plot = [[CPTScatterPlot alloc] init] ;
        	plot.dataSource = self;
         	plot.identifier = @"mainplot";
         	plot.dataLineStyle = lineStyle;
        	plot.plotSymbol = plotSymbol;
         	[self.graph addPlot:plot];	
    }

}

// Delegate method that returns the number of points on the plot
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot 
{
	if ( [plot.identifier isEqual:@"mainplot"] ) 
	{
        NSLog(@"number of points are %d",[self.graphData count]);
        return [self.graphData count];
	} 
	
	return 0;
}

// Delegate method that returns a single X or Y value for a given plot.
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index 
{   
	if ( [plot.identifier isEqual:@"mainplot"] ) 
	{
        NSValue *value = [self.graphData objectAtIndex:index];
        CGPoint point = [value CGPointValue];
        
        // FieldEnum determines if we return an X or Y value.
		if ( fieldEnum == CPTScatterPlotFieldX ) 
		{ 
            return [NSNumber numberWithFloat:point.x];
		}
		else	
		{    
          
            return [NSNumber numberWithFloat:point.y];
		}	
	}
	
	return [NSNumber numberWithFloat:0];
}


@end
