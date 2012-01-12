//
//  UserInfo.h
//  PulseRate
//
//  Created by Aneesh on 09/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfo : NSManagedObject

@property (nonatomic) float age;
@property (nonatomic) float weight;
@property (nonatomic) float height;

@end
