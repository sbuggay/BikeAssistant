//
//  CaloriesViewController.m
//  BikeAssistant
//
//  Created by Samuel Haars on 2/6/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "CaloriesViewController.h"

@interface CaloriesViewController ()

@end

@implementation CaloriesViewController
@synthesize locationManager, startLocation;;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    [self timer];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults valueForKey:@"weight"]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Your weight has not been set!"
                                                          message:@"Please head over to settings to set this."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
    }

    
}

- (void)viewDidAppear:(BOOL)animated {


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)timer{
    NSTimer* timer = [NSTimer timerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(updateLabel:)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)updateLabel:(NSTimer *) timer{
    self.totalWeight = 180;
    self.distance = 1;
    self.totalTime = .033;
    self.resistance = .1;
    // Calories Burned Formula
    double caloriesBurned = ((.046 * (_distance/_totalTime) * _totalWeight) + (.066 * pow((_distance/_totalTime), 3)) * _totalTime);
    _caloriesLabel.text = [NSString stringWithFormat: @"%.2f", caloriesBurned];
    // Watts Generated Formula
    double wattsGenerated = (_totalWeight * _resistance * _distance) / _totalTime;
    _wattsLabel.text = [NSString stringWithFormat: @"%.2f", wattsGenerated];
}

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    NSString *currentLatitude = [[NSString alloc]
                                 initWithFormat:@"%g",
                                 newLocation.coordinate.latitude];
    self.latitudeLabel.text = currentLatitude;
    
    NSString *currentLongitude = [[NSString alloc]
                                  initWithFormat:@"%g",
                                  newLocation.coordinate.longitude];
    self.longitudeLabel.text = currentLongitude;
    NSString *currentAltitude = [[NSString alloc]
                                 initWithFormat:@"%gm",
                                 newLocation.altitude];
    self.altitudeLabel.text = currentAltitude;
    
    if (startLocation == nil)
        self.startLocation = newLocation;
    
    CLLocationDistance distanceBetween = [newLocation
                                          distanceFromLocation:startLocation];
    
    NSString *tripString = [[NSString alloc]
                            initWithFormat:@"%fm",
                            distanceBetween];
    self.distanceLabel.text = tripString;
}

@end
