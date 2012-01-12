//
//  ViewRecordController.h
//  PulseRate
//
//  Created by Aneesh on 04/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
@class CustomCell;
@interface ViewRecordController : UITableViewController{
    NSArray *recordsArray;
    CustomCell *cell;
}
@property(nonatomic,strong) CustomCell *cell;
-(IBAction)done:(id)sender;
@end
