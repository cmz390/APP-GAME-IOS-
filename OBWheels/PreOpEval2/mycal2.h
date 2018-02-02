//
//  mycal2.h
//  OB Wheels
//
//  Created by MingzhaoChen on 3/27/17.
//  Copyright © 2017 kangh. All rights reserved.
//

#ifndef mycal2_h
#define mycal2_h


@interface mycal2 : UIViewController {
    
    
    
    IBOutlet UITextField *textField;
    IBOutlet UITextField *LPM;
    IBOutlet UITextField *EDD;
    IBOutlet UITextField *week;
    IBOutlet UITextField *day;
    
    UIDatePicker *dpDatePicker;
    
    
    
    IBOutlet UITextField *textfieldDaysSonoEGA;
    IBOutlet UITextField *textfieldWeeksSonoEGA;
    IBOutlet UITextField *test;
    
    
    IBOutlet UILabel *l1;
    //IBOutlet UITextField *textfieldDaysSonoEGA;
    //    IBOutlet UITextField *textfieldWeeksSonoEGA;
    //    IBOutlet UITextField *test;
}

//- (IBAction)sendLMPDateButton:(id)sender;
//- (IBAction)sendSonoDateButton:(id)sender;
//- (IBAction)sendEGAAsOfDateButton:(id)sender;
//- (IBAction)sendEDDDateButton:(id)sender;
//
//- (IBAction)textfieldWeeksSonoEGADismiss:(id)sender;
//- (IBAction)textfieldDaysSonoEGADismiss:(id)sender;



@end

#endif /* mycal2_h */
