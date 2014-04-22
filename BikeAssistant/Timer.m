//
//  Timer.m
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/27/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "Timer.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation Timer

-(id) initWithLabels:(UILabel *)intervalLabel name:(NSString *)name{
    
    self = [self init];
    if(self){
        //timerNameLabel = intervalLabel;
        timerLabel = intervalLabel;
        intervalName = name;
        totalTime = [NSNumber numberWithInt:0];
        lib = [[CommonLibrary alloc]init];
        interval = [[Interval alloc] initWithDefaults];
        repeat = false;
        isRunning = false;
    }
    return self;
}

- (BOOL) isDistanceSet{
    if(distanceSet == false){
        return false;
    }
    else{
        return true;
    }
}

- (void) setDistance{
    if(distanceSet == false){
        distanceSet = true;
    }
    else{
        distanceSet = false;
    }
    
}

- (void) updateLabel:(UILabel *)intervalLabel{
    timerLabel = intervalLabel;
}

- (int) getTotalTime{
    return (int) [totalTime integerValue];
}

- (BOOL) isRunning{
    return isRunning;
}

- (void) setTimerName:(NSString *)name{
    intervalName = name;
}

- (NSNumber *) timerStart{
    NSNumber *timerStarted;
    [interval getInterval:intervalName];
    NSLog(@"IntervalName: %@", intervalName);
    totalTime = [NSNumber numberWithInt:0];
    
    
    if(![[interval getTimeName]  isEqual: @"NULL"]){
        
        
        time = [interval getTimer];
        timerName = [interval getTimeName];
        [self timer];
        isRunning = true;
        timerStarted = [NSNumber numberWithInt:0];
    }
    else{
        timerLabel.text = @"No Timer Selected";
        timerStarted = [NSNumber numberWithInt:1];
    }
    
    return timerStarted;
}

- (void) setRepeat:(BOOL)repeatIn{
    repeat = repeatIn;
}

- (BOOL) didTimerFinish{
    BOOL didFinish = false;
    if(time == [NSNumber numberWithInt:-1]){
        didFinish = true;
    }
    
    return didFinish;
}

- (BOOL) didIntervalFinish{
    
    return [interval isLastTimer];
    
}

- (NSString *) getIntervalName{
    return [interval getIntervalName];
}

- (NSString *)concatLabelName{
    return [timerName stringByAppendingFormat:@": %@", [self formatTime]];
}

- (void) updateLabels{
   
    if([self didTimerFinish] == false){
        //timerNameLabel.text = timerName;
        timerLabel.text = [self concatLabelName];
    }
    else if ([self didIntervalFinish] == false){
        NSLog(@"Sound played");
        SystemSoundID soundID = systemSoundID;
        AudioServicesPlaySystemSound (soundID);
        [[[LocationManager sharedInstance] history] prepIntervalData];
        [[[LocationManager sharedInstance] history] addIntervalData];
        
        [interval getNextTimer];
        time = [interval getTimer];
        timerName = [interval getTimeName];
        
        //timerNameLabel.text = timerName;
        timerLabel.text = [self concatLabelName];
    }
    else{
        /**
        [[[LocationManager sharedInstance] history] prepIntervalData];
        [[[LocationManager sharedInstance] history] addIntervalData];
        
        [[[LocationManager sharedInstance] history] addInterval];
        
        [[[LocationManager sharedInstance] history] setTime:[NSNumber numberWithInt:[LocationManager sharedInstance].timeElapsed]];
        [[[LocationManager sharedInstance] history] saveHistory];
         */
        if(repeat == false){
            [self stopTimer];
        
            timerLabel.text = [self concatLabelName];
        }
        else{
            [interval resetTimer];
            time = [interval getTimer];
            timerName = [interval getTimeName];
            timerLabel.text = [self concatLabelName];
        }
    }
    int tempTime = (int) [time integerValue];
    tempTime--;
    time = [NSNumber numberWithInt:tempTime];
    tempTime = (int) [totalTime integerValue];
    tempTime++;
    totalTime = [NSNumber numberWithInt:tempTime];
    NSLog(@"TotalTime: %@", totalTime);
}
- (BOOL) isRepeat{
    return repeat;
}

- (NSString *) getIntervalTimeName{
    return  [interval getTimeName];
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
    isRunning = false;
    [interval resetTimer];
    time = [interval getTimer];
    timerName = [interval getTimeName];
    
    if([[[LocationManager sharedInstance]timer] isDistanceSet] == true){
        
        [[[LocationManager sharedInstance]timer] setDistance];
        
    }
    
}

-(void) fixTime {
    
    int ihours, iminutes, iseconds;
    int seconds = (int) [time integerValue]  ;
    ihours = (int) [[lib timeToHours:seconds] integerValue];
    iminutes = (int) [[lib timeToMinutes:seconds] integerValue];
    iseconds = (int) [[lib timeToSeconds:seconds] integerValue];
    
    
    
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
    int seconds = (int) [time integerValue];
    ihours = (int) [[lib timeToHours:seconds] integerValue];
    iminutes = (int) [[lib timeToMinutes:seconds] integerValue];
    iseconds = (int) [[lib timeToSeconds:seconds] integerValue];
    
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
