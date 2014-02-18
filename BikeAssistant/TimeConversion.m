//
//  TimeConversion.m
//  BikeAssistant
//
//  Created by Benjamin Skipper on 2/17/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "TimeConversion.h"

@implementation TimeConversion


-(int) timeToHours:(int) seconds
{
    return seconds/3600;
}

-(int) timeToMinutes:(int) seconds
{
    seconds = seconds % [self timeToHours:seconds];
    return seconds/60;
}

-(int) timeToSeconds:(int) seconds
{
    seconds = seconds % [self timeToMinutes:seconds];
    return seconds;
}


@end
