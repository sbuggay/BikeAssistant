//
//  ViewController.m
//  BikeAssistant
//
//  Created by Devan Buggay on 1/13/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property BOOL isFinalIntervalTimer;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

-(void)timer {
    self.seconds = 10;
    self.minutes = 1;
    self.hours = 0;
    
    self.intervalTimerLabel.text = @"Warm up";
    NSTimer* timer = [NSTimer timerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(updateLabel:)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

-(void) updateLabel:(NSTimer *) timer {
    [self fixTime];
    self.seconds--;
    //self.timerLabel.text = [NSString stringWithFormat:@"%i", self.seconds];
    self.timerLabel.text = [self formatTime];
    if (self.seconds == 0 && !self.isFinalIntervalTimer && self.minutes == 0 && self.hours == 0)
    {
        self.intervalTimerLabel.text = @"Cool Down";
        self.isFinalIntervalTimer = YES;
        self.seconds = 20;
        
    }
    else if (self.seconds == 0 && self.minutes == 0 && self.hours == 0)
    {
        [timer invalidate];
        [self.startButton setEnabled:YES];
        self.intervalTimerLabel.text = @"My Interval Timer";
    }
}


-(void) fixTime {
    int hours, minutes, seconds;
    hours = self.hours;
    minutes = self.minutes;
    seconds = self.seconds;
    
    
    
    if(seconds == 0){
        if(minutes == 0){
            if(hours == 0){
                //timer ended
            }
            else{
                self.hours--;
                self.minutes = 60;
                self.seconds = 60;
            }
        }
        else{
            self.minutes--;
            self.seconds = 60;
            
        }
    }
    else{
        
    }
    
}

-(NSString *) formatTime {
    
    NSString *sHours, *sMinutes, *sSeconds;
    sHours = [NSString stringWithFormat:@""];
    sMinutes = [NSString stringWithFormat:@""];
    sSeconds = [NSString stringWithFormat:@""];
    
    if(self.hours < 10){
        sHours = [sHours stringByAppendingFormat:@"0"];
        sHours = [sHours stringByAppendingFormat:@"%i",self.hours];
    }
    else{
        sHours = [sHours stringByAppendingFormat:@"%i",self.hours];
    }
    
    if(self.minutes < 10){
        sMinutes = [sMinutes stringByAppendingFormat:@"0"];
        sMinutes = [sMinutes stringByAppendingFormat:@"%i",self.minutes];
    }
    else{
        sMinutes = [sMinutes stringByAppendingFormat:@"%i",self.minutes];
    }
    
    if(self.seconds < 10){
        sSeconds = [sSeconds stringByAppendingFormat:@"0"];
        sSeconds = [sSeconds stringByAppendingFormat:@"%i",self.seconds];
    }
    else{
        sSeconds = [sSeconds stringByAppendingFormat:@"%i",self.seconds];
    }
    
    
    NSString *formattedTime = [NSString stringWithFormat:@"%@:", sHours];
    formattedTime = [formattedTime stringByAppendingFormat:@"%@:",sMinutes];
    formattedTime = [formattedTime stringByAppendingFormat:@"%@", sSeconds];
    return formattedTime;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startTimerButton:(id)sender {
    self.isFinalIntervalTimer = NO;
    [self.startButton setEnabled:NO];
    [self timer];
}


- (IBAction)getIntervalName:(id)sender {

    
    //[self performSegueWithIdentifier:@"returnToCreateInterval" sender:self];
}
@end
