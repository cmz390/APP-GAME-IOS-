//
//  GameView.m
//  p06-chen-liu
//
//  Created by MingzhaoChen on 4/14/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>



#import "GameView.h"

@implementation GameView
@synthesize directions;
@synthesize tiles;



int marker[80];
int cr = 10;



-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        tiles = [[NSMutableArray alloc] init];
        CGRect bounds = [self bounds];
        float w = bounds.size.width/8;
        float h = bounds.size.height/cr;
        for (int r = 0; r < cr; ++r)
        {
            for (int c = 0; c < 8; ++c)
            {
                TileView *tv = [[TileView alloc] initWithFrame:CGRectMake(c*w + 4, r*h + 4, w - 4, h - 4)];
                [tiles addObject:tv];
                [tv setValue:0];
                [self addSubview:tv];
            }
        }
        
    }
    
    for(int i = 0; i < cr; i++)
    {
        for(int j = 0; j < 8; j++)
        {
            marker[i*8 + j] = 0;
        }
    }
    [self initial];
    return self;
}




-(void)initial
{
    int j;
    //NSLog(@"SB");
    for(int i = 0; i < cr; i++)
    {
        for(j = 0; j < 8; j++)
        {
            marker[i*8 + j] = 0;
        }
    }
    
    for (j = 0; j < cr * 8; ++j)
    {
        TileView *tv = [tiles objectAtIndex:j];
        
        
            [tv setValue:0];
        //NSLog(@"SB");
            //marker[(i + j)%64] = 1;
       // [tv.label setBackgroundColor:[UIColor orangeColor]];
            [tv updateLabel];
           // return;
        
    }


}


-(BOOL)full{

    for(int i = 0; i <80; i++)
    {
        if(marker[i] == 0) return NO;
    }
    
    return YES;
}

-(void)actionAI{
    
    
    for(int i1 = 2; i1 >=1; i1--)
    {
        
        for(int i2 = 5; i2 >= 2; i2--)
        {
    
            int position = [self think:i1 :i2];

            //if(position <0 || position > 63) position = [self thinkagain:i1 :i2];
            
            //if(position >=0 && position < 64) TileView *tv = [tiles objectAtIndex:position];
            //if([tv value] != 0) position = [self thinkagain:i1 :i2];
    
            if(position >=0 && position < cr * 8)
            {
                TileView *tv = [tiles objectAtIndex:position];
                if ([tv value] == 0)
                {
                    [tv setValue:1];
                    marker[position] = 1;
                    [tv updateLabel];
                    return;
                }
            }
            
            
             position = [self thinkagain:i1 :i2];
            
 
            //if(position <0 || position > 63) position = [self thinkagain:i1 :i2];
            
            //if(position >=0 && position < 64) TileView *tv = [tiles objectAtIndex:position];
            //if([tv value] != 0) position = [self thinkagain:i1 :i2];
            
            if(position >=0 && position < cr * 8)
            {
                TileView *tv = [tiles objectAtIndex:position];
                if ([tv value] == 0)
                {
                    [tv setValue:1];
                    marker[position] = 1;
                    [tv updateLabel];
                    return;
                }
            }
    
        }
        
    }
    
    
    
    int i = rand() % (cr*8);
               NSLog(@"jdijdfdskjfldsalis");
    for (int j = 0; j < (cr*8); ++j)
    {
        TileView *tv = [tiles objectAtIndex:(i + j)%(cr*8)];
        if ([tv value] == 0)
        {
            [tv setValue:1];
            marker[(i + j)%(cr*8)] = 1;
            [tv updateLabel];
            return;
        }
        
    }
    
}







-(void) findthelabel:(CGPoint) location
{
    
    for (int j = 0; j < (cr*8); ++j)
    {
        TileView *tv = [tiles objectAtIndex:j];
         BOOL A =CGRectContainsPoint(tv.frame, location);
        if (A)
        {
            NSLog(@"inswx: %d",j);
            if([tv value]==0)
            {
                [tv setValue:2];
                marker[j] = 2;
                [tv updateLabel];
                if([self playerwin])
                {NSLog(@"Player win!");
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Victory!"
                                                                    message:@""
                                                                   delegate:self
                                                          cancelButtonTitle:@"Play again"
                                                          otherButtonTitles:@"Back",nil];
                    [alert show];
                    return;
                    
                }
                
                
                
                [self actionAI];
                
                 if([self aiwin])
                 {
                     NSLog(@"AI win!");
                         
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lose!"
                                                                         message:@""
                                                                        delegate:self
                                                               cancelButtonTitle:@"Play again"
                                                               otherButtonTitles:@"Back",nil];
                         [alert show];
                         
                     
                     return;
                     
                 }
                

                if([self full])
                {
                    NSLog(@"Play Again!");
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tie!"
                                                                    message:@""
                                                                   delegate:self
                                                          cancelButtonTitle:@"Play again"
                                                          otherButtonTitles:@"Back",nil];
                    [alert show];
                    
                    
                    return;
                    
                }
                

                
            }
        }

        
    }
    
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self initial];
        NSLog(@"Cancel Tapped.");
    }
    else if (buttonIndex == 1) {
        [self initial];
        NSLog(@"OK Tapped. Hello World!");
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *myTouch = [[touches allObjects] objectAtIndex: 0];
    CGPoint currentPos = [myTouch locationInView: self];
    //NSLog(@"Point in myView: (%f,%f)", currentPos.x, currentPos.y);
    [self findthelabel:currentPos];
}




-(int)thinkagain:(int) pl : (int) num{
    
    int index = 0;
    int i, j, m, n;
    //int position;
    
    //from left to right
    
    for(i = 0; i < cr; i++)
    {        index = 0;
        for(j = 0; j < 8; j++)
        {
            
            if(marker[i*8 + j] == pl) index++;
            else index = 0;
            
            if(index == num && marker[i*8 + j - num] ==0) return i*8 + j - num;
            
            
        }
    }
    
    
    //from up to bottom
    
    index = 0;
    for(j = 0; j < 8; j++)
    {
        index = 0;
        for(i = 0; i < cr; i++)
        {
            
            if(marker[i*8 + j] == pl) index++;
            else index = 0;
            if(index == num && marker[(i - num ) *8 + j] ==0 ) return (i - num ) *8 + j;
            // if(index == num) return YES;
        }
    }
    
    
    
    //digonase \
    
    n=0;
    for(m = 0; m < 8; m++){
        
        for(i = n; i < cr; )
        {   index = 0;
            for(j = m; j < 8; )
            {
                //if(index == num) return i*8 + j;
                if(marker[i*8 + j] == pl) index++;
                else index = 0;
                i++;
                j++;
                if(index == num && marker[(i - num) *8 + (j - num)] ==0) return (i - num) *8 + (j - num);
                //if(index == num) return YES;
            }
        }
        
        
    }
    
    m=0;
    for(n = 0; n < cr; n++){
        
        for(i = n; i < cr; )
        {   index = 0;
            for(j = m; j < 8; )
            {
                //if(index == num) return i*8 + j;
                if(marker[i*8 + j] == pl) index++;
                else index = 0;
                i++;
                j++;
                if(index == num && marker[(i - num) *8 + (j - num)] ==0 ) return (i - num) *8 + (j - num);
                //if(index == num) return YES;
            }
        }
        
        
    }
    
    //digonase /
    n=0;
    for(m = 0; m < 8; m++){
        
        for(i = n; i < cr ; )
        {   index = 0;
            for(j = m; j >= 0; )
            {
                //if(index == num) return i*8 + j;
                if(marker[i*8 + j] == pl) index++;
                else index = 0;
                i++;
                j--;
                if(index == num && marker[(i - num) *8 + (j + num)] ==0 ) return (i - num) *8 + (j + num);
                //if(index == 5) return YES;
            }
        }
        
        
    }
    
    m=7;
    for(n = 0; n < cr; n++){
        
        for(i = n; i < cr; )
        {   index = 0;
            for(j = m; j >= 0; )
            {
                //if(index == num) return i*8 + j;
                if(marker[i*8 + j] == pl) index++;
                else index = 0;
                i++;
                j--;
                if(index == num && marker[(i - num) *8 + (j + num)] ==0 ) return (i - num) *8 + (j + num);
                // if(index == 5) return YES;
            }
        }
        
        
    }
    
    return -1;
}






-(int)think:(int) pl : (int) num{
    
    int index = 0;
    int i, j, m, n;
    //int position;
    
    //from left to right
    
    for(i = 0; i < cr; i++)
    {        index = 0;
        for(j = 0; j < 8; j++)
        {
            if(index == num && marker[i*8 + j] ==0) return i*8 + j;
            if(marker[i*8 + j] == pl) index++;
            else index = 0;
            
            
        }
    }
    
    
    //from up to bottom
    
    index = 0;
    for(j = 0; j < 8; j++)
    {
        index = 0;
        for(i = 0; i < cr; i++)
        {
            if(index == num && marker[i*8 + j] ==0) return i*8 + j;
            if(marker[i*8 + j] == pl) index++;
            else index = 0;
            
           // if(index == num) return YES;
        }
    }
    
    
    
    //digonase \
    
    n=0;
    for(m = 0; m < 8; m++){
        
        for(i = n; i < cr; )
        {   index = 0;
            for(j = m; j < 8; )
            {
                if(index == num && marker[i*8 + j] ==0) return i*8 + j;
                if(marker[i*8 + j] == pl) index++;
                else index = 0;
                i++;
                j++;
                //if(index == num) return YES;
            }
        }
        
        
    }
    
    m=0;
    for(n = 0; n < cr; n++){
        
        for(i = n; i < cr; )
        {   index = 0;
            for(j = m; j < 8; )
            {
                if(index == num && marker[i*8 + j] ==0) return i*8 + j;
                if(marker[i*8 + j] == pl) index++;
                else index = 0;
                i++;
                j++;
               //if(index == num) return YES;
            }
        }
        
        
    }
    
    //digonase /
    n=0;
    for(m = 0; m < 8; m++){
        
        for(i = n; i < cr ; )
        {   index = 0;
            for(j = m; j >= 0; )
            {
                if(index == num && marker[i*8 + j] ==0) return i*8 + j;
                if(marker[i*8 + j] == pl) index++;
                else index = 0;
                i++;
                j--;
                //if(index == 5) return YES;
            }
        }
        
        
    }
    
    m=7;
    for(n = 0; n < cr; n++){
        
        for(i = n; i < cr; )
        {   index = 0;
            for(j = m; j >= 0; )
            {
                if(index == num && marker[i*8 + j] ==0) return i*8 + j;
                if(marker[i*8 + j] == pl) index++;
                else index = 0;
                i++;
                j--;
               // if(index == 5) return YES;
            }
        }
        
        
    }
    
    return -1;
}



-(BOOL)playerwin{
    
    int index = 0;
    int i, j, m, n;
    
    //from left to right
    
    for(i = 0; i < cr; i++)
    {   index = 0;
        for(j = 0; j < 8; j++)
        {
            if(marker[i*8 + j] == 2) index++;
            else index = 0;
            
            if(index == 5) return YES;
        }
    }
    
    
    //from up to bottom
    
    index = 0;
    for(j = 0; j < 8; j++)
    {
        index = 0;
        for(i = 0; i < cr; i++)
        {
            if(marker[i*8 + j] == 2) index++;
            else index = 0;
            
            if(index == 5) return YES;
        }
    }
    
    
    
    //digonase \
    
    n=0;
    for(m = 0; m < 8; m++){
        
        for(i = n; i < cr; )
        {   index = 0;
            for(j = m; j < 8; )
            {
                if(marker[i*8 + j] == 2) index++;
                else index = 0;
                i++;
                j++;
                if(index == 5) return YES;
            }
        }
        
        
    }
    
    m=0;
    for(n = 0; n < cr; n++){
        
        for(i = n; i < cr; )
        {   index = 0;
            for(j = m; j < 8; )
            {
                if(marker[i*8 + j] == 2) index++;
                else index = 0;
                i++;
                j++;
                if(index == 5) return YES;
            }
        }
        
        
    }
    
    //digonase /
    n=0;
    for(m = 0; m < 8; m++){
        
        for(i = n; i < cr ; )
        {   index = 0;
            for(j = m; j >= 0; )
            {
                if(marker[i*8 + j] == 2) index++;
                else index = 0;
                i++;
                j--;
                if(index == 5) return YES;
            }
        }
        
        
    }
    
    m=7;
    for(n = 0; n < cr; n++){
        
        for(i = n; i < cr; )
        {   index = 0;
            for(j = m; j >= 0; )
            {
                if(marker[i*8 + j] == 2) index++;
                else index = 0;
                i++;
                j--;
                if(index == 5) return YES;
            }
        }
        
        
    }
    
    return NO;
}





-(BOOL)aiwin{
    
    int index = 0;
    int i, j, m, n;
    
    //from left to right
    
    for(i = 0; i < cr; i++)
    {   index = 0;
        for(j = 0; j < 8; j++)
        {
            if(marker[i*8 + j] == 1) index++;
            else index = 0;
            
            if(index == 5) return YES;
        }
    }
    
    
    //from up to bottom
    
    index = 0;
    for(j = 0; j < 8; j++)
    {
        index = 0;
        for(i = 0; i < cr; i++)
        {
            if(marker[i*8 + j] == 1) index++;
            else index = 0;
            
            if(index == 5) return YES;
        }
    }
    
    
    
    //digonase \
    
    n=0;
    for(m = 0; m < 8; m++){
        
        for(i = n; i < cr; )
        {   index = 0;
            for(j = m; j < 8; )
            {
                if(marker[i*8 + j] == 1) index++;
                else index = 0;
                i++;
                j++;
                if(index == 5) return YES;
            }
        }
        
        
    }
    
    m=0;
    for(n = 0; n < cr; n++){
        
        for(i = n; i < cr; )
        {   index = 0;
            for(j = m; j < 8; )
            {
                if(marker[i*8 + j] == 1) index++;
                else index = 0;
                i++;
                j++;
                if(index == 5) return YES;
            }
        }
        
        
    }
    
    //digonase /
    n=0;
    for(m = 0; m < 8; m++){
        
        for(i = n; i < cr ; )
        {   index = 0;
            for(j = m; j >= 0; )
            {
                if(marker[ i*8+ j] == 1) index++;
                else index = 0;
                i++;
                j--;
                if(index == 5) return YES;
            }
        }
        
        
    }
    
    m=7;
    for(n = 0; n < cr; n++){
        
        for(i = n; i < cr; )
        {   index = 0;
            for(j = m; j >= 0; )
            {
                if(marker[i*8 + j] == 1) index++;
                else index = 0;
                i++;
                j--;
                if(index == 5) return YES;
            }
        }
        
        
    }
    
    return NO;
}



@end
