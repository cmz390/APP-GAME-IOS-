//
//  PinchPanRotateVC.m
//  test
//
//  Created by Josh on 2/3/15.
//  Copyright (c) 2015 kangh. All rights reserved.
//

#import "PinchPanRotateVC.h"

@interface PinchPanRotateVC ()

@end

@implementation PinchPanRotateVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)handlePinchZoom:(UIPinchGestureRecognizer *)recognizer {
    float imageScale = sqrtf(recognizer.view.transform.a * recognizer.view.transform.a +
                             recognizer.view.transform.c * recognizer.view.transform.c);
    if ((recognizer.scale > 1.0) && (imageScale >= 2.00)) {
        return;
    }
    if ((recognizer.scale < 1.0) && (imageScale <= 0.75)) {
        return;
    }
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1.0;
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}

- (IBAction)handleRotate:(UIRotationGestureRecognizer *)recognizer {
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}


@end
