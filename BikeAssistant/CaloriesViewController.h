//
//  CaloriesViewController.h
//  BikeAssistant
//
//  Created by Samuel Haars on 2/6/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CaloriesViewController : UIViewController

<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *startLocation;
    
}

@property (weak, nonatomic) IBOutlet UILabel *caloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *wattsLabel;
@property double totalWeight, distance, totalTime, resistance;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *startLocation;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *altitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end
