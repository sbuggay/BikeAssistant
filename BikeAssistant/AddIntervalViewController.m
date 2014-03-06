//
//  AddIntervalViewController.m
//  BikeAssistant
//
//  Created by Devan Buggay on 2/16/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "AddIntervalViewController.h"


@implementation AddIntervalViewController

- (IBAction)finishedButton:(id) sender {
    
    int totalSeconds = 0;
    
    //Check to see if name and time were inputted
    //Verify name is unique to THIS interval
    //Update Interval object
    
    totalSeconds = [[_iHours text] intValue] * 3600;
    totalSeconds += [[_iMinutes text] intValue] * 60;
    totalSeconds += [[_iSeconds text] intValue];

    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    NSMutableArray *myArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *dictionary = [[defaults dictionaryForKey:@"myDictionary"]mutableCopy];
    NSNumber *seconds = [NSNumber numberWithInt:totalSeconds];
    
    myArray = [[dictionary objectForKey:[defaults valueForKey:@"tempIntervalName5"]]mutableCopy];
    tempArray = [[defaults objectForKey:@"tempArray"]mutableCopy];
    
    if(dictionary == nil){
        dictionary = [[NSMutableDictionary alloc]init];
    }
    if(myArray == nil){
        myArray = [[NSMutableArray alloc]init];
    }
    
    
    [myArray addObject:[_iName text]];
    [myArray addObject:seconds];
    [tempArray addObject:[_iName text]];
    
    [dictionary setObject:myArray forKey:[defaults valueForKey:@"tempIntervalName5"]];
    [defaults setObject:dictionary forKey:@"myDictionary"];
    [defaults setObject:tempArray forKey:@"tempArray"];
    
    [self performSegueWithIdentifier:@"returnToCreateInterval" sender:self];
   
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void) viewDidLoad {
   
}

- (IBAction)goBackToFirstView:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end