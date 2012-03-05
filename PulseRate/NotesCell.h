//
//  NotesCell.h
//  PulseRate
//
//  Created by Aneesh on 23/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UITextView *descLabel;
@property (nonatomic, strong) IBOutlet UILabel *lb1;
@property (nonatomic, strong) IBOutlet UILabel *lb2;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@end
