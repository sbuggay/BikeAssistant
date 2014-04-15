//
//  LocationManager.h
//  BikeAssistant
//
//  Created by Devan Buggay on 3/31/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface LocationManager : NSObject <CLLocationManagerDelegate> {
    bool timerRunning;
}

@property CLLocation *currentLocation;
@property CLLocationManager *locationManager;
@property int timeElapsed; //seconds


+(LocationManager *)sharedInstance;
-(void)start;
-(void)end;

@end
