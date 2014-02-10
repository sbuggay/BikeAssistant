//
//  SettingsViewController.m
//  BikeAssistant
//
//  Created by Devan Buggay on 2/10/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults integerForKey:@"weight"])
        [defaults setInteger:0 forKey:@"weight"];
    
    if (![defaults integerForKey:@"height"])
        [defaults setInteger:0 forKey:@"height"];
    
    [_weightField setText:[NSString stringWithFormat:@"%ld", [defaults integerForKey:@"weight"]]];
    [_heightField setText:[NSString stringWithFormat:@"%ld", [defaults integerForKey:@"height"]]];
    
    UIBarButtonItem *donebutton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = donebutton;
    donebutton.enabled=TRUE;
    donebutton.style=UIBarButtonSystemItemDone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)done {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];


    [defaults setInteger:[[_weightField text] integerValue] forKey:@"weight"];
    [defaults setInteger:[[_heightField text] integerValue] forKey:@"height"];
    
    
    [self.navigationController popViewControllerAnimated: YES];
}
@end
