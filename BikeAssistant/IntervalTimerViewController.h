//
//  IntervalTimerViewController.h
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/22/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interval.h"

@interface IntervalTimerViewController : UITableViewController
{
    NSUserDefaults *globalDefaults;
    NSMutableDictionary *globalDictionary;
}
- (IBAction)getIntervalName:(id)sender;
-(void) updateLabel:(NSTimer *) timer;
-(NSString *) formatTime;
- (IBAction)startTimerButton:(id)sender;


@property int seconds, minutes, hours;

@property (weak, nonatomic) IBOutlet UILabel *intervalTimerLabel;
@property (strong, nonatomic) NSMutableArray* cellList;
@property (strong, nonatomic) Interval* myInterval;

@end
