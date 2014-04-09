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
    }
    return self;
}




@end
