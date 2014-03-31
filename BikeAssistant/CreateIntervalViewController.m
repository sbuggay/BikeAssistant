//
//  CreateIntervalViewController.m
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/15/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "CreateIntervalViewController.h"

@interface CreateIntervalViewController ()
- (IBAction)finishedButton:(id)sender;
- (IBAction)addTimer:(id)sender;



@end

@implementation CreateIntervalViewController
const int FINISHED = -2;
const int ADD = -1;

- (IBAction)finishedButton:(id)sender {
    [_interval saveInterval];
    pressedButton = [NSNumber numberWithInt:FINISHED];
    [self.navigationController popToRootViewControllerAnimated:YES];
 
}

- (IBAction)addTimer:(id)sender {
    [self segueToAddInterval:sender];
}

-(IBAction)segueToRoot:(id)sender {
    [self performSegueWithIdentifier:@"popToRoot" sender:sender];
}

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
    if(_interval != nil){
        [_interval getInterval:[_interval getIntervalName]];
    }
    //[nameInterval.contentView addSubView:]
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Name" message:@"Enter name of Interval" delegate:self cancelButtonTitle:@"save" otherButtonTitles:nil, nil];
    //alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    

}

- (void)viewDidAppear:(BOOL)animated {
    pressedButton = NULL;
    myArray = _interval.getListOfTimers;
    
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
    cell.textLabel.text = [myArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    pressedButton = [NSNumber numberWithInteger:indexPath.row];
    defaults = [[NSUserDefaults alloc]init];
    NSString *pressedButtonOut = [pressedButton stringValue];
    dictionary = [[defaults valueForKey:pressedButtonOut]mutableCopy];
    
    [self segueToAddInterval:self];
}

- (void)segueToAddInterval:(id) sender
{
    if (pressedButton == NULL) {
    pressedButton = [NSNumber numberWithInt:ADD];
    }
    [self performSegueWithIdentifier:@"CreateToAddSegue" sender:self];
}

- (IBAction)returnToCreateInterval:(UIStoryboardSegue*)segue {
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%@", pressedButton);
    if (pressedButton != NULL && [pressedButton intValue] != FINISHED)
    {
        AddIntervalViewController *vc = [segue destinationViewController];
    
        vc.interval = _interval;
        vc.incomingTimerIndex = pressedButton;
        NSLog(@"%@", myArray[0]);
    }
    
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

@end
