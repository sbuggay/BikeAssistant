//
//  CommonLibrary.h
//  BikeAssistant
//
//  Created by Benjamin Skipper on 2/17/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonLibrary : NSObject{
    NSNumber * timeToHours;
    NSNumber * timeToMinutes;
    NSNumber * timeToSeconds;
}

-(NSNumber *) timeToHours:(int) seconds;
-(NSNumber *) timeToMinutes:(int) seconds;
-(NSNumber *) timeToSeconds:(int) seconds;
-(UIAlertView *) superSimpleAlert:(NSString*)messageIn;

@end
