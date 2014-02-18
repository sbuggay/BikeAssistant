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
    
    
    //Check to see if name and time were inputted
    //Verify name is unique to THIS interval
    //Update Interval object
    self.interval.intervalName = [_iName text];
    self.interval.seconds = [[_iSeconds text] intValue];
    
    [self performSegueWithIdentifier:@"returnToCreateInterval" sender:self];
   
}

-(void) viewDidLoad {
    self.interval.intervalName = @"Default";
}

- (IBAction)goBackToFirstView:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
