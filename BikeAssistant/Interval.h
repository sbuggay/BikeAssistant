//
//  Interval.h
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/20/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Interval : NSObject
{
    NSString *intervalName;
    NSMutableDictionary *intervals;
    NSMutableDictionary *timers;
    NSString *timerName;
    NSNumber *seconds;
    NSNumber *minutes;
    NSNumber *hours;
    UILabel *intervalNameLabel;
    UILabel *timerLabel;
    BOOL isFinalIntervalTimer;
    
}




- (void) saveInterval:(NSMutableDictionary *) intervals;
- (void) loadInterval:(NSString *) key;
- (void) loadTimer:(NSString *)key;
- (NSMutableArray *) listOfIntervals;
- (NSMutableArray *) listOfTimers:(NSString *)key;
-(void)timer:(NSString *)label;
-(void) fixTime;
-(void) updateLabel:(NSTimer *) timer;
-(void) countDown;
-(NSString *) formatTime;
-(BOOL) isFinalIntervalTimer;

@end
