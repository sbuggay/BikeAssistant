//
//  Route.m
//  BikeAssistant
//
//  Created by Devan Buggay on 2/28/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "Route.h"

@implementation Route

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:aLabel forKey:@"label"];
    [coder encodeInteger:aNumberID forKey:@"numberID"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [[CustomObject alloc] init];
    if (self != nil)
    {
        aLabel = [coder decodeObjectForKey:@"label"];
        aNumberID = [coder decodeIntegerForKey:@"numberID"];
    }
    return self;
}

@end
