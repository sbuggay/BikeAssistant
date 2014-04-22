//
//  MetricsViewController.m
//  BikeAssistant
//
//  Created by Devan Buggay on 3/3/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "MetricsViewController.h"

@interface MetricsViewController ()

@end

@implementation MetricsViewController

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
    _wattsLabel.text = [NSString stringWithFormat: @"%.2f", globalWatts];
    _caloriesLabel.text = [NSString stringWithFormat: @"%.2f", globalCals];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


@implementation Stats
- (id) initWithDefaults{
    resistance = .1;
    time = 0;
    distance = 0.0;
    return self;
}

- (void)calculateStats
{
    float startDistance = [[LocationManager sharedInstance] startDistance];
    float currentDistance = [[LocationManager sharedInstance] currentDistance];
    time = [[[LocationManager sharedInstance] timer] getTotalTime];
    //abs([newLocation distanceFromLocation:startLocation]);
    
    distance = currentDistance - startDistance;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    weight = [[defaults objectForKey:@"weight"] floatValue];
    // Calories Burned Formula
    calBurnt = ((.046 * (distance/time) * weight) + (.066 * pow((distance/time), 3)) * time);
    globalCals = calBurnt;
    // Watts Generated Formula
    watts = (weight * resistance * distance) / time;
    globalWatts = watts;
}
@end