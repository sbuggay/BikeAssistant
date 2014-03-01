//
//  Route.h
//  BikeAssistant
//
//  Created by Devan Buggay on 2/28/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <GPXParser.h>

@interface Route : NSObject

@property NSString *name;
@property NSDate *date;
@property NSMutableArray *dataPoints;

@end