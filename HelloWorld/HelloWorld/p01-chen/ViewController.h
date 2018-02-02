//
//  ViewController.h
//  p01-chen
//
//  Created by MingzhaoChen on 1/23/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    UILabel *label;
}

@property (nonatomic, retain) IBOutlet UILabel *label;


-(IBAction) clicked:(id)sender;


@end

