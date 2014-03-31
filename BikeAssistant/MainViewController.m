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

#import "LoadIntervalTableViewController.h"


@interface MainViewController ()
- (IBAction)startTimer:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *hideButton;
- (IBAction)stopTimer:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *hideStopTimer;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _timerLabel.hidden = true;
    _hideStopTimer.hidden = true;
    self.title = @"Map";
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    mapState = kNoRoute;
    
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
    
    
    _interval = [[Interval alloc]initWithDefaults];
    
    
    //    [GPXParser parse:fileData completion:^(BOOL success, GPX *gpx) {
    //        CLLocationCoordinate2D coordinates[[[gpx waypoints]count]];
    //        int i = 0;
    //        NSLog(@"%@", [gpx waypoints]);
    //        for (Waypoint *ckpt in [gpx waypoints])
    //        {
    //            coordinates[i] = CLLocationCoordinate2DMake([ckpt latitude] , [ckpt longitude]);
    //            i++;
    //            NSLog(@"%f | %f", [ckpt latitude], [ckpt longitude]);
    //        }
    //
    //        MKPolyline *route = [MKPolyline polylineWithCoordinates: coordinates count: [[gpx waypoints] count]];
    //        [_map addOverlay:route];
    //
    //    }];
    
    
    root = [GPXParser parseGPXWithData:fileData];
    
    CLLocationCoordinate2D coors[[[root waypoints] count]];
    
    int i = 0;
    for (GPXRoutePoint *routepoint in [root waypoints]) {
        coors[i] = CLLocationCoordinate2DMake(routepoint.latitude, routepoint.longitude);
        NSLog(@"%f | %f", routepoint.latitude, routepoint.longitude);
        i++;
    }
    
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coors count:[[root waypoints] count]];
    [_map addOverlay:polyline];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newRoute {
    NSArray *pointsArray = [_map overlays];
    [_map removeOverlays:pointsArray];
    
    mapState = kCreatingRoute;
    
    root = [GPXRoot rootWithCreator:@"Free Ride"];
    NSLog(@"New Route has been started");
    NSLog(@"%lu", [[root waypoints] count]);
}

- (void)clearRoute {
    NSArray *pointsArray = [_map overlays];
    [_map removeOverlays:pointsArray];
    
    mapState = kNoRoute;
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
    
    
    
    
    
    //    GPX generator
    
    if(mapState == kCreatingRoute) {
    [root newWaypointWithLatitude:[newLocation coordinate].latitude longitude:[newLocation coordinate].longitude];
    
    CLLocationCoordinate2D coors[[[root waypoints] count]];
    
    int i = 0;
    for (GPXRoutePoint *routepoint in [root waypoints]) {
        coors[i] = CLLocationCoordinate2DMake(routepoint.latitude, routepoint.longitude);
        i++;
    }
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coors count:[[root waypoints] count]];
    [_map addOverlay:polyline];
    }
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
    UIActionSheet *actionSheet;
    switch (mapState) {
        case kNoRoute:
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"New Route", @"Load Route", @"Settings", @"Load Interval", nil];
            break;
            
        case kCreatingRoute:
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                        destructiveButtonTitle:@"Delete Route"
                                             otherButtonTitles:@"Save Route", @"Settings", nil];
            break;
            
        case kFollowingRoute:
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"New Route", @"Load Route", @"Settings", nil];
            break;
            
        case kSelectInterval:
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"New Route", @"Load Route", @"Settings", nil];
            break;
            
        default:
            break;
    }
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIStoryboard *storyBoard = [self storyboard];
    IASKAppSettingsViewController *settingsViewController  = [storyBoard instantiateViewControllerWithIdentifier:@"settings"];
    LoadIntervalTableViewController *loadInterval = [storyBoard instantiateViewControllerWithIdentifier:@"loadInterval"];
    
    
    switch (mapState) {
        case kNoRoute:
            switch (buttonIndex) {
                    
                case 0:
                    [self newRoute];
                    
                    
                    break;
                    
                case 1:
                    
                    break;
                    
                case 2:
                    [self.navigationController pushViewController:settingsViewController animated:YES];
                    break;
                case 3:
                    if(loadInterval.view){
                        loadInterval.interval = _interval;
                    }
                    [self.navigationController pushViewController:loadInterval animated:YES];
                    
                 
                default:
                    
                    break;
            }
            break;
        case kCreatingRoute:
            switch (buttonIndex) {
                    
                case 0:
                    [self clearRoute];
                    
                    
                    break;
                    
                case 1:
                    [self saveRoute];
                    break;
                    
                case 2:
                    
                    [self.navigationController pushViewController:settingsViewController animated:YES];
                    break;
                    
                default:
                    
                    break;
            }
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
- (IBAction)startTimer:(id)sender {

    timer = [[Timer alloc]initWithLabels:_timerLabel name:@"test"];
    [timer timerStart];
    _timerLabel.hidden = false;
    _hideButton.hidden = true;
    _hideStopTimer.hidden = false;
}


- (IBAction)stopTimer:(id)sender {
    [timer stopTimer];
    _timerLabel.hidden = true;
    _hideButton.hidden = false;
    _hideStopTimer.hidden = true;
}
    @end
