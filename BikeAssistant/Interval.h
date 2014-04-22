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
    int currentTimer;
    NSString *intervalName;
    NSString *dictionaryName;
    NSMutableDictionary *dictionary;
    NSUserDefaults *defaults;
    NSMutableArray *timers;
    
}

-(void) removeTimer: (NSUInteger) index;
- (id) initWithDefaults;
- (void) getInterval:(NSString *)key;
- (NSMutableArray *) getTimers;
- (void) resetTimer;
- (NSNumber *) getTimer;
- (NSString *) getTimeName;
- (NSString *) getIntervalName;
- (void) setIntervalName:(NSString *)newName;
- (void) getNextTimer;
- (NSMutableArray *) getListOfIntervals;
- (void) saveInterval;
- (BOOL) isLastTimer;
- (void) addTimer:(NSNumber *)newTimerAmount newTimerName:(NSString *)newTimerName;
- (BOOL) timerExist:(NSString *)timerName;
- (NSNumber *) getTimer:(NSString *)timerName;
- (void) deleteInterval:(NSString *)intervalToDelete;
- (void) addInterval;
- (void) updateIntervalName:(NSString *)newName;
- (void) deleteTimer:(NSString *)timerToDelete;
- (NSInteger) numOfTimers;
- (NSMutableArray *) getListOfTimers;
- (void) updateTimers: (NSMutableArray *)newTimes;
@end
