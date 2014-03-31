//
//  Timer.m
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/27/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "Timer.h"

@implementation Timer

-(id) initWithLabels:(UILabel *)intervalLabel name:(NSString *)name{
    
    self = [self init];
    if(self){
        //timerNameLabel = intervalLabel;
        timerLabel = intervalLabel;
        intervalName = name;
        lib = [[CommonLibrary alloc]init];
        interval = [[Interval alloc] initWithDefaults];
        repeat = false;
    }
    return self;
}

- (void) timerStart{
    [self stopTimer];
    [interval getInterval:intervalName];
    time = [interval getTimer];
    timerName = [interval getTimeName];
    [self timer];
    
    
}

- (void) repeat{
    repeat = true;
}

- (void) noRepeat{
    repeat = false;
}

- (BOOL) didTimerFinish{
    BOOL didFinish = false;
    if(time == [NSNumber numberWithInt:0]){
        didFinish = true;
    }
    
    return didFinish;
}

- (BOOL) didIntervalFinish{
    
    if(repeat == true){
        [interval resetTimer];
        return [interval isLastTimer];
    }
    else{
        return [interval isLastTimer];
    }
}

- (NSString *)concatLabelName{
    return [timerName stringByAppendingString:[self formatTime]];
}

- (void) updateLabels{
   
    if([self didTimerFinish] == false){
        //timerNameLabel.text = timerName;
        timerLabel.text = [self concatLabelName];
    }
    else if ([self didIntervalFinish] == false){
        [interval getNextTimer];
        time = [interval getTimer];
        timerName = [interval getTimeName];
        
        //timerNameLabel.text = timerName;
        timerLabel.text = [self concatLabelName];
    }
    else{
        [self stopTimer];
        //timerNameLabel.text = @"Finished";
        timerLabel.text = [self concatLabelName];
    }
    int tempTime = [time integerValue];
    tempTime--;
    time = [NSNumber numberWithInt:tempTime];
}

-(void)timer{
    
    
    timerLabel.text = timerName;
    timer = [NSTimer timerWithTimeInterval:1.0f
                                            target:self
                                           selector:@selector(updateLabels)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

-(void) stopTimer{
    [timer invalidate];
    timer = nil;
}

-(void) fixTime {
    
    int ihours, iminutes, iseconds;
    int seconds = [time integerValue];
    ihours = [[lib timeToHours:seconds] integerValue];
    iminutes = [[lib timeToMinutes:seconds] integerValue];
    iseconds = [[lib timeToSeconds:seconds] integerValue];
    
    
    
    if(iseconds == 0){
        if(iminutes == 0){
            if(ihours == 0){
                //timer ended
            }
            else{
                ihours--;
                iminutes = 60;
                iseconds = 60;
                //hours = [NSNumber numberWithInt:ihours];
                //minutes = [NSNumber numberWithInt:iminutes];
                //seconds = [NSNumber numberWithInt:iseconds];
            }
        }
        else{
            iminutes--;
            //minutes = [NSNumber numberWithInt:iminutes];
            //seconds = [NSNumber numberWithInt:iseconds];
            
        }
    }
    else{
        
    }
    
}

-(NSString *) formatTime {
    
    NSString *sHours, *sMinutes, *sSeconds;
    
    int ihours, iminutes, iseconds;
    int seconds = [time integerValue];
    ihours = [[lib timeToHours:seconds] integerValue];
    iminutes = [[lib timeToMinutes:seconds] integerValue];
    iseconds = [[lib timeToSeconds:seconds] integerValue];
    
    sHours = [NSString stringWithFormat:@""];
    sMinutes = [NSString stringWithFormat:@""];
    sSeconds = [NSString stringWithFormat:@""];
    
    if(ihours < 10){
        sHours = [sHours stringByAppendingFormat:@"0"];
        sHours = [sHours stringByAppendingFormat:@"%i",ihours];
    }
    else{
        sHours = [sHours stringByAppendingFormat:@"%i",ihours];
    }
    
    if(iminutes < 10){
        sMinutes = [sMinutes stringByAppendingFormat:@"0"];
        sMinutes = [sMinutes stringByAppendingFormat:@"%i", iminutes];
    }
    else{
        sMinutes = [sMinutes stringByAppendingFormat:@"%i", iminutes];
    }
    
    if(iseconds < 10){
        sSeconds = [sSeconds stringByAppendingFormat:@"0"];
        sSeconds = [sSeconds stringByAppendingFormat:@"%i", iseconds];
    }
    else{
        sSeconds = [sSeconds stringByAppendingFormat:@"%i", iseconds];
    }
    
    
    NSString *formattedTime = [NSString stringWithFormat:@"%@:", sHours];
    formattedTime = [formattedTime stringByAppendingFormat:@"%@:",sMinutes];
    formattedTime = [formattedTime stringByAppendingFormat:@"%@", sSeconds];
    return formattedTime;
}

@end
