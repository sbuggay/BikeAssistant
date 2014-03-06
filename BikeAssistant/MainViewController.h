//
//  ViewController.h
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "Route.h"


@interface MainViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UIActionSheetDelegate> {
    CLLocationManager *locationManager;
    CLLocation *startLocation;
}

- (IBAction)showActionSheet:(id)sender;

@property Route *currentRoute;

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButton;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *metricsButton;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel1;
@property (weak, nonatomic) IBOutlet UILabel *metricsLabel1;


@end
