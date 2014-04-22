//
//  RouteManager.m
//  BikeAssistant
//
//  Created by Devan Buggay on 3/31/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "RouteManager.h"

@implementation RouteManager

@synthesize routes;
@synthesize currentRoute;
@synthesize currentTimer;
@synthesize hasUpdated;

+(RouteManager *)sharedInstance {
    static RouteManager *sharedSingleton;
    
    @synchronized(self) {
        if (!sharedSingleton)
            sharedSingleton = [[RouteManager alloc] init];
        return sharedSingleton;
    }
}

-(id)init {

    hasUpdated = NO;
    currentRoute = [[GPXRoot alloc] init];
    currentRoute.metadata = [GPXMetadata alloc];

    self.routes = [[NSMutableArray alloc] init];
    return self;
}

-(void)loadRouteList {
    NSUserDefaults *defaults;

    NSData *savedArray = [defaults objectForKey:@"routes"];
    if (savedArray != nil) {
        NSArray *oldArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedArray];
        if (oldArray != nil) {
            routes = [[NSMutableArray alloc] initWithArray:oldArray];
        } else {
            routes = [[NSMutableArray alloc] initWithCapacity:30];
        }
    }
    
}

-(void)saveCurrentRoute {
    [routes addObject:currentRoute];
    
    NSLog(@"%@", currentRoute.metadata.name);
    
    NSLog(@"saveRoute: %lu", [routes count]);
}

-(void)saveRoute:(GPXRoot *)route {
    
    [routes addObject:route];
    
    NSLog(@"%@", route.metadata.name);
    
    NSLog(@"saveRoute: %lu", [routes count]);
    
//    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:routes] forKey:@"routes"];

}

@end
