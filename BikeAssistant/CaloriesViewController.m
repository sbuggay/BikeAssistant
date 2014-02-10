//
//  CaloriesViewController.m
//  BikeAssistant
//
//  Created by Samuel Haars on 2/6/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "CaloriesViewController.h"

@interface CaloriesViewController ()

@end

@implementation CaloriesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self timer];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults valueForKey:@"weight"]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Your weight has not been set!"
                                                          message:@"Please head over to settings to set this."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
    }

    
}

- (void)viewDidAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [_heightLabel setText:[NSString stringWithFormat:@"%ld", [defaults integerForKey:@"height"]]];
    [_weightLabel setText:[NSString stringWithFormat:@"%ld", [defaults integerForKey:@"weight"]]];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)timer{
    NSTimer* timer = [NSTimer timerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(updateLabel:)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)updateLabel:(NSTimer *) timer{
    self.totalWeight = 180;
    self.distance = 1;
    self.totalTime = .033;
    self.resistance = .1;
    // Calories Burned Formula
    double caloriesBurned = ((.046 * (_distance/_totalTime) * _totalWeight) + (.066 * pow((_distance/_totalTime), 3)) * _totalTime);
    _caloriesLabel.text = [NSString stringWithFormat: @"Calories Burned: %f.2", caloriesBurned];
    // Watts Generated Formula
    double wattsGenerated = (_totalWeight * _resistance * _distance) / _totalTime;
    _wattsLabel.text = [NSString stringWithFormat: @"Watts Generated: %f.2", wattsGenerated];
}

@end
