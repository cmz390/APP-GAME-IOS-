//
//  ViewController.m
//  p08-chen
//
//  Created by MingzhaoChen on 5/7/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import "ViewController.h"

#import "GameViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    [[UIImage imageNamed:@"p.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)starTheGame:(id)sender
{
    GameViewController *game=[[GameViewController alloc]init];
    //game.gameView.delegate = game;
}

@end
