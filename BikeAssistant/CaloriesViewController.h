//
//  CaloriesViewController.h
//  BikeAssistant
//
//  Created by Samuel Haars on 2/6/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaloriesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *caloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *wattsLabel;
@property double totalWeight, distance, totalTime, resistance;
@end
