//
//  RoutesViewController.h
//  BikeAssistant
//
//  Created by Devan Buggay on 2/28/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoutesViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property NSMutableArray *routes;

@end
