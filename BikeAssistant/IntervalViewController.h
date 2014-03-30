//
//  IntervalViewController.h
//  BikeAssistant
//
//  Created by Devan Buggay on 3/4/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interval.h"
@interface IntervalViewController : UITableViewController{
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
@property (strong, nonatomic) Interval* interval;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;


@end
