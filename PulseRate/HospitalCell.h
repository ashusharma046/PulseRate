//
//  HospitalCell.h
//  PulseRate
//
//  Created by Aneesh on 23/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalCell : UITableViewCell{
      IBOutlet UILabel *hospitalName;
      IBOutlet UILabel *lb1;
}
@property(nonatomic,retain) IBOutlet UILabel *hospitalName;
@property(nonatomic,retain) IBOutlet UILabel *lb1;
@end
