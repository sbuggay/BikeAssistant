//
//  Timer.h
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/27/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonLibrary.h"
#import "Interval.h"

@interface Timer : NSObject{
    NSString *intervalName;
    NSString *timerName;
    NSNumber *time;
    UILabel *timerLabel;
    CommonLibrary *lib;
    Interval *interval;
    NSTimer* timer;
    BOOL repeat;
}

- (id) initWithLabels:(UILabel *)intervalLabel name:(NSString *)name;
- (void) timerStart;
- (void) updateLabels;
- (void) fixTime;
- (NSString *) formatTime;
- (BOOL) didTimerFinish;
- (BOOL) didIntervalFinish;
- (void) timer;
- (void) stopTimer;
- (void) repeat;
- (void) noRepeat;

@end
