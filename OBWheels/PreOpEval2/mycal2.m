//
//  mycal2.m
//  OB Wheels
//
//  Created by MingzhaoChen on 3/27/17.
//  Copyright © 2017 kangh. All rights reserved.
//

#import <Foundation/Foundation.h>



#import "mycal2.h"

@interface mycal2 ()

@property (strong, nonatomic) NSDate *dateLMP;
@property (strong, nonatomic) NSDate *dateSono;
@property (strong, nonatomic) NSDate *dateEGAAsOf;



@property (strong, nonatomic) IBOutlet UITextField *dateLMPLabel;
@property (strong, nonatomic) IBOutlet UITextField *dateSonoLabel;
@property (strong, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (strong, nonatomic) IBOutlet UITextField *dateEGAAsOfLabel;
@property (strong, nonatomic) IBOutlet UITextField *dateLMPEDDLabel;
@property (strong, nonatomic) IBOutlet UITextField *dateSonoEDDLabel;
@property (strong, nonatomic) IBOutlet UITextField *dateEGAAsOfLabel2;

@property (strong, nonatomic) IBOutlet UITextField *weeksLMPEGALabel;
@property (strong, nonatomic) IBOutlet UITextField *daysLMPEGALabel;
@property (strong, nonatomic) IBOutlet UITextField *weeksSonoEGALabel;
@property (strong, nonatomic) IBOutlet UITextField *daysSonoEGALabel;

@property (strong, nonatomic) IBOutlet UITextField *test;


@end

@implementation mycal2

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    NSDate *now = [NSDate date]; // create date variable called now, populate it with today's date as default
    //    [_myDatePicker setDate:now animated:YES]; // send today's date to initialize myDatePicker
    _dateLMP = now; // initialize LMP date to today
    _dateSono = now; // initialize Sono date to today
    _dateEGAAsOf = now; // initialize EGA A Of date to today
    
    
    // set up date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    
    // get and output LMP date
    NSString *strLMPDate = [dateFormatter stringFromDate:_dateSono]; // make stringLMPDate from dateLMP
    self->textField.text = strLMPDate; // send LMP string to LMP output field
    
    
    
    CGRect mysize = [UIScreen mainScreen].applicationFrame;
    
    //    textField = [[UITextField alloc] initWithFrame:CGRectMake(mysize.size.width/4, mysize.size.height/3, 150, 30)];
    //    textField.borderStyle = UITextBorderStyleRoundedRect;
    //    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //
    //    [self.view addSubview:textField];
    
    dpDatePicker = [[UIDatePicker alloc] init];
    dpDatePicker.datePickerMode = UIDatePickerModeDate;
    [dpDatePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    dpDatePicker.timeZone = [NSTimeZone defaultTimeZone];
    dpDatePicker.minuteInterval = 5;
    
    [textField setInputView:dpDatePicker];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]; // Declare the Gesture.
    gesRecognizer.delegate = self;
    [self.view addGestureRecognizer:gesRecognizer];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}

- (void)datePickerValueChanged:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    textField.text = [dateFormatter stringFromDate:dpDatePicker.date];
}


- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer{
    NSLog(@"Tapped");
    NSDate *wheelDate = dpDatePicker.date; // get the wheel date
    _dateSono = wheelDate;
//    textfieldWeeksSonoEGA.text = @"0";
//    textfieldDaysSonoEGA.text = @"0";
//    NSString *input = textfieldDaysSonoEGA.text;
//    NSCharacterSet *_NumericOnly = [NSCharacterSet decimalDigitCharacterSet];
//    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:input];
//    
//    if ([_NumericOnly isSupersetOfSet: myStringSet]) {  // if input is pos integer then check if within 0-6 days range, if not, erase entry with "0"
//        if (abs([input intValue] - 3) > 3) {  // is # days input outside range of 0 and 6
//            textfieldDaysSonoEGA.text = @"0";
//            // if entered weeks within 0-44, then send [input intValue] to Sono EGA Weeks
//        };
//    }
//    else {
//        textfieldDaysSonoEGA.text = @"0";
//    }
//    
//    NSString *input2 = textfieldWeeksSonoEGA.text;
//    NSCharacterSet *_NumericOnly2 = [NSCharacterSet decimalDigitCharacterSet];
//    NSCharacterSet *myStringSet2 = [NSCharacterSet characterSetWithCharactersInString:input];
//    
//    if ([_NumericOnly2 isSupersetOfSet: myStringSet2]) {  // if input is pos integer then check if within 0-6 days range, if not, erase entry with "0"
//        if (abs([input2 intValue] - 3) > 3) {  // is # days input outside range of 0 and 6
//            textfieldWeeksSonoEGA.text = @"0";
//            // if entered weeks within 0-44, then send [input intValue] to Sono EGA Weeks
//        };
//    }
//    else {
//        textfieldWeeksSonoEGA.text = @"0";
//    }
    
    //[self updateResults];
    [self.view endEditing:YES];
}


-(void) updateResults
{
    
        // gets dates and values raw data, does calculations, outputs all anew to proper fields
    
        // set up date formatter
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    
    
    // get and output Sono date
    NSString *strSonoDate = [dateFormatter stringFromDate:_dateSono]; // make stringSonoDate from dateSono
    self->textField.text = strSonoDate; // send Sono string to Sono output field
    
    // derive and output Sono EDD
    int weeksRemaining = (40 - [textfieldWeeksSonoEGA.text intValue]);
    int daysRemaining = ((weeksRemaining * 7) - [textfieldDaysSonoEGA.text intValue]);
    NSTimeInterval secondsRemainingInPregnancy = (daysRemaining * 24 * 60 * 60);
    NSDate *dateSonoEDD = [_dateSono dateByAddingTimeInterval: secondsRemainingInPregnancy]; // dateEDD is LMP + number of days remaining in pregnancy (in seconds), which is derived by subtracting Sono Report EGA days from 40 wks
    NSString *strSonoEDDDate = [dateFormatter stringFromDate:dateSonoEDD]; // make stringEDDDate from dateEDD
    self.dateSonoEDDLabel.text = strSonoEDDDate;// send EDD string to EDD output field
    

    NSDate *now = [NSDate date];
    NSTimeInterval  t1 = [now timeIntervalSinceReferenceDate];
    
    NSTimeInterval  t2 = [_dateSono timeIntervalSinceReferenceDate];
    
    NSTimeInterval  t3 = t1 - t2;
    
    int hw = t3/(60*60*24*7);
    int hd = t3/(60*60*24) - hw*7;
    
    [self->week setText:[NSString stringWithFormat:@"%d", hw]];
    [self->day setText:[NSString stringWithFormat:@"%d", hd]];
    
//    // gets dates and values raw data, does calculations, outputs all anew to proper fields
//    
//    // set up date formatter
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
//    
//    // get and output LMP date
//    NSString *strLMPDate = [dateFormatter stringFromDate:_dateLMP]; // make stringLMPDate from dateLMP
//    self->textField.text = strLMPDate; // send LMP string to LMP output field
//    
//    // derive and output LMP EDD
//    NSTimeInterval secondsPerPregnancy = 60 * 60 * 24 * 280; // figure out in seconds the duration of pregnancy in order to add it to LMP momentarily
//    NSDate *dateLMPEDD = [_dateLMP dateByAddingTimeInterval: secondsPerPregnancy]; // dateEDD is LMP + 280 days (in seconds)
//    NSString *strLMPEDDDate = [dateFormatter stringFromDate:dateLMPEDD]; // make stringEDDDate from dateEDD
//    //[l1 setText:strLMPEDDDate];
//    [self->EDD setText:strLMPEDDDate];// send EDD string to EDD output field
//    
//    NSDate *now = [NSDate date];
//    NSTimeInterval  t1 = [now timeIntervalSinceReferenceDate];
//    
//    NSTimeInterval  t2 = [_dateLMP timeIntervalSinceReferenceDate];
//    
//    NSTimeInterval  t3 = t1 - t2;
//    
//    int hw = t3/(60*60*24*7);
//    int hd = t3/(60*60*24) - hw*7;
//    
//    [self->week setText:[NSString stringWithFormat:@"%d", hw]];
//    [self->day setText:[NSString stringWithFormat:@"%d", hd]];
//    
    
}

- (IBAction)Cal:(id)sender {
    [self updateResults];
    
}

- (IBAction)sendLMPDateButton:(id)sender {
    NSDate *wheelDate = dpDatePicker.date; // get the wheel date
    _dateLMP = wheelDate; // put wheel date into dateLMP
    [self updateResults];
    
}

- (IBAction)sendSonoDateButton:(id)sender {
    NSDate *wheelDate = dpDatePicker.date; // get the wheel date
    _dateSono = wheelDate; // put wheel date into dateSono
    [self updateResults];
    
}

- (IBAction)sendEGAAsOfDateButton:(id)sender {
    NSDate *wheelDate = dpDatePicker.date; // get the wheel date
    _dateEGAAsOf = wheelDate; // put wheel date into dateEGAAsOf
    [self updateResults];
    
}

- (IBAction)sendEDDDateButton:(id)sender {
    // this actually works by sending not the EDD but the entered EDD - 280 days so as to send an LMP, and once that LMP goes into its field, updateResults will add 280 back and set the EDD as if it were entered directly
    NSDate *wheelDate = dpDatePicker.date; // get the wheel date which user says is EDD
    NSTimeInterval secondsPerPregnancy = 60 * 60 * 24 * 280; // figure out in seconds the duration of pregnancy in order to add it to LMP momentarily
    _dateLMP = [wheelDate dateByAddingTimeInterval:-secondsPerPregnancy]; // dateLMP = wheelDate (user-entered EDD) -  280 days (in seconds)
    [self updateResults];
    
}

- (IBAction)textfieldWeeksSonoEGADismiss:(id)sender {
    [textfieldWeeksSonoEGA resignFirstResponder];
    NSString *input = textfieldWeeksSonoEGA.text;
    NSCharacterSet *_NumericOnly = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:input];
    
    if ([_NumericOnly isSupersetOfSet: myStringSet]) {  // if input is pos integer then check if within 0-44 wks range, if not, erase entry with "0"
        if (abs([input intValue] - 22) > 22) {  // is # weeks input outside range of 0 and 44
            textfieldWeeksSonoEGA.text = @"0";
            // if entered weeks within 0-44, then send [input intValue] to Sono EGA Weeks
        };
    }
    else {
        textfieldWeeksSonoEGA.text = @"0";
    }
    
    [self updateResults];
}

- (IBAction)textfieldDaysSonoEGADismiss:(id)sender {
    [textfieldDaysSonoEGA resignFirstResponder];
    NSString *input = textfieldDaysSonoEGA.text;
    NSCharacterSet *_NumericOnly = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:input];
    
    if ([_NumericOnly isSupersetOfSet: myStringSet]) {  // if input is pos integer then check if within 0-6 days range, if not, erase entry with "0"
        if (abs([input intValue] - 3) > 3) {  // is # days input outside range of 0 and 6
            textfieldDaysSonoEGA.text = @"0";
            // if entered weeks within 0-44, then send [input intValue] to Sono EGA Weeks
        };
    }
    else {
        textfieldDaysSonoEGA.text = @"0";
    }
    
    
    [self updateResults];
}


@end
