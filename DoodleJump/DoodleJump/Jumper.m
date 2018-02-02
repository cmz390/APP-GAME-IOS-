//
//  Jumper.m
//  DoodleJump
//
//  Created by MingzhaoChen on 2/18/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Jumper.h"

@implementation Jumper
@synthesize dx, dy;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 */
//
 - (void)drawRect:(CGRect)rect {
  //Drawing code
     UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 200)];
     [[UIColor colorWithRed:0.5 green:0.5 blue:0.9 alpha:1.0] setStroke];
     [path setLineWidth:10];
     [path stroke];
 }


@end
