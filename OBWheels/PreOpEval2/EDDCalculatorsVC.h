//
//  EDDCalculatorsVC.h
//  OB Wheels
//
//  Created by Josh on 3/1/15.
//  Copyright (c) 2015 kangh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDDCalculatorsVC : UIViewController {
    
    IBOutlet UITextField *textfieldDaysSonoEGA;
    IBOutlet UITextField *textfieldWeeksSonoEGA;
     IBOutlet UITextField *test;
}
- (IBAction)sendLMPDateButton:(id)sender;
- (IBAction)sendSonoDateButton:(id)sender;
- (IBAction)sendEGAAsOfDateButton:(id)sender;
- (IBAction)sendEDDDateButton:(id)sender;

- (IBAction)textfieldWeeksSonoEGADismiss:(id)sender;
- (IBAction)textfieldDaysSonoEGADismiss:(id)sender;



@end
