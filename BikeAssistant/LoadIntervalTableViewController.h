//
//  LoadIntervalTableViewController.h
//  BikeAssistant
//
//  Created by Chauncey Philpot on 3/30/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interval.h"

@interface LoadIntervalTableViewController : UITableViewController{
    NSUserDefaults *globalDefaults;
    NSMutableDictionary *globalDictionary;
 

}


@property (strong, nonatomic) NSMutableArray* cellList;
@property (strong, nonatomic) Interval *interval;
@end
