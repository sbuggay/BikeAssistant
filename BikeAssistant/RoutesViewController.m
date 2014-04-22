//
//  RoutesViewController.m
//  BikeAssistant
//
//  Created by Devan Buggay on 2/28/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "RoutesViewController.h"

#import <SWRevealViewController.h>

#import "ImportRouteTableViewController.h"

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
    
//    NSString *file=[[NSBundle mainBundle] pathForResource:@"Auburn__Alabama" ofType:@"gpx"];
//    
//    NSData *fileData = [NSData dataWithContentsOfFile:file];
//    
//    
//    [GPXParser parse:fileData completion:^(BOOL success, GPX *gpx) {
//        Route *temp = [[Route alloc] init];
//        temp.gpx = gpx;
//        [_routes addObject:temp];
//        NSLog(@"%@", temp.gpx.filename);
//    }];
//

    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Import" style:UIBarButtonItemStylePlain target:self action:@selector(import)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}

-(void)import {
    
    UIStoryboard *storyBoard = [self storyboard];
    ImportRouteTableViewController *saveRoute = [storyBoard instantiateViewControllerWithIdentifier:@"importRoute"];
    
    UINavigationController *saveRouteNavigationController = [[UINavigationController alloc] initWithRootViewController:saveRoute];
    
    [self presentViewController:saveRouteNavigationController animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [RouteManager sharedInstance].currentRoute = [[[RouteManager sharedInstance] routes] objectAtIndex:indexPath.row];
    NSLog(@"didSelect name:%@", [[RouteManager sharedInstance] currentRoute].metadata.name);
    [self performSegueWithIdentifier:@"toMain" sender:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[RouteManager sharedInstance] routes] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[[[[RouteManager sharedInstance] routes] objectAtIndex:indexPath.row] metadata] name];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    // Get the object we are going to move
    NSString *buff = [[NSString alloc] init];
    buff = [_routes objectAtIndex:[destinationIndexPath row]];
    
    // We will delete and move it to another location so well have to retain it
    //[task retain];
    
    // Remove it an move it to other place
    [_routes removeObjectAtIndex:[sourceIndexPath row]];
    [_routes insertObject:buff atIndex:[destinationIndexPath row]];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return YES;
    }
    return YES;
}

@end
