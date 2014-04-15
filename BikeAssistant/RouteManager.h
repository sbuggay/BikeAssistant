//
//  RouteManager.h
//  BikeAssistant
//
//  Created by Devan Buggay on 3/31/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Route.h"
#import "Timer.h"

@interface RouteManager : NSObject
@property (strong, nonatomic) NSMutableArray *routes;

@property Route *currentRoute;
@property Timer *currentTimer;
@property BOOL hasUpdated;

+(RouteManager *)sharedInstance;

-(void)loadRouteList;

-(void)saveRoute:(Route *)route;

@end
