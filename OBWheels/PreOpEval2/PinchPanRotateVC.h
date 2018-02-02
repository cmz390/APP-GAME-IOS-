//
//  PinchPanRotateVC.h
//  test
//
//  Created by Josh on 2/3/15.
//  Copyright (c) 2015 kangh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinchPanRotateVC : UIViewController
- (IBAction)handlePinchZoom:(id)sender;
- (IBAction)handlePan:(id)sender;
- (IBAction)handleRotate:(UIRotationGestureRecognizer *)recognizer;
@end
