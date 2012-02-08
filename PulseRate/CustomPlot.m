#import "CustomPlot.h"
#import "CPTTheme.h"
@implementation CustomPlot
@synthesize hostingView = _hostingView;
@synthesize graph = _graph;
@synthesize graphData = _graphData;
@synthesize xax,yax,graphtype;
@synthesize graphPeriod;
@synthesize timeStamparray;


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
    float xAxisMax =37;//= 30;
    float yAxisMin = -20;
    float yAxisMax;
    
    
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
        yAxisMax = 40;//
        axisSet.yAxis.majorIntervalLength = CPTDecimalFromFloat(2.0f);
        yAxisMin=0;
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
	axisSet.xAxis.majorIntervalLength = CPTDecimalFromFloat(11);
	axisSet.xAxis.minorTicksPerInterval = 1;
	axisSet.xAxis.minorTickLength = 0;
	axisSet.xAxis.majorTickLength = 0;
    axisSet.xAxis.orthogonalCoordinateDecimal =  CPTDecimalFromFloat(0.0f);
    axisSet.xAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    axisSet.xAxis.labelOffset = 0.0;
    
    CPTMutableTextStyle *labelStyle = [CPTMutableTextStyle textStyle];
    labelStyle.fontSize = 9.0;
    axisSet.xAxis.labelTextStyle = labelStyle;
    
    
    //Customization of xaxis labels 
    NSMutableArray *customTickLocations = [NSMutableArray array];
    NSMutableArray *customTickLocations1 = [NSMutableArray array];
    NSMutableArray *customTickLocations2 = [NSMutableArray array];
    NSMutableArray *customTempratureTickLocations3 = [NSMutableArray array];
    
    int i;
    
    
      
    
    //For weakly reporting  xaxis labels locations
    for (int i=1;i<=7;i++) {
        [customTickLocations addObject:[NSDecimalNumber numberWithInt:(4*i)]];
        
    }
    //For monthly reporting  xaxis labels locations
    for (int i=0;i<=31;i++) {
        [customTickLocations1 addObject:[NSDecimalNumber numberWithFloat:(i*(1.15))]];
        
        
    }
    
    //For Daily reporting  xaxis labels locations
    for (int i=1;i<=[self.graphData count];i++) {
        [customTickLocations2 addObject:[NSDecimalNumber numberWithInt:(4*i)]];
        
        
    }
    i = 0;
    NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[self.graphData count]];
    NSMutableArray *customLabels2 = [[NSMutableArray alloc] init];
    
    //for Daily reprting customization of x axis labels
    if(self.graphPeriod==3){
        for (int i=0;i<[self.graphData count];i++) {
            
            CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:[[timeStamparray objectAtIndex:i] substringToIndex:5] textStyle:axisSet.xAxis.labelTextStyle];
            newLabel.tickLocation = [[customTickLocations2 objectAtIndex:i] decimalValue];
            newLabel.offset =5*axisSet.xAxis.labelOffset +5* axisSet.xAxis.majorTickLength;
            [customLabels addObject:newLabel];
          //  axisSet.xAxis.labelRotation = M_PI/4;
        }      
        [axisSet.xAxis setMajorTickLocations:[NSSet setWithArray:customTickLocations2]];
        
    }
    //for weakly reprting customization of x axis labels
    else if(self.graphPeriod ==1){
        NSArray *lbarray=[NSArray arrayWithObjects:@"Day1 ",@"Day2 ",@"Day3 ",@"Day4 ",@"Day5 ",@"Day6 ",@"Day7 ",  nil];
        
        for (int i=0;i<7;i++) {
            CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:[lbarray objectAtIndex:i] textStyle:axisSet.xAxis.labelTextStyle];
            
            newLabel.tickLocation = [[customTickLocations objectAtIndex:i] decimalValue];
            newLabel.offset =5*axisSet.xAxis.labelOffset +5* axisSet.xAxis.majorTickLength;
            [customLabels addObject:newLabel];
           // axisSet.xAxis.labelRotation = M_PI/6;
        }      
        [axisSet.xAxis setMajorTickLocations:[NSSet setWithArray:customTickLocations]];
        
    }
    
    //for monthly reporting customization of x axis labels
    else{
        
         for (int i=0;i<=31;i++) {//latest cahnge
        //for (int i=1;i<=31;i++) {
            CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%d",i] textStyle:axisSet.xAxis.labelTextStyle];
            newLabel.tickLocation = [[customTickLocations1 objectAtIndex:(i)] decimalValue];
            newLabel.offset =axisSet.xAxis.labelOffset + axisSet.xAxis.majorTickLength;
            [customLabels addObject:newLabel];
        }
        [axisSet.xAxis setMajorTickLocations:[NSSet setWithArray:customTickLocations1]];
    }    
    
    
    
    if([yax isEqualToString:@"Temprature"]){
    
        
        for (int i=0;i<=8;i++) {
            [customTempratureTickLocations3 addObject:[NSDecimalNumber numberWithInt:(5*i)]];
            
        } 

        NSArray *lbarray=[NSArray arrayWithObjects:@"94ºF",@"96ºF",@"98ºF",@"100ºF",@"102ºF",@"104ºF",@"106ºF ",@"108ºF",@"110ºF",   nil];
         for (int i=0;i<=8;i++) {
            CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:[lbarray objectAtIndex:i] textStyle:axisSet.yAxis.labelTextStyle];
            newLabel.tickLocation = [[customTempratureTickLocations3 objectAtIndex:i] decimalValue];
            [customLabels2 addObject:newLabel];
           
        }      
        [axisSet.yAxis setMajorTickLocations:[NSSet setWithArray:customTempratureTickLocations3]];
    
        ///
        axisSet.yAxis.orthogonalCoordinateDecimal =  CPTDecimalFromFloat(0.0f);
        axisSet.yAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
        axisSet.yAxis.labelOffset = 0.0;
        
        CPTMutableTextStyle *labelStyle2 = [CPTMutableTextStyle textStyle];
        labelStyle.fontSize = 9.0;
        axisSet.yAxis.labelTextStyle = labelStyle2;
        

    }
    
    
    
    axisSet.xAxis.axisLabels =  [NSSet setWithArray:customLabels];     
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
	axisSet.yAxis.axisLabels =  [NSSet setWithArray:customLabels2];
    
      
    
    
    
    
    
    
    if([self.graphtype isEqualToString:@"Histogram" ]){
        CPTBarPlot *plot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor darkGrayColor] horizontalBars:NO];
        
        plot.dataSource = self;
        plot.identifier = @"mainplot2";
        plot.baseValue  =  CPTDecimalFromFloat(0.0f);;
        
        plot.barWidthsAreInViewCoordinates =YES;   
        plot.barWidth = CPTDecimalFromFloat(.10f);
        
        
        [self.graph addPlot:plot];
        // toPlotSpace:plotSpace]; 
        
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

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot 
{
	if ( [plot.identifier isEqual:@"mainplot"] ) 
	{
        
        return [self.graphData count];
	} 
	else if ( [plot.identifier isEqual:@"mainplot2"] ) 
	{
        
        return [self.graphData count];
	} 
    
	return 0;
}


-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index 
{  
    
	if ( [plot.identifier isEqual:@"mainplot"] ) 
	{  
        
        NSValue *value = [self.graphData objectAtIndex:index];
        CGPoint point = [value CGPointValue];
        
        
		if ( fieldEnum == CPTScatterPlotFieldX) 
		{ 
            NSLog(@"scatter x");
            return [NSNumber numberWithFloat:point.x];
            
		}
		else	
		{    
            
            return [NSNumber numberWithFloat:point.y];
		}	
	}
    else  if ( [plot.identifier isEqual:@"mainplot2"] ) 
	{   
        
        NSValue *value = [self.graphData objectAtIndex:index];
        CGPoint point = [value CGPointValue];
        NSLog(@"histogram plot");
        
        
		if ( fieldEnum == CPTBarPlotFieldBarLocation) 
		{ 
            
            return [NSNumber numberWithFloat:point.x];
		}
        else if (fieldEnum == CPTBarPlotFieldBarTip)
		{    
            
            return [NSNumber numberWithFloat:point.y];
		}	
	}
    
    
	
	return [NSNumber numberWithFloat:0];
}

@end
