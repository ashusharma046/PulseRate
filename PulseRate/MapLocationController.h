//
//  MapLocationController.h
//  PulseRate
//
//  Created by Aneesh on 26/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
@interface MapLocationController : UIViewController{

    IBOutlet MKMapView *mview;
    NSString *lat;
    NSString *longt; 
}
@property(nonatomic,retain)IBOutlet MKMapView *mview;
@property(nonatomic,retain) NSString *lat;
@property(nonatomic,retain) NSString *longt;
@end
