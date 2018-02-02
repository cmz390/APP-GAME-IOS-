//
//  ViewController.m
//  DoodleJump
//
//  Created by MingzhaoChen on 2/14/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"

@interface ViewController ()
//@property (nonatomic, strong) CADisplayLink *displayLink;


@end
//static CGPoint startLocation;
//CGPoint stopLocation;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"12345.jpg"]];
    // Do any additional setup after loading the view, typically from a nib.
//    _displayLink = [CADisplayLink displayLinkWithTarget:_gameView selector:@selector(arrange:)];
//    //[_displayLink setPreferredFramesPerSecond:30];
//    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction) panGesture:(UIPanGestureRecognizer *)sender {
//    if (sender.state == UIGestureRecognizerStateBegan) {
//        startLocation = [sender locationInView:self.gameView];
//    }
//    else if(sender.state == UIGestureRecognizerStateEnded) {
//         stopLocation = [sender locationInView:self.gameView];
//        CGFloat dx = stopLocation.x - startLocation.x;
//        //CGFloat dy = stopLocation.y - startLocation.y;
//        //CGFloat distance = sqrt(dx*dx + dy*dy );
//        //NSLog(@"Distance %f", dx);
//        CGRect bounds = [_gameView bounds];
//        [_gameView setTilt:dx/bounds.size.width];
//   }
//}



- (IBAction)starTheGame:(id)sender
{
    GameViewController *game=[[GameViewController alloc]init];
    //game.gameView.delegate = game;
}
@end
