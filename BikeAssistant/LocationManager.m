//
//  LocationManager.m
//  BikeAssistant
//
//  Created by Devan Buggay on 3/31/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

@synthesize currentLocation;
@synthesize locationManager;
@synthesize timeElapsed;
@synthesize timerLoaded;

+(LocationManager *)sharedInstance {
    static LocationManager *sharedSingleton;
    
    @synchronized(self) {
        if (!sharedSingleton)
            sharedSingleton = [[LocationManager alloc] init];
        return sharedSingleton;
    }
}

-(id)init {
    if (self = [super init]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
        
        timeElapsed = 0;
        timerRunning = false;
        timerLoaded = false;
    }
    return self;
}

-(void)start {
    timerRunning = true;
    timeElapsed = 0;
}

-(void)end {
    timerRunning = false;
    timeElapsed = 0;
}


#pragma mark locationManager
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"%@", newLocation);
    currentLocation = newLocation;
}

@end
