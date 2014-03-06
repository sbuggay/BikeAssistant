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

    NSNumber *seconds = [NSNumber numberWithInt:totalSeconds];
    [_interval addTimer:seconds newTimerName:[_iName text]];

    [self performSegueWithIdentifier:@"returnToCreateInterval" sender:self];
   
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void) viewDidLoad {
   
}

- (IBAction)goBackToFirstView:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
