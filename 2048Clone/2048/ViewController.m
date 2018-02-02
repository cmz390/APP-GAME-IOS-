//
//  ViewController.m
//  2048
//
//  Created by MingzhaoChen on 2/5/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//


#import "ViewController.h"
#import "Game.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"1.jpg"] ];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)starTheGame:(id)sender
{
    Game *test=[[Game alloc]init];
}

@end



