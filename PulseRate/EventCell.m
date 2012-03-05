//
//  EventCell.m
//  EventSchedular
//
//  Created by Aneesh on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell
@synthesize nameLabel,descLabel,timeLabel,deleteButton;
@synthesize delegate;
@synthesize lb1,lb2;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)deleteRow:(id)sender{
    NSLog(@"delete called1111");
   // [delegate deletecell];
}
@end
