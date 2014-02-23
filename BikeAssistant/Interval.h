//
//  Interval.h
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/20/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntervalTimer.h"

@interface Interval : NSObject
{
    NSMutableArray *intervals;
}

@property (strong, nonatomic) NSString *name;

@end
