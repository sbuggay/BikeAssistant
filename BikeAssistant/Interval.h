//
//  Interval.h
//  BikeAssistant
//
//  Created by Devan Buggay on 2/16/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Interval : NSObject
@property (copy, nonatomic) NSString *intervalName;
@property (assign, nonatomic) NSInteger *seconds;

@end
