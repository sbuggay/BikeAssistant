//
//  ViewController.h
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <GPX/GPX.h>

#import "LocationManager.h"
#import "RouteManager.h"
#import "Interval.h"
#import "Timer.h"
#import "History.h"

typedef enum MapState : NSUInteger {
    kNoRoute,
    kFreeRide,
    kCreatingRoute,
    kFollowingRoute,
    kSelectInterval
} MapState;

@interface MainViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UIActionSheetDelegate> {
    CLLocationManager *locationManager;
    CLLocation *startLocation;
    GPXRoot *root;
    NSInteger mapState;
    
    History *history;
    Timer *timer;
}

- (IBAction)showActionSheet:(id)sender;

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButton;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *metricsButton;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel1;
@property (weak, nonatomic) IBOutlet UILabel *metricsLabel1;

- (void)newRoute;
- (void)saveRoute;
- (void)loadRoute;
- (void)clearRoute;

@end
