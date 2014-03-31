//
//  AddIntervalViewController.h
//  BikeAssistant
//
//  Created by Devan Buggay on 2/16/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interval.h"
#import "CreateIntervalViewController.h"
#import "CommonLibrary.h"


@interface AddIntervalViewController : UIViewController
{
    
}
@property (weak, nonatomic) NSNumber *incomingTimerIndex;
@property (strong, nonatomic) Interval *interval;
@property (weak, nonatomic) IBOutlet UITextField *iName;
@property (weak, nonatomic) IBOutlet UITextField *iHours;
@property (weak, nonatomic) IBOutlet UITextField *iMinutes;
@property (weak, nonatomic) IBOutlet UITextField *iSeconds;
- (IBAction)addButton:(id)sender;




@end
