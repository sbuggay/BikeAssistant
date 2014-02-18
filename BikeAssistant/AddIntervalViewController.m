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
    
    self.interval.intervalName = [_iName text];
    self.interval.seconds = &(totalSeconds);
    
    //NSString *alertMessage = @"Hours: %i Minutes:%i Seconds:%i", *hours, *minutes, *seconds;
    NSString *alertMessage;
    
    alertMessage = [NSString stringWithFormat:@"Hours: %i", totalSeconds];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    
    [self performSegueWithIdentifier:@"returnToCreateInterval" sender:self];
   
}

-(void) viewDidLoad {
    self.interval.intervalName = @"Default";
}

- (IBAction)goBackToFirstView:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
