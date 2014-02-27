//
//  IntervalTimerViewController.m
//  BikeAssistant
//
//  Created by Chauncey Philpot on 2/22/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "IntervalTimerViewController.h"

@interface IntervalTimerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property BOOL isFinalIntervalTimer;


@end

@implementation IntervalTimerViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *pressedButton = [_cellList objectAtIndex:indexPath.row];
    
    NSLog(@"%@", pressedButton);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _cellList = [[NSMutableArray alloc]init];
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height-self.tableView.frame.size.height) animated:YES];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    NSMutableArray *myArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *dictionary = [[defaults dictionaryForKey:@"myDictionary"]mutableCopy];
    
    myArray = [[dictionary objectForKey:[defaults valueForKey:@"tempIntervalName"]]mutableCopy];
    
    if(dictionary == nil){
        dictionary = [[NSMutableDictionary alloc]init];
    }
    if(myArray == nil){
        myArray = [[NSMutableArray alloc]init];
    }
    
    return ([dictionary count] + 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    NSMutableDictionary *dictionary = [[defaults dictionaryForKey:@"myDictionary"]mutableCopy];
    
    if(dictionary == nil){
        dictionary = [[NSMutableDictionary alloc]init];
    }
    
    int i = 0;
    NSString *intervalName = [[NSString alloc]init];
    for (NSString* key in dictionary) {
        
        if(i == indexPath.row - 1){
            intervalName = key;
        }
        i = i + 1;
    }
    
    
    if(indexPath.row == 0){
        cell.textLabel.text = @"Create Interval";
        [_cellList addObject:@"Create Interval"];
    }
    else{
        cell.textLabel.text = intervalName;
        [_cellList addObject:intervalName];
    }
  
    [dictionary writeToFile:@"myDictionary" atomically:YES];
    
    return cell;
}

-(void)timer {
    self.seconds = 10;
    self.minutes = 1;
    self.hours = 0;
    
    self.intervalTimerLabel.text = @"Warm up";
    NSTimer* timer = [NSTimer timerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(updateLabel:)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

-(void) updateLabel:(NSTimer *) timer {
    [self fixTime];
    self.seconds--;
    //self.timerLabel.text = [NSString stringWithFormat:@"%i", self.seconds];
    self.timerLabel.text = [self formatTime];
    if (self.seconds == 0 && !self.isFinalIntervalTimer && self.minutes == 0 && self.hours == 0)
    {
        self.intervalTimerLabel.text = @"Cool Down";
        self.isFinalIntervalTimer = YES;
        self.seconds = 20;
        
    }
    else if (self.seconds == 0 && self.minutes == 0 && self.hours == 0)
    {
        [timer invalidate];
        [self.startButton setEnabled:YES];
        self.intervalTimerLabel.text = @"My Interval Timer";
    }
}


-(void) fixTime {
    int hours, minutes, seconds;
    hours = self.hours;
    minutes = self.minutes;
    seconds = self.seconds;
    
    
    
    if(seconds == 0){
        if(minutes == 0){
            if(hours == 0){
                //timer ended
            }
            else{
                self.hours--;
                self.minutes = 60;
                self.seconds = 60;
            }
        }
        else{
            self.minutes--;
            self.seconds = 60;
            
        }
    }
    else{
        
    }
    
}

-(NSString *) formatTime {
    
    NSString *sHours, *sMinutes, *sSeconds;
    sHours = [NSString stringWithFormat:@""];
    sMinutes = [NSString stringWithFormat:@""];
    sSeconds = [NSString stringWithFormat:@""];
    
    if(self.hours < 10){
        sHours = [sHours stringByAppendingFormat:@"0"];
        sHours = [sHours stringByAppendingFormat:@"%i",self.hours];
    }
    else{
        sHours = [sHours stringByAppendingFormat:@"%i",self.hours];
    }
    
    if(self.minutes < 10){
        sMinutes = [sMinutes stringByAppendingFormat:@"0"];
        sMinutes = [sMinutes stringByAppendingFormat:@"%i",self.minutes];
    }
    else{
        sMinutes = [sMinutes stringByAppendingFormat:@"%i",self.minutes];
    }
    
    if(self.seconds < 10){
        sSeconds = [sSeconds stringByAppendingFormat:@"0"];
        sSeconds = [sSeconds stringByAppendingFormat:@"%i",self.seconds];
    }
    else{
        sSeconds = [sSeconds stringByAppendingFormat:@"%i",self.seconds];
    }
    
    
    NSString *formattedTime = [NSString stringWithFormat:@"%@:", sHours];
    formattedTime = [formattedTime stringByAppendingFormat:@"%@:",sMinutes];
    formattedTime = [formattedTime stringByAppendingFormat:@"%@", sSeconds];
    return formattedTime;
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
