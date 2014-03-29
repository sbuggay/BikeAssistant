//
//  History.m
//  BikeAssistant
//
//  Created by Chauncey Philpot on 3/24/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "History.h"

@implementation History

- (id)initWithDefaults{
    route = @"";
    time = 0;
    interval = [[Interval alloc]initWithDefaults];
    defaults = [[NSUserDefaults alloc]init];
   
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                                 fromDate:[NSDate date]];
    myDate = [calendar dateFromComponents:components];
    
    sDate = [[NSString alloc]init];
    
    totalWatts = [[NSNumber alloc]init];
    totalCalories = 0;
    totalDistance = 0;
    wattsHolder = 0;
    caloriesHolder = 0;
    distanceHolder = 0;
    elevation = 0;
    
    routesDictName = @"routes";
    intervalDictName = [[NSString alloc]init];
    
    historyDict = [[defaults dictionaryForKey:routesDictName]mutableCopy];
    intervalDict = [[NSMutableDictionary alloc]init];
    
    historyItems = [[NSMutableArray alloc]init];
    overallData = [[NSMutableArray alloc]init];
    intervalData = [[NSMutableArray alloc]init];
    intervals = [[NSMutableArray alloc]init];
    
    return self;
}

- (void)setRoute:(NSString *)routeNameIn{
    route = routeNameIn;
}
- (void)setTime:(NSNumber *)timeIn{
    time = timeIn;
}
- (void)setInterval:(Interval *)intervalIn{
    interval = intervalIn;
}

- (void)setDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MM/dd/yy";
    
    sDate = [dateFormatter stringFromDate: myDate];
    
}

- (void)setWattsHolder:(NSNumber *)wattsIn{
    wattsHolder = wattsIn;
}
- (void)setTotalWatts:(NSNumber *)wattsIn{
    totalWatts = wattsIn;
}
- (void)setCaloriesHolder: (NSNumber *)calIn{
    caloriesHolder = calIn;
}
- (void)setTotalCalories: (NSNumber *)calIn{
    totalCalories = calIn;
}
- (void)setElevationClimbed: (NSNumber *)elevIn{
    elevation = elevIn;
}

- (NSString *)getRoute{
    
    return route;
}

- (NSNumber *)getTime{
    return time;
}

- (NSString *)getDate{
    
    return sDate;
}

- (NSNumber *)getWattsHolder{
    return wattsHolder;
}

- (NSNumber *)getTotalWatts{
    return totalWatts;
}

- (NSNumber *)getCaloriesHolder{
    return caloriesHolder;
}

- (NSNumber *)getTotalCalories{
    return totalCalories;
}

- (NSNumber *)getElevationClimbed{
    return elevation;
}

- (void)loadHistory{} //loads the historyDict dictionary and assigns the object to historyItems
- (void)addHistoryItem{} //using route + date + intervalDict, save to historyDict dictioary
- (void)deleteHistoryItem{} //Delete from historyDict using key + any intervalDict items added
- (NSString *)fixName:(int)counterIn nameToCheck:(NSString *)nameIn{return NULL;} //Using route + date, see if combination exist in historyDict.
- (void)addInterval{} //set intervals to intervalDict
- (void)addIntervalData{} //add intervalData to intervals and reset intervalData
- (void)prepIntervalData{} //Adds holder variables to intervalData array and updates them
- (void)resetIntervalData{} //Clears the intervalData array

@end
