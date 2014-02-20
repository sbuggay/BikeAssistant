//
//  CommonLibrary.m
//  BikeAssistant
//
//  Created by Benjamin Skipper on 2/17/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "CommonLibrary.h"

@implementation CommonLibrary
-(NSNumber *) timeToHours:(int) seconds
{
    NSLog(@"Seconds from method: %i", seconds);
    return [NSNumber numberWithInt:seconds/3600];
}

-(NSNumber *) timeToMinutes:(int) seconds
{
    if (seconds > 3600) {
        seconds = seconds % [[self timeToHours:seconds] intValue];
        seconds = seconds/60;
    }
    else if(seconds > 60){
        seconds = seconds/60;
    }
    else{
        seconds = 0;
    }
    
    return [NSNumber numberWithInt:seconds];
}

-(NSNumber *) timeToSeconds:(int) seconds
{
    if(seconds > 60){
    seconds = seconds % [[self timeToMinutes:seconds] intValue];
    
    }
    
    return [NSNumber numberWithInt:seconds];
}

-(UIAlertView *) simpleAlert:(NSString*)titleIn message:(NSString*)messageIn button:(NSString*)buttonTextIn
{
    return [[UIAlertView alloc] initWithTitle:titleIn message:messageIn delegate:nil cancelButtonTitle:buttonTextIn otherButtonTitles:nil, nil];
}

-(UIAlertView *) superSimpleAlert:(NSString*)messageIn
{
    return [[UIAlertView alloc] initWithTitle:@"Alert" message:messageIn delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
}
@end
