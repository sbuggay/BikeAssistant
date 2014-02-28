//
//  Timer.m
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/27/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "Timer.h"

@implementation Timer

-(id) initWithLabels:(UILabel *)intervalLabel label:(UILabel *)timerLabelIn name:(NSString *)nameIn{
    
    timerNameLabel = intervalLabel;
    timerLabel = timerLabelIn;
    intervalName = nameIn;
    lib = [[CommonLibrary alloc]init];
    inter = [[Interval alloc] init];
    
    return self;
}

- (void) timerStart{
    
}
- (void) updateLabels{
    
}

-(void)timer{
    
    timerNameLabel.text = timerName;
    NSTimer* timer = [NSTimer timerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(updateLabels:)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
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
