//
//  HowToVC.h
//  test
//
//  Created by Josh on 3/2/15.
//  Copyright (c) 2015 kangh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HowToVC : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *picSegmentedControl;
- (IBAction)segControlChanged:(id)sender;

@end
