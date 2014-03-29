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

#import <IASKAppSettingsViewController.h>


@interface MainViewController ()


@end

@implementation MainViewController

- (void)viewDidLoad {
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
    
    startLocation = [locationManager location];
    
    [_map setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    CLLocationCoordinate2D noLocation;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 500, 500);
    MKCoordinateRegion adjustedRegion = [self.map regionThatFits:viewRegion];
    [self.map setRegion:adjustedRegion animated:YES];
    self.map.showsUserLocation = YES;

    
    NSString *file=[[NSBundle mainBundle] pathForResource:@"Auburn__Alabama" ofType:@"gpx"];
    
    NSData *fileData = [NSData dataWithContentsOfFile:file];

    
    [GPXParser parse:fileData completion:^(BOOL success, GPX *gpx) {
        CLLocationCoordinate2D coordinates[[[gpx waypoints]count]];
        int i = 0;
        NSLog(@"%@", [gpx waypoints]);
        for (Waypoint *ckpt in [gpx waypoints])
        {
            coordinates[i] = CLLocationCoordinate2DMake([ckpt latitude] , [ckpt longitude]);
            i++;
            NSLog(@"%f | %f", [ckpt latitude], [ckpt longitude]);
        }
        
        MKPolyline *route = [MKPolyline polylineWithCoordinates: coordinates count: [[gpx waypoints] count]];
        [_map addOverlay:route];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CLLocationManager

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%f", [[defaults objectForKey:@"weight"] floatValue]);
    
    //simply get the speed provided by the phone from newLocation
    double gpsSpeed = newLocation.speed;
    
    if (gpsSpeed < 0)
        gpsSpeed = 0;
    
    _locationLabel1.text = [NSString stringWithFormat:@"%3.3f", gpsSpeed * 2.23694];
    
    
    double totalWeight = [[defaults objectForKey:@"weight"] floatValue];
    double distance = abs([newLocation distanceFromLocation:startLocation]);
    double totalTime = .033;
    double resistance = .1;
    // Calories Burned Formula
//    double caloriesBurned = ((.046 * (distance/totalTime) * totalWeight) + (.066 * pow((distance/totalTime), 3)) * totalTime);
//    _caloriesLabel.text = [NSString stringWithFormat: @"Calories Burned: %f.2", caloriesBurned];
    // Watts Generated Formula
    double wattsGenerated = (totalWeight * resistance * distance) / totalTime;
    _metricsLabel1.text = [NSString stringWithFormat: @"%.2f", distance];
    
}


#pragma mark MKMapView

-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {

    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor blueColor];
    polylineView.lineWidth = 5.0;
    return polylineView;
    
}

#pragma mark ActionSheet

- (IBAction)showActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                                        destructiveButtonTitle:nil
                                                    otherButtonTitles:@"New Route", @"Load Route", @"Settings", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIStoryboard *storyBoard = [self storyboard];
     IASKAppSettingsViewController *settingsViewController  = [storyBoard instantiateViewControllerWithIdentifier:@"settings"];
    
    switch (buttonIndex) {
        
        case 0:
            
            

            break;
            
        case 1:
            
            break;
            
        case 2:
            [self.navigationController pushViewController:settingsViewController animated:YES];
            break;
        
        default:
            
            break;
    }
}





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddPlayer"]) {
        
//        UINavigationController *navigationController = segue.destinationViewController;
//        LocationViewController *locationViewController = [navigationController viewControllers][0];
//        locationViewController.delegate = self;
    }
}
@end
