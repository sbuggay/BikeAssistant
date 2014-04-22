//
//  SaveRouteTableViewController.m
//  BikeAssistant
//
//  Created by Devan Buggay on 4/21/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "SaveRouteTableViewController.h"

#import "RouteManager.h"

@interface SaveRouteTableViewController ()

@end

@implementation SaveRouteTableViewController

@synthesize route;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    NSLog(@"saving");
    [[RouteManager sharedInstance] currentRoute].metadata = [GPXMetadata alloc];
    [[[RouteManager sharedInstance] currentRoute] metadata].name = [_NameField text];
    NSLog(@"%@|%@", [_NameField text], [[[RouteManager sharedInstance] currentRoute] metadata].name);
    [[RouteManager sharedInstance] saveCurrentRoute];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
