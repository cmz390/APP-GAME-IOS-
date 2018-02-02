//
//  RotateConcentricsVC.m
//  test
//
//  Created by Josh on 2/21/15.
//  Copyright (c) 2015 kangh. All rights reserved.
//

#import "RotateConcentricsVC.h"

@interface RotateConcentricsVC ()

@end

@implementation RotateConcentricsVC

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

- (IBAction)handleRotate:(UIRotationGestureRecognizer *)recognizer {
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

- (IBAction)handleInnerRotate:(UIRotationGestureRecognizer *)recognizer {
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

- (IBAction)handleOuterPinch:(UIPinchGestureRecognizer *)recognizer {
    float imageScale = sqrtf(recognizer.view.transform.a * recognizer.view.transform.a +
                             recognizer.view.transform.c * recognizer.view.transform.c);
    if ((recognizer.scale > 1.0) && (imageScale >= 1.40)) {
        return;
    }
    if ((recognizer.scale < 1.0) && (imageScale <= 0.25)) {
        return;
    }
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1.0;
}



@end
