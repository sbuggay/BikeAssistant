//
//  ViewController.m
//  BikeAssistant
//
//  Created by Devan Buggay on 1/13/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@end

@implementation ViewController
@synthesize locationManager, startLocation;;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    [self timer];
}

-(void)timer {
        self.seconds = 0;
        NSTimer* timer = [NSTimer timerWithTimeInterval:1.0f
                                                                       target:self
                                                                     selector:@selector(updateLabel:)
                                                                     userInfo:nil
                                                                      repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

-(void) updateLabel:(NSTimer *) timer {
        self.seconds++;
        self.timerLabel.text = [NSString stringWithFormat:@"%i", self.seconds];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    NSString *currentLatitude = [[NSString alloc]
                                 initWithFormat:@"%g",
                                 newLocation.coordinate.latitude];
    self.latitude.text = currentLatitude;
    
    NSString *currentLongitude = [[NSString alloc]
                                  initWithFormat:@"%g",
                                  newLocation.coordinate.longitude];
    self.longitude.text = currentLongitude;
    NSString *currentAltitude = [[NSString alloc]
                                 initWithFormat:@"%gm",
                                 newLocation.altitude];
    self.elevation.text = currentAltitude;
    
    if (startLocation == nil)
        self.startLocation = newLocation;
    
    CLLocationDistance distanceBetween = [newLocation
                                          distanceFromLocation:startLocation];
    
    NSString *tripString = [[NSString alloc]
                            initWithFormat:@"%fm",
                            distanceBetween];
    self.distance.text = tripString;
}

@end
