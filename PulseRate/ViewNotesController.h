//
//  ViewNotesController.h
//  PulseRate
//
//  Created by Aneesh on 23/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditNoteViewController.h"
@interface ViewNotesController : UITableViewController{
    NSArray *noteListArray;
}
@property (nonatomic, retain) EditNoteViewController *controller;
@end
