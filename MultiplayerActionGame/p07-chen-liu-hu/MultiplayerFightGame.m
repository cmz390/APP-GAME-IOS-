//
//  MultiplayerFightGame.m
//  p07-chen-liu-hu
//
//  Created by MingzhaoChen on 4/30/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "MultiplayerFightGame.h"



@implementation MultiplayerFightGame


@synthesize inputStream, outputStream;
//@synthesize messages;



// round, healty, choice
int status[3]={0,0,0};
int healty[3]={1000, 1000,1000};
int choice[3]= {0, 0, 0};
int pid = 0;
int roundnum = 0;
int actionmarker = 0;



//Get, get pid from server,

//Set round, healty, choice

//fetch round, healty, choice


//        NSArray *list= [test componentsSeparatedByString:@"&"];

////字符串分割三段，标识为&
//NSArray *list= [test componentsSeparatedByString:@"&"];
//segment0=list[0];
//segment1=list[1];
//segment2=list[2];


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNetworkCommunication];
    //messages = [[NSMutableArray alloc] init];
    [self get];
    // [self set];
    
}



- (void) get {
    
    NSString *response  = [NSString stringWithFormat:@"get:0:0:0:0:"];
    NSLog(@"%@", response);
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    
}

-(void) set {
    //pid, status[pid], healty[pid],choice[pid]
    
    NSString *response  = [NSString stringWithFormat:@"set:%d:%d:%d:%d:",pid, status[pid], healty[pid],choice[pid]];
    NSLog(@"set:%@", response);
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    
}


//- (void) fetch {
//
//    NSString *response  = [NSString stringWithFormat:@"fetch:0:0:0:0:"];
//    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
//    [outputStream write:[data bytes] maxLength:[data length]];
//
//}


//NSString *string = @"5";
//int value = [string intValue];

- (void) messageReceived:(NSString *)message {
    
    //[self.messages addObject:message];
    NSArray *list= [message componentsSeparatedByString:@":"];
    
    
    NSLog(@"SB1");
    NSLog(@"%@", list[0]);
    if([list[0] isEqualToString:@"pid"])
    {
        pid = [list[1] intValue];
        pid = pid % 3;
        [self set];
    }
    else if ([list[0] isEqualToString:@"content"])
    {
        NSLog(@"SB");
        status[0] = [list[1] intValue];
        
        status[1] = [list[4] intValue];
        
        
        status[2] = [list[7] intValue];
        
        
        
        if(status[0]==status[1] && status[0] == roundnum + 1)
        {
            healty[0] = [list[2] intValue];
            choice[0] = [list[3] intValue];
            
            healty[1] = [list[5] intValue];
            choice[1] = [list[6] intValue];
            healty[2] = [list[8] intValue];
            choice[2] = [list[9] intValue];
            actionmarker = 0;
            [self updateStatus];
            //actionmarker = 0;
            roundnum ++;
        }
        
        
    }
    
    
}


//uodate healty, round
-(void) updateStatus{
    
    if(choice[pid] == 1 && choice[(pid+1)%2]==1)
    {
        healty[pid] -= 200;
        healty[(pid+1)%2] -=200;
        
    }
    else if(choice[pid] == 1 && choice[(pid+1)%2]==2)
    {
        healty[pid] +=0;
        healty[(pid+1)%2] -=100;
    }
    else if(choice[pid] == 2 && choice[(pid+1)%2]==1)
    {
        healty[pid] -=100;
        healty[(pid+1)%2] +=0;
    }
    else{
        healty[pid] -=0;
        healty[(pid+1)%2] +=0;
    }
    //status[pid] ++;
    [self set];
    [_Healty1 setText:[NSString stringWithFormat:@"%d", healty[pid]]];
    [_Healty2 setText:[NSString stringWithFormat:@"%d", healty[(pid+1)%2]]];
    
}


-(IBAction)attack
{
    choice[pid] = 1;
    if(actionmarker == 0)
    {
        actionmarker =1;
        status[pid]++;
    }
    
    [self set];
    
}


-(IBAction)defence
{
    choice[pid] = 2;
    if(actionmarker == 0)
    {
        actionmarker =1;
        status[pid]++;
    }
    
    [self set];
    
}


- (void) initNetworkCommunication {
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"192.168.1.109", 80, &readStream, &writeStream);
    
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
    
}


- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
    NSLog(@"stream event %lu", (unsigned long)streamEvent);
    
    switch (streamEvent) {
            
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
        case NSStreamEventHasBytesAvailable:
            
            if (theStream == inputStream) {
                
                uint8_t buffer[1024];
                int len;
                
                while ([inputStream hasBytesAvailable]) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        
                        if (nil != output) {
                            
                            NSLog(@"server said: %@", output);
                            //[self messageReceived:output];
                            [self performSelectorOnMainThread:@selector(messageReceived:) withObject:output waitUntilDone:NO];
                            
                        }
                    }
                }
            }
            break;
            
            
        case NSStreamEventErrorOccurred:
            
            NSLog(@"Can not connect to the host!");
            break;
            
        case NSStreamEventEndEncountered:
            
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            theStream = nil;
            
            break;
        default:
            NSLog(@"Unknown event");
    }
    
}




@end
