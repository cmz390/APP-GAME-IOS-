//
//  GameViewController.m
//  DoodleJump
//
//  Created by MingzhaoChen on 2/19/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameViewController.h"
#import "GameView.h"

@interface GameViewController ()<GameViewDelegate>
@property (nonatomic, strong) CADisplayLink *displayLink;


@end
static CGPoint startLocation;
CGPoint stopLocation;

@implementation GameViewController
@synthesize label1, label2;
@synthesize score;

int best = 0;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad {
    // Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    _displayLink = [CADisplayLink displayLinkWithTarget:_gameView selector:@selector(arrange:)];
    //[_displayLink setPreferredFramesPerSecond:30];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [label1 setText:[NSString stringWithFormat:@"Score: %d", [_gameView score]]];
    [label2 setText:[NSString stringWithFormat:@"Best: %d", best]];
    self.gameView.delegate=self;
    
}

-(void)updatelabel
{  
    [label1 setText:[NSString stringWithFormat:@"Score: %d", [_gameView score]]];
    if(best < [_gameView score]) best = [_gameView score];
    [label2 setText:[NSString stringWithFormat:@"Best: %d", best]];
}

-(void)gameover
{
    [_displayLink invalidate];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@""
                                 message:@"Game Over!"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Play again"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self restart:self];
                                }];
    
    [alert addAction:yesButton];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction) panGesture:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        startLocation = [sender locationInView:self.gameView];
    }
    else if(sender.state == UIGestureRecognizerStateEnded) {
        stopLocation = [sender locationInView:self.gameView];
        CGFloat dx = stopLocation.x - startLocation.x;
        //CGFloat dy = stopLocation.y - startLocation.y;
        //CGFloat distance = sqrt(dx*dx + dy*dy );
        //NSLog(@"Distance %f", dx);
        CGRect bounds = [_gameView bounds];
        [_gameView setTilt:dx/bounds.size.width];
        //[_gameView setScore: 100];
    }
}

-(IBAction)restart:(id)sender
{
     //[_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        //[_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_displayLink invalidate];
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self presentViewController:self animated:YES completion:nil];
    //[self previewActionIte]
    //GameViewController *newgame=[[GameViewController alloc]init];
}


@end
