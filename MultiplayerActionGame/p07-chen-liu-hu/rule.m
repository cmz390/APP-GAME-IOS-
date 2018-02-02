//
//  rule.m
//  p07-chen-liu-hu
//
//  Created by 刘江韵 on 2017/5/1.
//  Copyright © 2017年 MingzhaoChen. All rights reserved.
//


#import "rule.h"

@interface rule ()
@property (strong, nonatomic) IBOutlet UIButton *Start;

@end

@implementation rule

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    [[UIImage imageNamed:@"beijing2.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    

    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    NSLog(@"Debug message");
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
