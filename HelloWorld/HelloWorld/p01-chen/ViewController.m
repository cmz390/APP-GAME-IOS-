//
//  ViewController.m
//  p01-chen
//
//  Created by MingzhaoChen on 1/23/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize label;




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"1.jpg"] ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
   
}

-(IBAction)clicked:(id)sender
{
    [label setText:@"Hi, I am Mingzhao Chen!"];
}

@end
