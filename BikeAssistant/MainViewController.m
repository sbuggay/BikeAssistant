//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <IASKAppSettingsViewController.h>
#import <AudioToolbox/AudioToolbox.h>

#import "MainViewController.h"

#import "SWRevealViewController.h"

#import "LocationViewController.h"

#import "LoadIntervalTableViewController.h"

#import "SaveRouteTableViewController.h"




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
    
    [LocationManager sharedInstance];
    
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

- (void) viewDidAppear:(BOOL)animated{
    
    if([LocationManager sharedInstance].timerLoaded == false || [LocationManager sharedInstance].intervalTimerAdded == true){
        [LocationManager sharedInstance].intervalTimerAdded = false;
        timer = [[Timer alloc]initWithLabels:_timerLabel name:@"NULL"];
        [LocationManager sharedInstance].timer = timer;
        [LocationManager sharedInstance].timerLoaded = true;
        
        history = [[History alloc]initWithDefaults];
        [LocationManager sharedInstance].history = history;
    }
    
    if([[[LocationManager sharedInstance] timer] isRunning] == true){
        _timerLabel.hidden = false;
        _hideButton.hidden = true;
        _hideStopTimer.hidden = false;
    }
    [[[LocationManager sharedInstance] timer] updateLabel:_timerLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newRoute {
    NSArray *pointsArray = [_map overlays];
    [_map removeOverlays:pointsArray];
    
    mapState = kCreatingRoute;
    
    [RouteManager sharedInstance].currentRoute = [GPXRoot rootWithCreator:NULL];
}

- (void)clearRoute {
    NSArray *pointsArray = [_map overlays];
    [_map removeOverlays:pointsArray];
    
    mapState = kNoRoute;
}

- (void)loadRoute {
    
}

- (void)saveRoute {
    
}

#pragma mark CLLocationManager

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
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
        double caloriesBurned = ((.046 * (distance/totalTime) * totalWeight) + (.066 * pow((distance/totalTime), 3)) * totalTime);
     //   _caloriesLabel.text = [NSString stringWithFormat: @"Calories Burned: %f.2", caloriesBurned];
     //Watts Generated Formula
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
                                             otherButtonTitles:@"New Route", @"Load Route", @"Load Interval", nil];
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
    SaveRouteTableViewController *saveRoute = [storyBoard instantiateViewControllerWithIdentifier:@"saveRoute"];
    LoadIntervalTableViewController *loadInterval = [storyBoard instantiateViewControllerWithIdentifier:@"loadInterval"];
    
    UINavigationController *saveRouteNavigationController = [[UINavigationController alloc] initWithRootViewController:saveRoute];

    
    switch (mapState) {
        case kNoRoute:
            switch (buttonIndex) {
                    
                case 0:
                    [self newRoute];
                    
                    
                    break;
                    
                case 1:
                    
                    
                    
                    
                    break;
                    
                case 2:
                    
                    
                    [self.navigationController pushViewController:loadInterval animated:YES];
                
//                    _interval = loadInterval.interval;
                    
                    
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
                    [self.navigationController presentViewController:saveRouteNavigationController animated:YES completion:NULL];

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
    
//    timer = [[Timer alloc]initWithLabels:_timerLabel name:_interval.getIntervalName];
    if([[[LocationManager sharedInstance] timer] isRunning] == true){
        [[[LocationManager sharedInstance] timer] stopTimer];
        [sender setTitle:@"Start Timer" forState:UIControlStateNormal];
        _timerLabel.hidden = true;
    }
    else{
        NSNumber *didTimerStart = [[[LocationManager sharedInstance] timer] timerStart];
        NSLog(@"Result of timerStart: %@", didTimerStart);
        if(didTimerStart == [NSNumber numberWithInt:0]){;
        
            [sender setTitle:@"Stop Timer" forState:UIControlStateNormal];
            _timerLabel.hidden = false;
        }
        else{
            _timerLabel.hidden = false;
            _timerLabel.text = @"No Timer Selected";
        }
    }

}

@end
