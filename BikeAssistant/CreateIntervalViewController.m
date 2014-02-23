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
    [defaults setValue:_myInterval.name forKey:@"tempIntervalName"];
    
    NSMutableArray *myArray = [[NSMutableArray alloc]init];
    NSMutableArray *myTempArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *dictionary = [[defaults dictionaryForKey:@"myDictionary"]mutableCopy];
    
    if (dictionary == nil) {
        dictionary = [[NSMutableDictionary alloc]init];
    }
    
    [dictionary setObject:myArray forKey:_myInterval.name];
    
    //[dictionary writeToFile:@"myDictinoary" atomically:YES];
    [defaults setObject:dictionary forKey:@"myDictionary"];
    [defaults setObject:myTempArray forKey:@"tempArray"];
    
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
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    tempArray = [defaults objectForKey:@"tempArray"];
    return [tempArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CommonLibrary *myLibrary = [[CommonLibrary alloc] init];
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    NSMutableArray *myArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *dictionary = [[defaults dictionaryForKey:@"myDictionary"]mutableCopy];
    
    myArray = [[dictionary objectForKey:[defaults valueForKey:@"tempIntervalName"]]mutableCopy];
    
    if(dictionary == nil){
        dictionary = [[NSMutableDictionary alloc]init];
    }
    if(myArray == nil){
        myArray = [[NSMutableArray alloc]init];
    }
    
    cell.textLabel.text = [myArray objectAtIndex:indexPath.row * 2];
    
    NSLog(@"%@", [defaults valueForKey:@"tempIntervalName"]);
    
    NSNumber *hours = [myLibrary timeToHours:[[myArray objectAtIndex:(indexPath.row * 2) + 1] integerValue]];
    NSNumber *minutes = [myLibrary timeToMinutes:[[myArray objectAtIndex:(indexPath.row * 2) + 1] integerValue]];
    NSNumber *seconds = [myLibrary timeToSeconds:[[myArray objectAtIndex:(indexPath.row * 2) + 1] integerValue]];
    
    NSLog(@"Number of Hours: %@", hours);
    NSLog(@"Number of Minutes: %@", minutes);
    NSLog(@"Number of Seconds: %@", seconds);
    
    [dictionary writeToFile:@"myDictionary" atomically:YES];
    
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
