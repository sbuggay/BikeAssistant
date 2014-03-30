//
//  Interval.m
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/20/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

/**
 This class serves to handle all matters related to the interval timer.
 
 -----Timer portion------
 currentTimer keeps track of the timers in the interval timer
 the array 'timers' contains all the timers for the particular interval that was loaded.
 
 E.G. you have 3 timers in the interval timer. Each timer has a name and time so
 the array will have 6 items. Incrementing currentTimer will allow getTimer and 
 getTimeName to pull the next two items from the array. So if currentTimer is 
 at 1, you will get the items at index 2 and 3. The name always comes first and then
 the time. Calling getNextTimer will increment currentTimer
 
 ----Interval portion----
 
 initWithDefaults will not load any interval timers.
 Call getInterval(key) to load an interval timer.
 This will set the timers array with the timers in that
 interval timer and the intervalName will be set as well so
 that you can call getIntervalName.
 
 */
#import "Interval.h"
#import "CommonLibrary.h"

@implementation Interval

- (id) initWithDefaults{
    dictionaryName = @"intervalDictionary";
    defaults = [[NSUserDefaults alloc]init];
    dictionary = [[defaults dictionaryForKey:dictionaryName]mutableCopy];
    if(dictionary == nil){
        dictionary = [[NSMutableDictionary alloc]init];
    }
    timers = [[NSMutableArray alloc]init];
    return self;
}

/**
 This will return an array of all the keys in the interval dictionary.
 Use for listing available interval timers in a table
 */
- (NSMutableArray *) getListOfIntervals{
    NSMutableArray *listOfInterval = [[NSMutableArray alloc]init];
    for (NSString* key in dictionary) {
        [listOfInterval addObject:key];
    }
    return listOfInterval;
}

- (NSMutableArray *) getListOfTimers{
    NSMutableArray *list = [[NSMutableArray alloc]init];
    
    int reserveCount = currentTimer;
    
    for (int i = 0; i < [timers count] / 2  ; i++) {
        
        [list addObject:[self getTimeName]];
        [self getNextTimer];
    }
    
    currentTimer = reserveCount;
    
    return list;
}

- (NSInteger) numOfTimers{
    
    return [timers count] /2;
}

/**
 This is primarily for the Timer class so it knows if 
 it is a the last timer in the interval.
 */
- (BOOL) isLastTimer{
    bool isTrue = false;
    
    if(currentTimer == ([timers count]/2)-1){
        isTrue = true;
    }
    
    return isTrue;
}

- (BOOL) timerExist:(NSString *)timerName{
    
    return false;
}

/**
 Adds two items to the timers array. Will add them in the order of
 Name and then Time.
 Used when adding timers to an interval timer.
 */
- (void) addTimer:(NSNumber *)newTimerAmount newTimerName:(NSString *)newTimerName{
    [timers addObject:newTimerName];
    [timers addObject:newTimerAmount];
}

- (NSMutableArray *) getTimers: (NSString *)key
{
    timers = [[dictionary objectForKey:key] mutableCopy];
    return timers;
}

/**
 Returns the name of the interval timer.
 */
- (NSString *) getIntervalName{
    return intervalName;
}

- (void) resetTimer{
    currentTimer = 0;
}

/**
 This will get the amount of time based on the name given.
 */
- (NSNumber *) getTimer: (NSString *)timerName{
    
    int reserveCount = currentTimer;
    NSNumber *timer;
    
    for (int i = 0; i < [timers count] / 2  ; i++) {
        
        if([timerName isEqualToString:[self getTimeName]]){
            timer = [self getTimer];
        }
        [self getNextTimer];
    }
    
    currentTimer = reserveCount;
    return timer;
}

/**
 This will set the intervalName.
 Should only be used if adding a new interval timer 
 */
- (void) setIntervalName:(NSString *)newName{
    intervalName = newName;
}

/**
 Deletes an interval timer from the dictionary
 */
- (void) deleteInterval:(NSString *)intervalToDelete{
    [dictionary removeObjectForKey:intervalToDelete];
}

/**
 Adds an interval timer to the dictionary.
 */
- (void) addInterval{
    [dictionary setObject:timers forKey:intervalName];
}

/**
 Saves the interval timer to the dictionary
 */
- (void) saveInterval{
    
    [dictionary setObject:timers forKey:intervalName];
    [dictionary writeToFile:dictionaryName atomically:YES];
    [defaults setObject:dictionary forKey:dictionaryName];
}

/**
 updates the interval timer name for the currently loaded
 interval timer.
 Can be manually done by calling deleteInterval, setIntervalName
 and then saveInterval.
 */
- (void) updateIntervalName:(NSString *)newName{
    NSString * oldName = [self getIntervalName];
    [self setIntervalName:newName];
    
    if (oldName != nil)
    {
    timers = [[dictionary objectForKey:oldName] mutableCopy];
    [self deleteInterval:oldName];
    }
    [self saveInterval];
    
}

/**
 'Loads' the interval timer by settings the
 timers array with the object at the specified key
 and setting the interval name. Once this is done,
 you can edit the interval and then save it using
 saveInterval.
 */
- (void) getInterval:(NSString *)key{
    
    timers = [[dictionary objectForKey:key] mutableCopy];
    if(timers == nil){
        timers = [[NSMutableArray alloc]init];
    }
    intervalName = key;
}

/**
 Returns the amount of time for the current timer.
 Controlled by currentTimer variable.
 timers has sets of name/times in it.
 Name then time
 E.G.
 timers = ['myTime1', 5, 'myTime2', 10]
 if currentTimer is at 0, calling getTimer
 will return 5 and getTimeName will return 'myTime1'
 Calling getNextTimer will increment currentTimer by 1
 meaning the previous 2 methods will return
 10 and 'myTime2' instead.
 */
- (NSNumber *) getTimer{
    
    return timers[(currentTimer * 2) + 1];
}

/**
 Returns the name for the current timer.
 Controlled by currentTimer variable
 
 E.G.
 timers = ['myTime1', 5, 'myTime2', 10]
 if currentTimer is at 0, calling getTimer
 will return 5 and getTimeName will return 'myTime1'
 Calling getNextTimer will increment currentTimer by 1
 meaning the previous 2 methods will return
 10 and 'myTime2' instead.
 */
- (NSString *) getTimeName{
    
    return timers[(currentTimer * 2)];
}

/**
 Increments currentTimer variable.
 currentTimer variables controls which timer
 the methods getTimer and getTimeName returns in the
 array timers.
 
 E.G.
 timers = ['myTime1', 5, 'myTime2', 10]
 if currentTimer is at 0, calling getTimer
 will return 5 and getTimeName will return 'myTime1'
 Calling getNextTimer will increment currentTimer by 1
 meaning the previous 2 methods will return
 10 and 'myTime2' instead.
 */
- (void) getNextTimer{
    currentTimer++;
}

- (void) deleteTimer:(NSString *)timerToDelete{
    
    int reserveCount = currentTimer;
    
    for (int i = 0; i < [timers count] / 2; i++) {
        
        if([timerToDelete isEqualToString:[self getTimeName]]){
            [timers removeObjectAtIndex:(currentTimer * 2)];
            [timers removeObjectAtIndex:(currentTimer * 2)];

        }
        [self getNextTimer];
    }
    
    currentTimer = reserveCount;
}


@end


