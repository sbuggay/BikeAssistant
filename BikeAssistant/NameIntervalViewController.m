//
//  NameIntervalViewController.m
//  BikeAssistant
//
//  Created by Benjamin Skipper on 3/5/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "NameIntervalViewController.h"
#import "IntervalViewController.h"
#import <SWRevealViewController/SWRevealViewController.h>

@interface NameIntervalViewController ()
- (IBAction)nextButton:(id)sender;



@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

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
    //=================================================
    
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
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



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    IntervalViewController *vc = [segue destinationViewController];
    vc.interval = _interval;
    
}

- (IBAction)nextButton:(id)sender {
    NSLog(@"%@", _nameTextField.text);
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
        if (_interval.getIntervalName != nil && ![_interval.getIntervalName isEqualToString:_nameTextField.text])
        {
            [_interval updateIntervalName:_nameTextField.text];
        }
        else if (_interval.getIntervalName == nil)
        {
            [_interval setIntervalName:_nameTextField.text];
        }
        [self segueToCreateInterval:self];
    }
}
@end
