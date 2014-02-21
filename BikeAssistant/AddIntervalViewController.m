//
//  AddIntervalViewController.m
//  BikeAssistant
//
//  Created by Devan Buggay on 2/16/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "AddIntervalViewController.h"


@implementation AddIntervalViewController

- (IBAction)finishedButton:(id) sender {
    
    int totalSeconds = 0;
    
    //Check to see if name and time were inputted
    //Verify name is unique to THIS interval
    //Update Interval object
    
    totalSeconds = [[_iHours text] intValue] * 3600;
    totalSeconds += [[_iMinutes text] intValue] * 60;
    totalSeconds += [[_iSeconds text] intValue];
    
    self.intervalTimer.intervalName = [_iName text];
    self.intervalTimer.seconds = &(totalSeconds);

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.intervalTimer.intervalName =  [NSString stringWithFormat:@"%@%@", self.intervalTimer.intervalName,[defaults valueForKey:@"intervalName"]];
    NSString *myTime = [NSString stringWithFormat:@"%i", *self.intervalTimer.seconds];

    [defaults setValue:self.intervalTimer.intervalName forKey:self.intervalTimer.intervalName];
    [defaults setValue:myTime forKey:[NSString stringWithFormat:@"%@Timer", self.intervalTimer.intervalName]];
    
    [self performSegueWithIdentifier:@"returnToCreateInterval" sender:self];
   
}

-(void) viewDidLoad {
    self.intervalTimer.intervalName = @"Default";
}

- (IBAction)goBackToFirstView:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
