//
//  ViewController.m
//  PreOpEval2
//
//  Created by Ashley Kang on 7/29/14.
//  Copyright (c) 2014 kangh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"This app provides methods for determining EDD and EGA.  The traditional handheld cardboard calendar wheel is here as well as calendar calculators.  The app also reviews how to handle and reconcile a final due date from those suggested by the LMP and Sono."
        // got rid of "readme" which filled the quotes, moved message into title
        message:@""
        delegate:self
        cancelButtonTitle:@"Get Started"
        otherButtonTitles:nil];
    
    [theAlert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)preopIcon:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/preop-eval/id374154834?mt=8"]];
}
@end
