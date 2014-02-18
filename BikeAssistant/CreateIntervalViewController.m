//
//  CreateIntervalViewController.m
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/15/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "CreateIntervalViewController.h"

@interface CreateIntervalViewController ()

@end

@implementation CreateIntervalViewController

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
    
    //[nameInterval.contentView addSubView:]
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    intervals = [[NSMutableArray alloc] init];
    
    NSLog(@"view did load");
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
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
    return [intervals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CommonLibrary *myLibrary = [[CommonLibrary alloc] init];
    Interval *temp = [intervals objectAtIndex:indexPath.row];
    
    cell.textLabel.text =  [[intervals objectAtIndex:indexPath.row] intervalName ];
    
    int hours = [myLibrary timeToHours:temp.seconds];
    int minutes = [myLibrary timeToMinutes:temp.seconds];
    //int seconds = [myLibrary timeToSeconds:temp.seconds];
    int seconds = [temp seconds];
    
    //NSString *alertMessage = @"Hours: %i Minutes:%i Seconds:%i", *hours, *minutes, *seconds;
    NSString *alertMessage;
    
    alertMessage = [NSString stringWithFormat:@"Hours: %i", seconds];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

    //[alert show];
    
    return cell;
}

- (IBAction)returnToCreateInterval:(UIStoryboardSegue*)segue {
    
}

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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddIntervalViewController *vc = [segue destinationViewController];
    CommonLibrary *myLibrary = [[CommonLibrary alloc] init];
    
    Interval *temp = [[Interval alloc] init];
    [intervals addObject:temp];
    
    vc.interval = temp;
    
}


@end
