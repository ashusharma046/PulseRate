//
//  CustomCell.h
//  PulseRate
//
//  Created by Aneesh on 04/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell{
    IBOutlet UILabel *pulse;
    IBOutlet UILabel *tmp;
    IBOutlet UILabel *bp;
    IBOutlet UILabel *date;

}
@property(nonatomic,strong) IBOutlet UILabel *pulse;
@property(nonatomic,strong) IBOutlet UILabel *tmp;
@property(nonatomic,strong) IBOutlet UILabel *bp;
@property(nonatomic,strong)  IBOutlet UILabel *date;
@end
