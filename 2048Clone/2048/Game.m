//
//  Game.m
//  2048
//
//  Created by MingzhaoChen on 2/7/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Game.h"


@interface Game ()

@end

@implementation Game

@synthesize label1, label2, label3, label4, label5, label6, label7, label8, label9, label10, label11, label12, label13, label14, label15, label16, score;


int number[16];
int scorevalue;


- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"1.jpg"] ];
    [self initial];
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
    //[recognizer release];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
       [self leftfunction];
        [self updateLabel];

    }
    else if(recognizer.direction==UISwipeGestureRecognizerDirectionRight){
        [self rightfunction];
        [self updateLabel];
    }
    else if(recognizer.direction==UISwipeGestureRecognizerDirectionDown){
        [self downfunction];
        [self updateLabel];
    }
    else{
        [self upfunction];
        [self updateLabel];
        
    }
    
    [self finish];
    [self addnumber];
    scorevalue+=1;
    [self updateLabel];
    
}

- (void) finish{
    
    for(int i=0; i< 16; i++)
    {
        if(number[i]>=2048)
        {
            
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Victory!!!"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Play again"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self initial];
                                        }];
            
            [alert addAction:yesButton];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            break;
        }
    }

}
- (void) leftfunction{
    int temp[4];
    int g,j,i;
    for(i=0; i<4; i++)
    {   g=0;
        for(j=0; j<4; j++)
        {
            if(number[i*4+j]!=0) {temp[g]=number[i*4+j];g++;}
        }
        for(;g<4;g++)
            temp[g]=0;
        
        for(j=0; j<3; j++)
        {
            if(temp[j]==temp[j+1]) {temp[j]+=temp[j+1];temp[j+1]=0;
                for(g=j+1;g<3;g++)
                    temp[g]=temp[g+1];
                temp[g+1]=0;}
        }
        
        for(j=0; j<4; j++)
        {
            number[i*4+j]=temp[j];
        }
    }
}
        

- (void) upfunction{
    int temp[4];
    int g,j,i;
    for(i=0; i<4; i++)
    {   g=0;
        for(j=0; j<4; j++)
        {
            if(number[i+j*4]!=0) {temp[g]=number[i+j*4];g++;}
        }
        for(;g<4;g++)
            temp[g]=0;
        
        for(j=0; j<3; j++)
        {
            if(temp[j]==temp[j+1]) {temp[j]+=temp[j+1];temp[j+1]=0;
                for(g=j+1;g<3;g++)
                    temp[g]=temp[g+1];
                temp[g+1]=0;}
        }
        
        for(j=0; j<4; j++)
        {
            number[i+j*4]=temp[j];
        }
    }
}

    
- (void) rightfunction{
    int temp[4];
    int g,j,i;
    for(i=0; i<4; i++)
    {   g=0;
        for(j=0; j<4; j++)
        {
            if(number[i*4+3-j]!=0) {temp[g]=number[i*4+3-j];g++;}
        }
        for(;g<4;g++)
            temp[g]=0;
        
        for(j=0; j<3; j++)
        {
            if(temp[j]==temp[j+1]) {temp[j]+=temp[j+1];temp[j+1]=0;
                for(g=j+1;g<3;g++)
                    temp[g]=temp[g+1];
                temp[g+1]=0;}
            
        }
        
        for(j=0; j<4; j++)
        {
            number[i*4+3-j]=temp[j];
        }
    }
}


- (void) downfunction{
    int temp[4];
    int g,j,i;
    for(i=0; i<4; i++)
    {   g=0;
        for(j=0; j<4; j++)
        {
            if(number[i+12-j*4]!=0) {temp[g]=number[i+12-j*4];g++;}
        }
        for(;g<4;g++)
            temp[g]=0;
        
        for(j=0; j<3; j++)
        {
            if(temp[j]==temp[j+1]) {temp[j]+=temp[j+1];temp[j+1]=0;
                for(g=j+1;g<3;g++)
                    temp[g]=temp[g+1];
                temp[g+1]=0;}
        }
        
        for(j=0; j<4; j++)
        {
            number[i+12-j*4]=temp[j];
        }
    }
}

-(void) initial{
        for(int i=0; i<16; i++)
            number[i]=0;
        scorevalue = 0;
        
    [self addnumber];
    [self addnumber];
        [self updateLabel];
    }

-(void)addnumber{
    
    
    int p = [self ramdonplace];
    if(p==-1)
    {
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"Game Over!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Play again"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        [self initial];
                                    }];
        
        [alert addAction:yesButton];
        
        
        [self presentViewController:alert animated:YES completion:nil];

    }
    if(p>=0&&p<16)
    {number[p] = [self ramdonnumber];}
}


- (int) ramdonplace{
    int count=0;
    int ret = -1;
    int i;
    for(i=0; i<16;i++)
    {
        if(number[i]==0) count++;
    }
    
    if(count==0) return ret;
    int a = arc4random()%count;
    count=0;
    for(i=0; i<16; i++)
    {
        if(number[i]==0) count++;
        if(a==count-1) break;
    }
    ret=i;
    return ret;
}

- (int) ramdonnumber{
    int ret;
    int a = arc4random()%10;
    if (a == 9) {
        ret = 4;
    }else{
        ret = 2;
    }
    return ret;
}


- (void)updateLabel
{
    if(number[0]==0)
        [label1 setText:@""];
    else
    [label1 setText:[NSString stringWithFormat:@"%d", number[0]]];
    if(number[1]==0)
        [label2 setText:@""];
    else
        [label2 setText:[NSString stringWithFormat:@"%d", number[1]]];
    if(number[2]==0)
        [label3 setText:@""];
    else
        [label3 setText:[NSString stringWithFormat:@"%d", number[2]]];
    if(number[3]==0)
        [label4 setText:@""];
    else
        [label4 setText:[NSString stringWithFormat:@"%d", number[3]]];
    if(number[4]==0)
        [label5 setText:@""];
    else
        [label5 setText:[NSString stringWithFormat:@"%d", number[4]]];
    if(number[5]==0)
        [label6 setText:@""];
    else
        [label6 setText:[NSString stringWithFormat:@"%d", number[5]]];
    if(number[6]==0)
        [label7 setText:@""];
    else
        [label7 setText:[NSString stringWithFormat:@"%d", number[6]]];
    if(number[7]==0)
        [label8 setText:@""];
    
    else
        [label8 setText:[NSString stringWithFormat:@"%d", number[7]]];
    if(number[8]==0)
        [label9 setText:@""];
    else
        [label9 setText:[NSString stringWithFormat:@"%d", number[8]]];
    if(number[9]==0)
        [label10 setText:@""];
    else
        [label10 setText:[NSString stringWithFormat:@"%d", number[9]]];
    if(number[10]==0)
        [label11 setText:@""];
    else
        [label11 setText:[NSString stringWithFormat:@"%d", number[10]]];
    if(number[11]==0)
        [label12 setText:@""];
    else
        [label12 setText:[NSString stringWithFormat:@"%d", number[11]]];
    if(number[12]==0)
        [label13 setText:@""];
    else
        [label13 setText:[NSString stringWithFormat:@"%d", number[12]]];
    if(number[13]==0)
        [label14 setText:@""];
    else
        [label14 setText:[NSString stringWithFormat:@"%d", number[13]]];
    if(number[14]==0)
        [label15 setText:@""];
    else
        [label15 setText:[NSString stringWithFormat:@"%d", number[14]]];
    if(number[15]==0)
        [label16 setText:@""];
    else
        [label16 setText:[NSString stringWithFormat:@"%d", number[15]]];
    
    [score setText:[NSString stringWithFormat:@"%d", scorevalue]];
    
    [self setColorforLabel:label1 :number[0]];
    [self setColorforLabel:label2 :number[1]];
    [self setColorforLabel:label3 :number[2]];
    [self setColorforLabel:label4 :number[3]];
    [self setColorforLabel:label5 :number[4]];
    [self setColorforLabel:label6 :number[5]];
    [self setColorforLabel:label7 :number[6]];
    [self setColorforLabel:label8 :number[7]];
    [self setColorforLabel:label9 :number[8]];
    [self setColorforLabel:label10 :number[9]];
    [self setColorforLabel:label11 :number[10]];
    [self setColorforLabel:label12 :number[11]];
    [self setColorforLabel:label13 :number[12]];
    [self setColorforLabel:label14 :number[13]];
    [self setColorforLabel:label15 :number[14]];
    [self setColorforLabel:label16 :number[15]];
}

- (void) setColorforLabel: (UILabel*) labeltemp: (int) value {
    switch(value)
    {
        case 2:{
            labeltemp.backgroundColor=[UIColor colorWithRed:(CGFloat)240/255 green:(CGFloat)255/255 blue:(CGFloat)255/255 alpha:1.0];
        }
            break;
        case 4:{
            labeltemp.backgroundColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)235/255 blue:(CGFloat)205/255 alpha:1.0];
        }
            break;
        case 8:{
            labeltemp.backgroundColor=[UIColor colorWithRed:(CGFloat)252/255 green:(CGFloat)192/255 blue:(CGFloat)203/255 alpha:1.0];
        }
            break;
        case 16:{
            labeltemp.backgroundColor=[UIColor colorWithRed:(CGFloat)227/255 green:(CGFloat)168/255 blue:(CGFloat)105/255 alpha:1.0];
        }
            break;
        case 32:{
            labeltemp.backgroundColor=[UIColor colorWithRed:(CGFloat)237/255 green:(CGFloat)145/255 blue:(CGFloat)33/255 alpha:1.0];
        }
            break;
        case 64:{
            labeltemp.backgroundColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)128/255 blue:0 alpha:1.0];
        }
            break;
        case 128:{
            labeltemp.backgroundColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)97/255 blue:0 alpha:1.0];
        }
            break;
        case 256:{
            labeltemp.backgroundColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)215/255 blue:0 alpha:1.0];
        }
            break;
        case 1024:{
            labeltemp.backgroundColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)255/255 blue:0 alpha:1.0];
        }
            break;
        case 2048:{
            labeltemp.backgroundColor=[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
        }
            break;
        default:{
            labeltemp.backgroundColor=[UIColor colorWithRed:(CGFloat)228/255 green:(CGFloat)233/255 blue:(CGFloat)140/255 alpha:1.0];
        }
            break;
            
    }
}

- (IBAction)starTheGame:(id)sender
{
    [self initial];
}
@end
