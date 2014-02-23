//
//  Interval.m
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/20/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "Interval.h"

@implementation Interval

-(id)init{
    self = [super init];
    if(self){
        intervals = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)addTimer:(IntervalTimer *)myTimer{
    
}

-(void) saveCustomObject:(Interval *)obj{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    
    [defaults setObject:myEncodedObject forKey:@"intervals"];
}



@end
