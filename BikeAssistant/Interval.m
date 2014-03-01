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
    [timers addObject:0];
    
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
    
    if(currentTimer == [timers count]){
        isTrue = true;
    }
    
    return isTrue;
}

- (void) saveInterval{
    [dictionary writeToFile:dictionaryName atomically:YES];
}

- (void) getInterval:(NSString *)key{
    
    timers = [dictionary objectForKey:key];
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


