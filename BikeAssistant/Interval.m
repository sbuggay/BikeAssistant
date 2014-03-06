//
//  Interval.m
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/20/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "Interval.h"
#import "CommonLibrary.h"

@implementation Interval

- (id) initWithDefaults{
    dictionaryName = @"myDictionary";
    defaults = [[NSUserDefaults alloc]init];
    dictionary = [[defaults dictionaryForKey:dictionaryName]mutableCopy];
    timers = [[NSMutableArray alloc]init];
    [timers addObject:@"default"];
    [timers addObject:[NSNumber numberWithInt:0]];
    
    return self;
}

- (NSMutableArray *) getListOfIntervals{
    NSMutableArray *listOfInterval = [[NSMutableArray alloc]init];
    for (NSString* key in dictionary) {
        [listOfInterval addObject:key];
    }
    return listOfInterval;
}

- (BOOL) isLastTimer{
    bool isTrue = false;
    
    if(currentTimer == ([timers count]/2)-1){
        isTrue = true;
    }
    
    return isTrue;
}

- (void) addTimer :(NSNumber *)newTimer{
    [timers addObject:newTimer];
}

- (NSNumber *) getTimer: (NSString *)timerName{
    int reserveCount = currentTimer;
    NSNumber *timer;
    for (int i = 0; i < [timers count] / 2  ; i = i + 2) {
        if(timerName == [self getTimeName]){
            timer = [self getTimer];
        }
    }
    
    currentTimer = reserveCount;
    return NULL;
}

- (void) saveInterval{
    
    [dictionary setObject:timers forKey:intervalName];
    [dictionary writeToFile:dictionaryName atomically:YES];
}

- (void) getInterval:(NSString *)key{
    
    timers = [dictionary objectForKey:key];
    intervalName = key;
}

- (NSNumber *) getTimer{
    
    return timers[(currentTimer * 2) + 1];
}

- (NSString *) getTimeName{
    
    return timers[(currentTimer * 2)];
}

- (void) getNextTimer{
    currentTimer++;
}



@end


