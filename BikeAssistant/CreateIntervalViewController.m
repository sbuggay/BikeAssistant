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

- (NSString *)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UITableView *tableView = [[UITableView alloc]init];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    self.myInterval = [[Interval alloc]init];
   
    
    self.myInterval.name = [[alertView textFieldAtIndex:0] text];
    cell.textLabel.text = [[alertView textFieldAtIndex:0] text];
    NSLog(@"input: %@", [[alertView textFieldAtIndex:0] text]);
    
  
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    
    Interval *inter = [[Interval alloc]init];
    NSString *keyName = self.myInterval.name;
    [defaults setValue:self.myInterval.name forKey:keyName];
    [defaults setValue:self.myInterval.name forKey:@"intervalName"];
    

    
    
    [self.tableView reloadData];
    return [[alertView textFieldAtIndex:0] text];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[nameInterval.contentView addSubView:]
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Name" message:@"Enter name of Interval" delegate:self cancelButtonTitle:@"save" otherButtonTitles:nil, nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    

    
    
    
   // myInterval.intervalName = [self alertView:alert clickedButtonAtIndex:0];
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
    
    //CommonLibrary *myLibrary = [[CommonLibrary alloc] init];
    //Interval *temp = [intervals objectAtIndex:indexPath.row];
    
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    
    
    dictionary = [defaults dictionaryForKey:@"dictionary"];
    
    
    NSMutableArray *arrayOfIntervals = [[NSMutableArray alloc]init];
    
    
    arrayOfIntervals = [dictionary objectForKey:@"intervals"];
    
    NSString *intervalName = [arrayOfIntervals objectAtIndex:0];
    
    cell.textLabel.text = intervalName;
    
    //NSNumber *hours = [myLibrary timeToHours:*(temp.seconds)];
    //NSNumber *minutes = [myLibrary timeToMinutes:*temp.seconds];
    //NSNumber *seconds = [myLibrary timeToSeconds:*(temp.seconds)];

    
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
    
    Interval *temp = [[Interval alloc] init];
    [intervals addObject:temp];
    
    vc.interval = temp;
    
}


@end
