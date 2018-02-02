//
//  EDDCalculatorsVC.m
//  OB Wheels
//
//  Created by Josh on 3/1/15.
//  Copyright (c) 2015 kangh. All rights reserved.
//

#import "EDDCalculatorsVC.h"

@interface EDDCalculatorsVC ()

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

@implementation EDDCalculatorsVC

@synthesize dateLMP, dateSono, dateEGAAsOf; // dateLMPEDD, dateSonoEDD;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDate *now = [NSDate date]; // create date variable called now, populate it with today's date as default
    [_myDatePicker setDate:now animated:YES]; // send today's date to initialize myDatePicker
    dateLMP = now; // initialize LMP date to today
    dateSono = now; // initialize Sono date to today
    dateEGAAsOf = now; // initialize EGA A Of date to today
    [self updateResults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateResults {
    // gets dates and values raw data, does calculations, outputs all anew to proper fields
    
    // set up date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    
    // get and output LMP date
    NSString *strLMPDate = [dateFormatter stringFromDate:dateLMP]; // make stringLMPDate from dateLMP
    self.dateLMPLabel.text = strLMPDate; // send LMP string to LMP output field
    
    // derive and output LMP EDD
    NSTimeInterval secondsPerPregnancy = 60 * 60 * 24 * 280; // figure out in seconds the duration of pregnancy in order to add it to LMP momentarily
    NSDate *dateLMPEDD = [dateLMP dateByAddingTimeInterval: secondsPerPregnancy]; // dateEDD is LMP + 280 days (in seconds)
    NSString *strLMPEDDDate = [dateFormatter stringFromDate:dateLMPEDD]; // make stringEDDDate from dateEDD
    self.dateLMPEDDLabel.text = strLMPEDDDate;// send EDD string to EDD output field
    
    // get and output Sono date
    NSString *strSonoDate = [dateFormatter stringFromDate:dateSono]; // make stringSonoDate from dateSono
    self.dateSonoLabel.text = strSonoDate; // send Sono string to Sono output field
    
    // derive and output Sono EDD
    int weeksRemaining = (40 - [textfieldWeeksSonoEGA.text intValue]);
    int daysRemaining = ((weeksRemaining * 7) - [textfieldDaysSonoEGA.text intValue]);
    NSTimeInterval secondsRemainingInPregnancy = (daysRemaining * 24 * 60 * 60);
    NSDate *dateSonoEDD = [dateSono dateByAddingTimeInterval: secondsRemainingInPregnancy]; // dateEDD is LMP + number of days remaining in pregnancy (in seconds), which is derived by subtracting Sono Report EGA days from 40 wks
    NSString *strSonoEDDDate = [dateFormatter stringFromDate:dateSonoEDD]; // make stringEDDDate from dateEDD
    self.dateSonoEDDLabel.text = strSonoEDDDate;// send EDD string to EDD output field
    
    // get and output EGA As Of date
    NSString *strEGAAsOfDate = [dateFormatter stringFromDate:dateEGAAsOf]; // make stringEGAAsOfDate from dateEGAASOf
    self.dateEGAAsOfLabel.text = strEGAAsOfDate; // send EGAAsOf string to EGAAsOf output field
    self.dateEGAAsOfLabel2.text = strEGAAsOfDate; // send same EGAAsOf date string to the 2nd identical label in the Sono column
    
    // derive EGA-As-Of in weeks and days for LMP's EDD and output
    int daysIntervalLMPtoEGAAsOf = (abs([dateLMP timeIntervalSinceDate:dateEGAAsOf]))/(60*60*24);
    int weeksLMPEGAAsOf = (daysIntervalLMPtoEGAAsOf/7); // divide EGA in days by 7 to get EGA in weeks, and because it's an integer, it rounds down to whole weeks
    int product = weeksLMPEGAAsOf * 7; // multiply the whole weeks in the EGA by 7 to get days of whole weeks
    int daysLMPEGAAsOf = daysIntervalLMPtoEGAAsOf - product; // EGA days is difference between total days in interval from LMP to EGA and days in whole weeks in interval from LMP to EGA
    NSString *daysString = [NSString stringWithFormat:@"%d", daysLMPEGAAsOf];
    _daysLMPEGALabel.text = daysString;
    NSString *weeksString = [NSString stringWithFormat:@"%d", weeksLMPEGAAsOf];
    _weeksLMPEGALabel.text = weeksString;
    
    // derive EGA as of for Sono's EDD
    // first derive the theoretical LMP of the Sono-based EDD so as to use the same approach as above for the LMP-based EDD
    NSDate *dateSonosLMP = [dateSonoEDD dateByAddingTimeInterval:-secondsPerPregnancy]; // dateSonosLMP = dateSonosEDD -  280 days (in seconds)
    // now derive the EGA by calculating the interval from the Sono's theoretical LMP to the EGA-As-Of date and converting that interval of seconds into days and weeks, following scheme developed for LMP above
    int daysIntervalSonoLMPtoEGAAsOf = (abs([dateSonosLMP timeIntervalSinceDate:dateEGAAsOf]))/(60*60*24);
    int weeksSonoLMPEGAAsOf = (daysIntervalSonoLMPtoEGAAsOf/7); // divide EGA in days by 7 to get EGA in weeks, and because it's an integer, it rounds down to whole weeks
    int sproduct = weeksSonoLMPEGAAsOf * 7; // multiply the whole weeks in the EGA by 7 to get days of whole weeks
    int daysSonoLMPEGAAsOf = daysIntervalSonoLMPtoEGAAsOf - sproduct; // EGA days is difference between total days in interval from LMP to EGA and days in whole weeks in interval from LMP to EGA
    NSString *sdaysString = [NSString stringWithFormat:@"%d", daysSonoLMPEGAAsOf];
    _daysSonoEGALabel.text = sdaysString;
    NSString *sweeksString = [NSString stringWithFormat:@"%d", weeksSonoLMPEGAAsOf];
    _weeksSonoEGALabel.text = sweeksString;
    
    
}

- (IBAction)sendLMPDateButton:(id)sender {
    NSDate *wheelDate = _myDatePicker.date; // get the wheel date
    dateLMP = wheelDate; // put wheel date into dateLMP
    [self updateResults];
    
}

- (IBAction)sendSonoDateButton:(id)sender {
    NSDate *wheelDate = _myDatePicker.date; // get the wheel date
    dateSono = wheelDate; // put wheel date into dateSono
    [self updateResults];
    
}

- (IBAction)sendEGAAsOfDateButton:(id)sender {
    NSDate *wheelDate = _myDatePicker.date; // get the wheel date
    dateEGAAsOf = wheelDate; // put wheel date into dateEGAAsOf
    [self updateResults];
    
}

- (IBAction)sendEDDDateButton:(id)sender {
    // this actually works by sending not the EDD but the entered EDD - 280 days so as to send an LMP, and once that LMP goes into its field, updateResults will add 280 back and set the EDD as if it were entered directly
    NSDate *wheelDate = _myDatePicker.date; // get the wheel date which user says is EDD
    NSTimeInterval secondsPerPregnancy = 60 * 60 * 24 * 280; // figure out in seconds the duration of pregnancy in order to add it to LMP momentarily
    dateLMP = [wheelDate dateByAddingTimeInterval:-secondsPerPregnancy]; // dateLMP = wheelDate (user-entered EDD) -  280 days (in seconds)
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
