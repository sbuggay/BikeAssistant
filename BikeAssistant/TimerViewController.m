//
//  TimerViewController.m
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/28/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *timerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@end

@implementation TimerViewController

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
    
    timer = [[Timer alloc] initWithLabels:_timerNameLabel label:_timerLabel name:@"test"];
    interval = [[Interval alloc] init];
	
}

-(IBAction)startButton:(id)sender{
    [timer timerStart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
