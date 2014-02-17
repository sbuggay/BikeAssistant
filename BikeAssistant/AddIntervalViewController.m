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
    //Display message that adding was successful
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Interval Added Successfully. Press back if you're done." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    
       
    //Prepare for additional timers by clearing inputs
}

-(void) viewDidLoad {
    self.interval.intervalName = @"test2";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    
    
   
    
}

@end
