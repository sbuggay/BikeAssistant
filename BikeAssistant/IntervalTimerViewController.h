//
//  IntervalTimerViewController.h
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/22/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntervalTimerViewController : UITableViewController

- (IBAction)getIntervalName:(id)sender;
-(void)timer;
-(void) updateLabel:(NSTimer *) timer;
-(void) fixTime;
-(NSString *) formatTime;
- (IBAction)startTimerButton:(id)sender;

@property int seconds, minutes, hours;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *intervalTimerLabel;

@end
