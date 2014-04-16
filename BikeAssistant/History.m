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
    route = @"test";
    sInterval = @"";
    time = 0;
    interval = [[Interval alloc]initWithDefaults];
    defaults = [[NSUserDefaults alloc]init];
    [LocationManager sharedInstance];
    
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

- (void)setTimerHolder:(NSNumber *)timeIn{
    timeHolder = timeIn;
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

- (NSMutableArray *) getListOfHistoryItems{
    NSMutableArray *list = [[NSMutableArray alloc]init];
    for (NSString* key in historyDict) {
        [list addObject:key];
    }
    
    return list;
}

- (void)loadHistory:(NSString *)routeName{
    
    route = routeName;
    for (NSString* key in historyDict) {
        if([key isEqual:route]){
            historyItems = [[historyDict objectForKey:key]mutableCopy];
        }
    }
    
} //loads the historyDict dictionary and assigns the object to historyItems

- (void)addHistoryItem{
    
} //using route + date + intervalDict, save to historyDict dictioary

- (void)deleteHistoryItem{} //Delete from historyDict using key + any intervalDict items added

- (NSString *)fixName:(int)counterIn nameToCheck:(NSString *)nameIn{
    
    return NULL;

} //Using route + date, see if combination exist in historyDict.

- (void)addInterval{
     
    sInterval = [self fixName:0 nameToCheck:[interval getIntervalName]];
    [intervalDict setObject:intervals forKey:sInterval];
    [intervalDict writeToFile:sInterval atomically:YES];
    historyItems[1] = intervalDict;
    
} //set intervals to intervalDict

- (void)saveHisotry{
    
    overallData[0] = time;
    overallData[1] = totalDistance;
    overallData[2] = totalWatts;
    overallData[3] = totalCalories;
    
    route = [self fixName:0 nameToCheck:route];
    historyItems[0] = overallData;
    
    [historyDict setObject:historyItems forKey:route];
    [historyDict writeToFile:route atomically:YES];
    [defaults setObject:historyDict forKey:routesDictName];
}

- (void)addIntervalData{
    /*
    int tempTime = [time intValue];
    int tempTimeHolder = [timeHolder intValue];
    NSNumber *difference = [NSNumber numberWithInt:tempTime - tempTimeHolder];
    timeHolder = time;
    
    int tempCalHolder = [caloriesHolder intValue];
    int tempCal = [totalCalories intValue];
    
    int tempWatts = [totalWatts intValue];
    int tempWattsHolder = [wattsHolder intValue];
    
    intervalData[0] = [interval getTimeName];
    intervalData[1] = difference;
    intervalData[2] = [NSNumber numberWithInt:tempCal - tempCalHolder];
    intervalData[3] = [NSNumber numberWithInt:tempWatts - tempWattsHolder];
    
    [self setWattsHolder:[intervalData objectAtIndex:3]];
    [self setTimerHolder:[intervalData objectAtIndex:1]];
    [self setCaloriesHolder:[intervalData objectAtIndex:2]];
*/
    
    [intervals addObject:intervalData];
    
    
} //add intervalData to intervals and reset intervalData

- (void)prepIntervalData{
    
    intervalData[0] = [[[LocationManager sharedInstance] timer] getIntervalTimeName];
    
} //Adds holder variables to intervalData array and updates them

- (void)resetIntervalData{
    intervalData = [[NSMutableArray alloc]init];
} //Clears the intervalData array

@end
