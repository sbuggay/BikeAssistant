//
//  MetricsViewController.h
//  BikeAssistant
//
//  Created by Devan Buggay on 3/3/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <GPX/GPX.h>

#import "RouteManager.h"
#import "Interval.h"
#import "Timer.h"

@interface MetricsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *wattsLabel;
@property (weak, nonatomic) IBOutlet UILabel *caloriesLabel;

@end

float globalCals;
float globalWatts;

@interface Stats : NSObject{
    
    float weight;
    float distance;
    int time;
    float resistance;
    float calBurnt;
    float watts;
}

- (id) initWithDefaults;
- (void) calculateStats;

@end