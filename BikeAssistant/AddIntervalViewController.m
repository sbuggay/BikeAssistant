//
//  AddIntervalViewController.m
//  BikeAssistant
//
//  Created by Devan Buggay on 2/16/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "AddIntervalViewController.h"


@implementation AddIntervalViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



-(void) viewDidLoad {
    
    NSMutableArray *iTimers = [[NSMutableArray alloc] init];
    NSNumber *addButCheck = [NSNumber numberWithInt:-1];
    if(_incomingTimerIndex != addButCheck){
        iTimers = [[_interval getTimers:_interval.getIntervalName] mutableCopy];
    }
 //   NSString * output = [iTimers objectAtIndex:_incomingTimerIndex];
  //  _iName.text = iTimers[_incomingTimerIndex];

   
}

- (IBAction)goBackToFirstView:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)addButton:(id)sender {
    
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
@end
