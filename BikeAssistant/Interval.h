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
    NSString *dictionaryName;
    NSMutableDictionary *dictionary;
    NSUserDefaults *defaults;
    NSMutableArray *timers;
    
}


- (void) getInterval:(NSString *)key;
- (NSNumber *) getTimer;
- (NSString *) getTimeName;
- (void) getNextTimer;
- (NSMutableArray *) getListOfIntervals;
- (void) saveInterval;
- (BOOL) isLastTimer;

@end
