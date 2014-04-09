//
//  RouteManager.h
//  BikeAssistant
//
//  Created by Devan Buggay on 3/31/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Route.h"

@interface RouteManager : NSObject

@property (strong, nonatomic) NSMutableArray *routes;

+(RouteManager *)sharedInstance;

-(void)loadRouteList;

-(void)saveRoute:(Route *)route;

@end
