//
//  TimerViewController.m
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/28/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()


- (IBAction)startButton:(id)sender;

@property (nonatomic, strong) IBOutlet UILabel *timerNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *timerLabel;
@property (nonatomic, strong) IBOutlet UITextField *intervalField;

@end

@implementation TimerViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

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
    
    if(_timer == nil)
        _timer = [[Timer alloc]init];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButton:(id)sender {
    [_timer stopTimer];
    _timer = [[Timer alloc] initWithLabels:_timerNameLabel label:_timerLabel name:[_intervalField text]];
    [_timer timerStart];
}
@end
