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
#import "LocationManager.h"
#define systemSoundID    1005

@interface Timer : NSObject{
    NSString *intervalName;
    NSString *timerName;
    NSNumber *time;
    NSNumber *totalTime;
    UILabel *timerLabel;
    CommonLibrary *lib;
    Interval *interval;
    NSTimer* timer;
    BOOL repeat;
    BOOL isRunning;
    BOOL distanceSet;
    CLLocationManager *locationManager;
}

- (id) initWithLabels:(UILabel *)intervalLabel name:(NSString *)name;
- (void) updateLabel:(UILabel *)intervalLabel;
- (void) setTimerName:(NSString *)name;
- (NSNumber *) timerStart;
- (void) updateLabels;
- (void) fixTime;
- (NSString *) getIntervalTimeName;
- (NSString *) getIntervalName;
- (NSString *) formatTime;
- (BOOL) didTimerFinish;
- (BOOL) didIntervalFinish;
- (BOOL) isRunning;
- (void) timer;
- (void) stopTimer;
- (void) setRepeat:(BOOL)repeatIn;
- (BOOL) isRepeat;
- (int) getTotalTime;
- (BOOL) isDistanceSet;
- (void) setDistance;


@end
