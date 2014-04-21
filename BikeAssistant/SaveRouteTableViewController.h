//
//  SaveRouteTableViewController.h
//  BikeAssistant
//
//  Created by Devan Buggay on 4/21/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"

@interface SaveRouteTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *NameField;

@property Route *route;

-(void)cancel;

@end
