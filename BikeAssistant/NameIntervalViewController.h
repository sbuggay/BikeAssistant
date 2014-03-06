//
//  NameIntervalViewController.h
//  BikeAssistant
//
//  Created by Benjamin Skipper on 3/5/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonLibrary.h"
#import "Interval.h"

@interface NameIntervalViewController : UIViewController
- (IBAction)nextButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) Interval *interval;

@end
