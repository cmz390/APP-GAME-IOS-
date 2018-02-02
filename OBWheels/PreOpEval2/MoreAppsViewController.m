//
//  MoreAppsViewController.m
//  test
//
//  Created by Josh on 1/18/15.
//  Copyright (c) 2015 kangh. All rights reserved.
//

#import "MoreAppsViewController.h"

@interface MoreAppsViewController ()

@end

@implementation MoreAppsViewController

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

- (IBAction)gotoSteinbergApps:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/developer/joshua-steinberg-md/id374154837"]];
}


/*
 - (IBAction)gotoPreop:(id)sender {
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/preop-eval/id374154834?mt=8"]];
 }
 
 - (IBAction)gotoWarfarin:(id)sender {
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/warfaringuide/id403959804?mt=8"]];
 }
 */
- (IBAction)gotoAppsList:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://fmdrl.org/index.cfm?event=c.getAttachment&riid=9236"]];
}


@end

