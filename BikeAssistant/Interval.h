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

- (id) initWithDefaults;
- (void) getInterval:(NSString *)key;
- (NSNumber *) getTimer;
- (NSString *) getTimeName;
- (NSString *) getIntervalName;
- (void) setIntervalName:(NSString *)newName;
- (void) getNextTimer;
- (NSMutableArray *) getListOfIntervals;
- (void) saveInterval;
- (BOOL) isLastTimer;
- (void) addTimer:(NSNumber *)newTimer;
- (BOOL) timerExist:(NSString *)timerName;
- (NSNumber *) getTimer:(NSString *)timerName;
- (void) deleteInterval;
- (void) addInterval;
@end