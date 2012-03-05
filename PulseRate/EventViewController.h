//
//  EventViewController.h
//  Schedular
//
//  Created by Aneesh on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "EventCell.h"
#import <CoreData/CoreData.h>
#import <EditReminderViewController.h>

@interface EventViewController : UITableViewController<EventCellDelegate>{
    int tag;
    int newTag;
 // EditReminderViewController *controller;
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSManagedObjectContext *addingManagedObjectContext;
@property (nonatomic, retain) Event *event;
@property (nonatomic, retain) EditReminderViewController *controller;
@property (nonatomic, retain) NSArray *eventListArray;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *btn;
@property (nonatomic, assign) NSInteger newCategoryID;
-(IBAction)done:(id)sender;
-(void) openEditView:(UITapGestureRecognizer *) recognizer;
@end
