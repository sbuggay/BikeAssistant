//
//  Route.m
//  BikeAssistant
//
//  Created by Devan Buggay on 2/28/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "Route.h"

@implementation Route

@synthesize root;

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:root forKey:@"root"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [[Route alloc] init];
    if (self != nil)
    {
        root = [coder decodeObjectForKey:@"root"];
    }
    return self;
}

@end
