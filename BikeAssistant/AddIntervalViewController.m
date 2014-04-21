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
    NSNumber *addButCheck = [NSNumber numberWithInt:-1];
    if(_incomingTimerIndex != addButCheck){
        CommonLibrary *cLibrary = [[CommonLibrary alloc] init];
        NSMutableArray *iTimers = [[NSMutableArray alloc] init];
        iTimers = [[_interval getTimers] mutableCopy];
        int timerIndex = [_incomingTimerIndex intValue] * 2;
        _iName.text = iTimers[timerIndex];
        int totalSeconds = (int) [iTimers[timerIndex + 1] integerValue];
        _iHours.text = [[cLibrary timeToHours:totalSeconds] stringValue];
        _iMinutes.text = [[cLibrary timeToMinutes:totalSeconds] stringValue];
        _iSeconds.text = [[cLibrary timeToSeconds:totalSeconds] stringValue];
    }
   
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
    
    if ([_incomingTimerIndex intValue] != -1)
    {
        NSMutableArray *iTimers = [[NSMutableArray alloc] init];
        iTimers = [[_interval getTimers] mutableCopy];
        int timerIndex = [_incomingTimerIndex intValue] * 2;
        iTimers[timerIndex] = _iName.text;
        iTimers[timerIndex + 1] = [NSString stringWithFormat:@"%d", totalSeconds];
        [_interval updateTimers:iTimers];
        //[_interval saveInterval];
    }
    else
    {
        [_interval addTimer:seconds newTimerName:[_iName text]];
    }
    
    [self performSegueWithIdentifier:@"returnToCreateInterval" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CreateIntervalViewController *vc = [segue destinationViewController];
    vc.interval = _interval;
}
@end
