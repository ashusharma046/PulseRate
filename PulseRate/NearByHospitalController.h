//
//  NearByHospitalController.h
//  PulseRate
//
//  Created by Aneesh on 22/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapLocationController.h>
#define _APP_KEY @"AIzaSyBaKY1tQOH6QOVTBH2WtM7GcOrCBq91vUI"
@interface NearByHospitalController : UITableViewController<CLLocationManagerDelegate,NSURLConnectionDelegate>{
    
	float lat;
	float longt;
	CLLocationManager *locationManager;
    NSMutableArray *hospitalArray;
    int i;
    UIActivityIndicatorView *acView;
    NSMutableData *receivedData;
    UIView *progressView;
}
@property(nonatomic ,retain) UIActivityIndicatorView *acView;

@property(nonatomic ,retain) MapLocationController *mapLocationController;
-(void)getHospitals;
@end
