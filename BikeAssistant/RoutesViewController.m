//
//  RoutesViewController.m
//  BikeAssistant
//
//  Created by Devan Buggay on 2/28/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "RoutesViewController.h"

#import <SWRevealViewController.h>

@interface RoutesViewController ()

@end

@implementation RoutesViewController

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

    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _routes = [[NSMutableArray alloc] init];
    
    NSString *file=[[NSBundle mainBundle] pathForResource:@"Auburn__Alabama" ofType:@"gpx"];
    
    NSData *fileData = [NSData dataWithContentsOfFile:file];
    
    
    [GPXParser parse:fileData completion:^(BOOL success, GPX *gpx) {
        Route *temp = [[Route alloc] init];
        temp.gpx = gpx;
        [_routes addObject:temp];
        NSLog(@"%@", temp.gpx.filename);
    }];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_routes count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[[_routes objectAtIndex:indexPath.row] gpx] filename];
    
    return cell;
}

@end
