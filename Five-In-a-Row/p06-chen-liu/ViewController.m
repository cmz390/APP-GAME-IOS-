//
//  ViewController.m
//  p06-chen-liu
//
//  Created by MingzhaoChen on 4/5/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"back.jpeg"] ];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)restartButtonPress {
//    //  GameViewController *controller = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
//    //  [self presentModalViewController:controller animated:NO];
//    
//    [self.view setNeedsDisplay];
//}


//-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [[event allTouches] anyObject];
//    CGPoint location = [touch locationInView:touch.view];
//    NSLog(@"Point - %f, %f", location.x, location.y);
//}



@end
