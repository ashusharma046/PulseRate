//
//  PulseRecord.h
//  PulseRate
//
//  Created by Aneesh on 04/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PulseRecord : NSManagedObject

@property (nonatomic) int32_t id;
@property (nonatomic) int32_t pulse;
@property (nonatomic) float temprature;
@property (nonatomic) float bloodPresssure;
@property (nonatomic) NSDate * entrytime; 
@end
