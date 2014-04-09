//
//  LocationViewController.m
//  BikeAssistant
//
//  Created by Devan Buggay on 3/1/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()


@end

@implementation LocationViewController

@synthesize locationManager;

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
	locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    _distance.text = @"0";
    _latitude.text = [NSString stringWithFormat:@"%.2f", [newLocation coordinate].latitude];
    _longitude.text = [NSString stringWithFormat:@"%.2f", [newLocation coordinate].longitude];
    _elevation.text = [NSString stringWithFormat:@"%.2f", [newLocation altitude]];
    
}

@end
