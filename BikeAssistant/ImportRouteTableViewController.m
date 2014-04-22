//
//  ImportRouteTableViewController.m
//  BikeAssistant
//
//  Created by Devan Buggay on 4/21/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "ImportRouteTableViewController.h"


#import <GPX/GPX.h>
#import "RouteManager.h"

@interface ImportRouteTableViewController ()

@end

@implementation ImportRouteTableViewController

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

    NSLog(@"%@", [_NameField text]);
    NSLog(@"%@", [_URLField text]);
    
    NSURL * url = [NSURL URLWithString:[_URLField text]];
    
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    if (data != nil) {
        NSLog(@"\nis not nil");
        NSString *readdata = [[NSString alloc] initWithContentsOfURL:url encoding:NSASCIIStringEncoding error:NULL];
        NSLog(@"%@", readdata);
    }
    
    GPXRoot *root = [GPXParser parseGPXWithData:data];
    
    CLLocationCoordinate2D coors[[[root waypoints] count]];
    
    int i = 0;
    for (GPXRoutePoint *routepoint in [root waypoints]) {
        coors[i] = CLLocationCoordinate2DMake(routepoint.latitude, routepoint.longitude);
        NSLog(@"%f | %f", routepoint.latitude, routepoint.longitude);
        i++;
    }
    
    root.metadata = [GPXMetadata alloc];
    
    root.metadata.name = [_NameField text];
    
    NSLog(@"%@", [[root metadata] name]);
    
    
    [[RouteManager sharedInstance] saveRoute:root];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
