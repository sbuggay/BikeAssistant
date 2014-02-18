//
//  CommonLibrary.h
//  BikeAssistant
//
//  Created by Benjamin Skipper on 2/17/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonLibrary : NSObject{
    int timeToHours;
    int timeToMinutes;
    int timeToSeconds;
}

-(int) timeToHours:(int) seconds;
-(int) timeToMinutes:(int) seconds;
-(int) timeToSeconds:(int) seconds;


@end
