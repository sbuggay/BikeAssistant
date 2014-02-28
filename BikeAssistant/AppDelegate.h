//
//  AppDelegate.h
//  BikeAssistant
//
//  Created by Devan Buggay on 1/13/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PKRevealController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, PKRevealing>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PKRevealController *revealController;

@end
