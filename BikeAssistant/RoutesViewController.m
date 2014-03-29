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
    [_routes addObject:@"Auburn__Fells route"];
    [_routes addObject:@"Auburn__Tour route"];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    cell.textLabel.text = [_routes objectAtIndex:indexPath.row];
    
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