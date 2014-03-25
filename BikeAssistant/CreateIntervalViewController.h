//
//  CreateIntervalViewController.h
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/15/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddIntervalViewController.h"
#import "Interval.h"

@interface CreateIntervalViewController : UITableViewController
{
    NSMutableArray *intervals;
    NSUserDefaults *defaults;
    NSMutableArray *myArray;
    NSMutableDictionary *dictionary;
    NSNumber *pressedButton;

}


@property (strong, nonatomic) Interval *myInterval;


@end
