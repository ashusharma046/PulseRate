//
//  ScheduleEventViewControler.h
//  PulseRate
//
//  Created by Aneesh on 21/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearByHospitalController.h"
@interface ScheduleEventViewControler : UIViewController{
}
@property(nonatomic,retain) NearByHospitalController *nearByHospitalController;
-(IBAction)scheduleEvent:(id)sender;
-(IBAction)viewEvent:(id)sender;
-(IBAction)done:(id)sender;
-(IBAction)addNotes:(id)sender;
-(IBAction)viewNotes:(id)sender;
@end
