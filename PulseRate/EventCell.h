//
//  EventCell.h
//  EventSchedular
//
//  Created by Aneesh on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EventCellDelegate
//- (void)deletecell;
@end

@interface EventCell : UITableViewCell{
    id<EventCellDelegate> delegate;
}
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UITextView *descLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UIButton *deleteButton;
@property (nonatomic, strong) IBOutlet UILabel *lb1;
@property (nonatomic, strong) IBOutlet UILabel *lb2;
@property (nonatomic, strong) id<EventCellDelegate> delegate;
-(IBAction)deleteRow:(id)sender;
@end
