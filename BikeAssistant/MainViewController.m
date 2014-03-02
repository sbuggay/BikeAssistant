//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "MainViewController.h"

#import "SWRevealViewController.h"

#import "LocationViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Map";
    
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    [_map setUserTrackingMode:MKUserTrackingModeFollow animated:YES];

    
#warning this is test code for gpx
    NSString *file=[[NSBundle mainBundle] pathForResource:@"fells_loop" ofType:@"gpx"];
    
    NSData *fileData = [NSData dataWithContentsOfFile:file];

    [GPXParser parse:fileData completion:^(BOOL success, GPX *gpx) {
        NSLog(@"%@", [gpx waypoints]);
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CLLocationManager

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //simply get the speed provided by the phone from newLocation
    double gpsSpeed = newLocation.speed;
    
    _locationLabel1.text = [NSString stringWithFormat:@"%2.f", gpsSpeed * 2.23694];
    
    
//    MKPolyline *routeLine = [MKPolyline polylineWithCoordinates:_currentRoute.dataPoints count:[currentRoute.dataPoints count]];
//    [_map setVisibleMapRect:[routeLine boundingMapRect]]; //If you want the route to be visible
//    
//    [_map addOverlay:routeLine];
}


#pragma mark MKMapView

-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{

    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}

#pragma mark ActionSheet

- (IBAction)showActionSheet:(id)sender {
    NSLog(@"action");
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:@"Cancel"
                                                        destructiveButtonTitle:@"Delete Route"
                                                    otherButtonTitles:@"Example", @"Action sheet", nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddPlayer"]) {
        
//        UINavigationController *navigationController = segue.destinationViewController;
//        LocationViewController *locationViewController = [navigationController viewControllers][0];
//        locationViewController.delegate = self;
    }
}
@end
