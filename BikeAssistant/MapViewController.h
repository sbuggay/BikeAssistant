//
//  MapViewController.h
//  BikeAssistant
//
//  Created by Devan Buggay on 2/10/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController
<CLLocationManagerDelegate>
{

    
}
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *startLocation;

@end
