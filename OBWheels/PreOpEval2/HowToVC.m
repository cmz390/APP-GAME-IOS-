//
//  HowToVC.m
//  test
//
//  Created by Josh on 3/2/15.
//  Copyright (c) 2015 kangh. All rights reserved.
//

#import "HowToVC.h"

@interface HowToVC ()
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;




@end

@implementation HowToVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // initialize so that first pic displays, others hidden at launch
    [self.image2 setHidden:YES];
    [self.image3 setHidden:YES];
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

- (IBAction)segControlChanged:(id)sender {
    if (_picSegmentedControl.selectedSegmentIndex == 0) {
        // first segment Resize chosen
        [self.image1 setHidden:NO];   // show Resize
        [self.image2 setHidden:YES];  // hide Rotate
        [self.image3 setHidden:YES];  // hide Reposition
    }
    else if (_picSegmentedControl.selectedSegmentIndex == 1) {
        // second segment Rotate chosen
        [self.image1 setHidden:YES];  // hide Resize
        [self.image2 setHidden:NO];   // show Rotate
        [self.image3 setHidden:YES];  // hide Reposition
    }
    else if (_picSegmentedControl.selectedSegmentIndex == 2) {
        // third segment Reposition chosen
        [self.image1 setHidden:YES];  // hide Resize
        [self.image2 setHidden:YES];  // hide Rotate
        [self.image3 setHidden:NO];   // show Reposition
    }

}
@end
