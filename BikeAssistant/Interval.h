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

-(void)addTimer:(IntervalTimer *)myTimer;
-(void)encodeWithCoder:(Interval *)encoder;
-(void) saveCustomObject:(Interval *)obj;
@property (strong, nonatomic) NSString *name;

@end
