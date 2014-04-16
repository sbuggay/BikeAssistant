//
//  History.h
//  BikeAssistant
//
//  Created by Chauncey Philpot on 3/24/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interval.h"
#import "LocationManager.h"

@interface History : NSObject
{
    CLLocationManager *locationManager;
    
    NSString *route;
    NSString *sInterval;
    NSNumber *time;
    NSUserDefaults *defaults;
    Interval *interval;

    NSDate *myDate;
    NSString *sDate;
    
    NSNumber *totalWatts;
    NSNumber *totalCalories;
    NSNumber *totalDistance;
    NSNumber *wattsHolder;
    NSNumber *caloriesHolder;
    NSNumber *distanceHolder;
    NSNumber *timeHolder;
    NSNumber *elevation;
    
    NSString *routesDictName;
    NSString *intervalDictName;
    
    NSMutableDictionary *historyDict;
    NSMutableDictionary *intervalDict;
    
    NSMutableArray *historyItems;
    NSMutableArray *overallData;
    NSMutableArray *intervalData;
    NSMutableArray *intervals;
    
}

- (id)initWithDefaults;

- (void)setRoute:(NSString *)routeNameIn;
- (void)setTime:(NSNumber *)timeIn;
- (void)setTimerHolder:(NSNumber *)timeIn;
- (void)setInterval:(Interval *)intervalIn;
- (void)setDate;
- (void)setWattsHolder:(NSNumber *)wattsIn;
- (void)setTotalWatts:(NSString *)wattsIn;
- (void)setCaloriesHolder: (NSNumber *)calIn;
- (void)setTotalCalories: (NSNumber *)calIn;
- (void)setElevationClimbed: (NSNumber *)elevIn;

- (NSString *)getRoute;
- (NSNumber *)getTime;
- (NSString *)getDate;
- (NSNumber *)getWattsHolder;
- (NSNumber *)getTotalWatts;
- (NSNumber *)getCaloriesHolder;
- (NSNumber *)getTotalCalories;
- (NSNumber *)getElevationClimbed;

- (NSMutableArray *) getListOfHistoryItems;
- (void)saveHistory;
- (void)loadHistory:(NSString *)routeName; //loads the historyDict dictionary and assigns the object to historyItems
- (void)addHistoryItem; //using route + date + intervalDict, save to historyDict dictioary
- (void)deleteHistoryItem; //Delete from historyDict using key + any intervalDict items added
- (NSString *)fixName:(int)counterIn nameToCheck:(NSString *)nameIn; //Using route + date, see if combination exist in historyDict.
- (void)addInterval; //set intervals to intervalDict
- (void)addIntervalData; //add intervalData to intervals and reset intervalData
- (void)prepIntervalData; //Adds holder variables to intervalData array and updates them
- (void)resetIntervalData; //Clears the intervalData array


@end
