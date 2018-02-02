//
//  mycal.m
//  OB Wheels
//
//  Created by MingzhaoChen on 3/27/17.
//  Copyright © 2017 kangh. All rights reserved.
//

#import <Foundation/Foundation.h>



#import "mycal.h"

@interface mycal ()

@property (strong, nonatomic) NSDate *dateLMP;
@property (strong, nonatomic) NSDate *dateSono;
@property (strong, nonatomic) NSDate *dateEGAAsOf;

@end

@implementation mycal

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
    NSString *strLMPDate = [dateFormatter stringFromDate:_dateLMP]; // make stringLMPDate from dateLMP
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
    _dateLMP = wheelDate;
    [self updateResults];
    [self.view endEditing:YES];
}


-(void) updateResults
{
    // gets dates and values raw data, does calculations, outputs all anew to proper fields
    
    // set up date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    
    // get and output LMP date
    NSString *strLMPDate = [dateFormatter stringFromDate:_dateLMP]; // make stringLMPDate from dateLMP
    self->textField.text = strLMPDate; // send LMP string to LMP output field
    
    // derive and output LMP EDD
    NSTimeInterval secondsPerPregnancy = 60 * 60 * 24 * 280; // figure out in seconds the duration of pregnancy in order to add it to LMP momentarily
    NSDate *dateLMPEDD = [_dateLMP dateByAddingTimeInterval: secondsPerPregnancy]; // dateEDD is LMP + 280 days (in seconds)
    NSString *strLMPEDDDate = [dateFormatter stringFromDate:dateLMPEDD]; // make stringEDDDate from dateEDD
    //[l1 setText:strLMPEDDDate];
    [self->EDD setText:strLMPEDDDate];// send EDD string to EDD output field
    
    NSDate *now = [NSDate date];
    NSTimeInterval  t1 = [now timeIntervalSinceReferenceDate];
    
     NSTimeInterval  t2 = [_dateLMP timeIntervalSinceReferenceDate];
    
    NSTimeInterval  t3 = t1 - t2;
    
    int hw = t3/(60*60*24*7);
    int hd = t3/(60*60*24) - hw*7;
    
    [self->week setText:[NSString stringWithFormat:@"%d", hw]];
   [self->day setText:[NSString stringWithFormat:@"%d", hd]];
    
    
    
    
    
    
    
    
//    // set up date formatter
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
//    
//    // get and output LMP date
//    NSString *strLMPDate = [dateFormatter stringFromDate:dateLMP]; // make stringLMPDate from dateLMP
//    self.dateLMPLabel.text = strLMPDate; // send LMP string to LMP output field
//    
//    // derive and output LMP EDD
//    NSTimeInterval secondsPerPregnancy = 60 * 60 * 24 * 280; // figure out in seconds the duration of pregnancy in order to add it to LMP momentarily
//    NSDate *dateLMPEDD = [dateLMP dateByAddingTimeInterval: secondsPerPregnancy]; // dateEDD is LMP + 280 days (in seconds)
//    NSString *strLMPEDDDate = [dateFormatter stringFromDate:dateLMPEDD]; // make stringEDDDate from dateEDD
//    self.dateLMPEDDLabel.text = strLMPEDDDate;// send EDD string to EDD output field
//    
//    // get and output Sono date
//    NSString *strSonoDate = [dateFormatter stringFromDate:_dateSono]; // make stringSonoDate from dateSono
//    self.dateSonoLabel.text = strSonoDate; // send Sono string to Sono output field
//    
//    // derive and output Sono EDD
//    int weeksRemaining = (40 - [textfieldWeeksSonoEGA.text intValue]);
//    int daysRemaining = ((weeksRemaining * 7) - [textfieldDaysSonoEGA.text intValue]);
//    NSTimeInterval secondsRemainingInPregnancy = (daysRemaining * 24 * 60 * 60);
//    NSDate *dateSonoEDD = [dateSono dateByAddingTimeInterval: secondsRemainingInPregnancy]; // dateEDD is LMP + number of days remaining in pregnancy (in seconds), which is derived by subtracting Sono Report EGA days from 40 wks
//    NSString *strSonoEDDDate = [dateFormatter stringFromDate:dateSonoEDD]; // make stringEDDDate from dateEDD
//    self.dateSonoEDDLabel.text = strSonoEDDDate;// send EDD string to EDD output field
//    
//    // get and output EGA As Of date
//    NSString *strEGAAsOfDate = [dateFormatter stringFromDate:dateEGAAsOf]; // make stringEGAAsOfDate from dateEGAASOf
//    self.dateEGAAsOfLabel.text = strEGAAsOfDate; // send EGAAsOf string to EGAAsOf output field
//    self.dateEGAAsOfLabel2.text = strEGAAsOfDate; // send same EGAAsOf date string to the 2nd identical label in the Sono column
//    
//    // derive EGA-As-Of in weeks and days for LMP's EDD and output
//    int daysIntervalLMPtoEGAAsOf = (abs([dateLMP timeIntervalSinceDate:dateEGAAsOf]))/(60*60*24);
//    int weeksLMPEGAAsOf = (daysIntervalLMPtoEGAAsOf/7); // divide EGA in days by 7 to get EGA in weeks, and because it's an integer, it rounds down to whole weeks
//    int product = weeksLMPEGAAsOf * 7; // multiply the whole weeks in the EGA by 7 to get days of whole weeks
//    int daysLMPEGAAsOf = daysIntervalLMPtoEGAAsOf - product; // EGA days is difference between total days in interval from LMP to EGA and days in whole weeks in interval from LMP to EGA
//    NSString *daysString = [NSString stringWithFormat:@"%d", daysLMPEGAAsOf];
//    _daysLMPEGALabel.text = daysString;
//    NSString *weeksString = [NSString stringWithFormat:@"%d", weeksLMPEGAAsOf];
//    _weeksLMPEGALabel.text = weeksString;
//    
//    // derive EGA as of for Sono's EDD
//    // first derive the theoretical LMP of the Sono-based EDD so as to use the same approach as above for the LMP-based EDD
//    NSDate *dateSonosLMP = [dateSonoEDD dateByAddingTimeInterval:-secondsPerPregnancy]; // dateSonosLMP = dateSonosEDD -  280 days (in seconds)
//    // now derive the EGA by calculating the interval from the Sono's theoretical LMP to the EGA-As-Of date and converting that interval of seconds into days and weeks, following scheme developed for LMP above
//    int daysIntervalSonoLMPtoEGAAsOf = (abs([dateSonosLMP timeIntervalSinceDate:dateEGAAsOf]))/(60*60*24);
//    int weeksSonoLMPEGAAsOf = (daysIntervalSonoLMPtoEGAAsOf/7); // divide EGA in days by 7 to get EGA in weeks, and because it's an integer, it rounds down to whole weeks
//    int sproduct = weeksSonoLMPEGAAsOf * 7; // multiply the whole weeks in the EGA by 7 to get days of whole weeks
//    int daysSonoLMPEGAAsOf = daysIntervalSonoLMPtoEGAAsOf - sproduct; // EGA days is difference between total days in interval from LMP to EGA and days in whole weeks in interval from LMP to EGA
//    NSString *sdaysString = [NSString stringWithFormat:@"%d", daysSonoLMPEGAAsOf];
//    _daysSonoEGALabel.text = sdaysString;
//    NSString *sweeksString = [NSString stringWithFormat:@"%d", weeksSonoLMPEGAAsOf];
//    _weeksSonoEGALabel.text = sweeksString;
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



@end
