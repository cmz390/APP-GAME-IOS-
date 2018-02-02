//
//  MultiplayerFightGame.h
//  p07-chen-liu-hu
//
//  Created by MingzhaoChen on 4/30/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#ifndef MultiplayerFightGame_h
#define MultiplayerFightGame_h


#import <UIKit/UIKit.h>


@interface MultiplayerFightGame : UIViewController <NSStreamDelegate> {
    
    
    NSInputStream	*inputStream;
    NSOutputStream	*outputStream;
    UITextField		*inputNameField;
    UITextField		*inputMessageField;
    //    NSMutableArray	*messages;
    
}
@property (weak, nonatomic) IBOutlet UILabel *Healty1;
@property (weak, nonatomic) IBOutlet UILabel *Healty2;
@property (weak, nonatomic) IBOutlet UIButton *Attrack;
@property (weak, nonatomic) IBOutlet UIButton *Defence;

@property (weak, nonatomic) IBOutlet UILabel *Name_0;

@property (weak, nonatomic) IBOutlet UILabel *Name_1;
@property (weak, nonatomic) IBOutlet UILabel *Name_2;
@property (weak, nonatomic) IBOutlet UILabel *Healty_1;
@property (weak, nonatomic) IBOutlet UILabel *Healty_2;
@property (weak, nonatomic) IBOutlet UILabel *Healty;
@property (weak, nonatomic) IBOutlet UILabel *Power_1;
@property (weak, nonatomic) IBOutlet UILabel *Power_2;
@property (weak, nonatomic) IBOutlet UILabel *Power;


@property (weak, nonatomic) IBOutlet UILabel *Back_label;
@property (weak, nonatomic) IBOutlet UIButton *Back;

@property (weak, nonatomic) IBOutlet UIButton *A;
@property (weak, nonatomic) IBOutlet UIButton *D;
@property (weak, nonatomic) IBOutlet UIButton *BA;
@property (weak, nonatomic) IBOutlet UIButton *BD;

@property (weak, nonatomic) IBOutlet UIButton *C0;
@property (weak, nonatomic) IBOutlet UIButton *C1;
@property (weak, nonatomic) IBOutlet UIButton *C2;

@property (nonatomic, retain) NSInputStream *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;




//@property (nonatomic, retain) NSMutableArray *messages;


- (void) initNetworkCommunication;
- (void) messageReceived:(NSString *)message;

@end


#endif /* MultiplayerFightGame_h */
