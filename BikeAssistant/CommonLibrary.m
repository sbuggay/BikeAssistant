//
//  CommonLibrary.m
//  BikeAssistant
//
//  Created by Benjamin Skipper on 2/17/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "CommonLibrary.h"

@implementation CommonLibrary
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

-(UIAlertView *) simpleAlert:(NSString*)titleIn: (NSString*)messageIn:(NSString*)buttonTextIn
{
    return [[UIAlertView alloc] initWithTitle:titleIn message:messageIn delegate:nil cancelButtonTitle:buttonTextIn otherButtonTitles:nil, nil];
}

-(UIAlertView *) superSimpleAlert:(NSString*)messageIn
{
    return [[UIAlertView alloc] initWithTitle:@"Alert" message:messageIn delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
}
@end
