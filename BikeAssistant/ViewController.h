//
//  ViewController.h
//  BikeAssistant
//
//  Created by Devan Buggay on 1/13/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<CLLocationManagerDelegate>
{


@property int seconds, minutes, hours;
- (IBAction)startTimerButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *intervalTimerLabel;

@end
