//
//  GameView.m
//  DoodleJump
//
//  Created by MingzhaoChen on 2/18/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "GameView.h"

@implementation GameView
@synthesize jumper, bricks;
@synthesize tilt;
@synthesize score;
time_t t;
float history;







-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initial];
    }

self.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"333.png"]];
    return self;
}

-(void)initial
{   score = 0;
    CGRect bounds = [self bounds];
    history = bounds.size.height;
    if(jumper)
    {
        [jumper removeFromSuperview];
    }
    jumper = [[Jumper alloc] initWithFrame:CGRectMake(bounds.size.width/2, bounds.size.height/1.5, 80 , 100)];
//     jumper = [[Jumper alloc] initWithFrame:CGRectMake(bounds.size.width/2, bounds.size.height - 20, 50, 50)];
        UIGraphicsBeginImageContext(jumper.frame.size);
        [[UIImage imageNamed:@"qe.jpeg"] drawInRect:jumper.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    
    jumper.backgroundColor = [UIColor colorWithPatternImage:image];
   //[jumper setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"467.jpg"]]];
    [jumper setDx:0];
    [jumper setDy:7.5];
    [self addSubview:jumper];
    [self makeBricks];
}


-(void)makeBricks
{
    CGRect bounds = [self bounds];
    float width = bounds.size.width * .2;
    float height = bounds.size.height * .01;
    
    srand((unsigned) time(&t));
    
    if (bricks)
    {
        for (Brick *brick in bricks)
        {
            [brick removeFromSuperview];
            [bricks removeObject:brick];
            
        }
    }
    
    bricks = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; ++i)
    {
        Brick *b = [[Brick alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [b setBackgroundColor:[UIColor brownColor]];
        b.backgroundColor=[UIColor colorWithRed:(CGFloat)138/255 green:(CGFloat)215/255 blue:(CGFloat)130/255 alpha:1.0];

        
        [self addSubview:b];
        [b setCenter:CGPointMake(rand() % (int)(bounds.size.width * .8), (int)(bounds.size.height * .1* (i+1)))];
        [bricks addObject:b];
    }
}




-(void)arrangeBricks: (float) iy
{
    CGRect bounds = [self bounds];
    //float width = bounds.size.width * .2;
    float height = bounds.size.height;
    int i = 0;
    
    for (Brick *brick in bricks)
    {
        CGPoint p = [brick center];
        if(p.y + iy < height)
        {
            //Brick *b = [[Brick alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            //[brick setBackgroundColor:[UIColor blueColor]];
            //[self addSubview:brick];
            [brick setCenter:CGPointMake(p.x, p.y+iy)];
        }
        else
        {
            //[self addSubview:brick];
            [brick setCenter:CGPointMake(rand() % (int)(bounds.size.width * .8), p.y+iy-height)];
            i++;
        }
    }
    
    // bricks = [[NSMutableArray alloc] init];
    //    for (int i = 0; i < 9; ++i)
    //    {
    //
    //        Brick *b = [[Brick alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    //        [b setBackgroundColor:[UIColor blueColor]];
    //        [self addSubview:b];
    //        [b setCenter:CGPointMake(rand() % (int)(bounds.size.width * .8), (int)(bounds.size.height * .1*(i+1)))];
    //        [bricks addObject:b];
    //    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)arrange:(CADisplayLink *)sender
{
    CFTimeInterval ts = [sender timestamp];
    
    CGRect bounds = [self bounds];
    
    // Apply gravity to the acceleration of the jumper
    [jumper setDy:[jumper dy] - .2];
    
    // Apply the tilt.  Limit maximum tilt to + or - 5
    //[jumper setDx:[jumper dx] + tilt];
    //tilt;
    
    [jumper setDx:10*tilt];
    //    if([jumper dx] == 10 * tilt)
    //        NSLog(@"Good!");
    if ([jumper dx] > 3)
        [jumper setDx:3];
    if (tilt < -3)
        [jumper setDx:-3];
    
    // Jumper moves in the direction of gravity
    CGPoint p = [jumper center];
    p.x += [jumper dx];
    p.y -= [jumper dy];
    
    if(history > p.y)
    {
        score++;
        history = p.y;
       
    }
    
    
    
    [self.delegate updatelabel];
    
    // If the jumper has fallen below the bottom of the screen,
    // add a positive velocity to move him
    if (p.y > bounds.size.height)
    {
        [jumper setDy:7];
        p.y = bounds.size.height;
        [_delegate gameover];
    }
    
    // If we've gone past the top of the screen, wrap around
    if (p.y < (bounds.size.height*0.2)){
        //    {p.y += bounds.size.height;
        [self arrangeBricks: bounds.size.height*0.2 - p.y];
        [jumper setDy: 0];
        score++;
        history = bounds.size.height*0.2;
        [self.delegate updatelabel];
    }
    
    // If we have gone too far left, or too far right, wrap around
    if (p.x < 0)
    {p.x += bounds.size.width;[_delegate gameover];}
    if (p.x > bounds.size.width)
    {p.x -= bounds.size.width;[_delegate gameover];}
    
    // If we are moving down, and we touch a brick, we get
    // a jump to push us up.
    if ([jumper dy] < 0)
    {
        for (Brick *brick in bricks)
        {
            
            CGRect b = [brick frame];
            CGRect c =CGRectInset(b, 0, -b.size.height);
            if (CGRectContainsPoint(c, p))
            {
                // Yay!  Bounce!
                //NSLog(@"Bounce!, %d", score);
                //score++;
                [jumper setDy:7.5];
                [jumper setDx:0];
                tilt = 0;
                break;
            }
        }
    }
    
    [jumper setCenter:p];
    // NSLog(@"Timestamp %f", ts);
}


@end

