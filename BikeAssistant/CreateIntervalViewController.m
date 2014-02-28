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

NSString *tempIntName = @"tempIntervalName5";
NSString *dictName = @"myDictionary";
NSString *stempArray = @"tempArray";

- (IBAction)finishButton:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

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
    
    cell.textLabel.text = [[alertView textFieldAtIndex:0] text];
 
    [defaults setValue:[[alertView textFieldAtIndex:0] text] forKey:tempIntName];
    
    NSMutableArray *myTempArray = [[NSMutableArray alloc]init];
    
    [dictionary setObject:myArray forKey:[[alertView textFieldAtIndex:0] text]];
    [defaults setObject:dictionary forKey:dictName];
    [defaults setObject:myTempArray forKey:stempArray];
    
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
    
    defaults = [[NSUserDefaults alloc]init];
    dictionary = [[defaults dictionaryForKey:dictName]mutableCopy];
    myArray = [[dictionary objectForKey:[defaults valueForKey:tempIntName]]mutableCopy];
    
    if (myArray == nil){
        myArray = [[NSMutableArray alloc]init];
    }
    if (dictionary == nil) {
        dictionary = [[NSMutableDictionary alloc]init];
    }
    
    [alert show];
    

   // myInterval.intervalName = [self alertView:alert clickedButtonAtIndex:0];
}

- (void)viewDidAppear:(BOOL)animated {
    dictionary = [[defaults dictionaryForKey:dictName]mutableCopy];
    myArray = [[dictionary objectForKey:[defaults valueForKey:tempIntName]]mutableCopy];
    if (myArray == nil){
        myArray = [[NSMutableArray alloc]init];
    }
   
    
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
    return [myArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    if(dictionary == nil){
        dictionary = [[NSMutableDictionary alloc]init];
    }
    if(myArray == nil){
        myArray = [[NSMutableArray alloc]init];
    }
    
    cell.textLabel.text = [myArray objectAtIndex:indexPath.row * 2];
    
    [dictionary writeToFile:dictName atomically:YES];
    
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
