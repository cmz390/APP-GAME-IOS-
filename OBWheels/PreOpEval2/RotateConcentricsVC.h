//
//  RotateConcentricsVC.h
//  test
//
//  Created by Josh on 2/21/15.
//  Copyright (c) 2015 kangh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RotateConcentricsVC : UIViewController
- (IBAction)handleRotate:(UIRotationGestureRecognizer *)recognizer;
- (IBAction)handleInnerRotate:(UIRotationGestureRecognizer *)recognizer;
- (IBAction)handleOuterPinch:(id)sender;



@end
