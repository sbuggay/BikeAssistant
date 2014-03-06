//
//  NameIntervalViewController.m
//  BikeAssistant
//
//  Created by Benjamin Skipper on 3/5/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "NameIntervalViewController.h"
#import "CreateIntervalViewController.h"

@interface NameIntervalViewController ()

@end

@implementation NameIntervalViewController

- (void)segueToCreateInterval:(id) sender
{
    [self performSegueWithIdentifier:@"NameToCreateSegue" sender:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(_interval != nil){
        _nameTextField.text = [_interval getIntervalName];
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextButton:(id)sender {
    if ([_nameTextField.text isEqual:@""])
    {
        
      CommonLibrary *lib = [[CommonLibrary alloc]init];
       UIAlertView *alert =  [lib superSimpleAlert:@"Please enter a name"];
        [alert show];
    }
    else
    {
        if(_interval == nil){
            _interval =[[Interval alloc] initWithDefaults];
        }
        [_interval setIntervalName:_nameTextField.text];
        [self segueToCreateInterval:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CreateIntervalViewController *vc = [segue destinationViewController];
    vc.myInterval = _interval;
    
}
@end
