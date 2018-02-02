//
//  TileView.m
//  p06-chen-liu
//
//  Created by MingzhaoChen on 4/14/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "TileView.h"

@implementation TileView
@synthesize label;
@synthesize value;


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:label];
        [label setText:@""];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self setBackgroundColor:[UIColor orangeColor]];
    }
    return self;
}

-(void)updateLabel
{
    if (value == 0)
    {
        //[label setText:@""];
    //[label setBackgroundColor:[UIColor orangeColor]];
       // NSLog(@"ssssssss");
        UIGraphicsBeginImageContext(label.frame.size);
        [[UIImage imageNamed:@"ori2.png"] drawInRect:label.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        label.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    else if(value == 1)
    {
//        [label setBackgroundColor:[UIColor whiteColor]];
        
        UIGraphicsBeginImageContext(label.frame.size);
        [[UIImage imageNamed:@"bai.png"] drawInRect:label.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        label.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    else if(value == 2)
    {
        //[label setBackgroundColor:[UIColor blackColor]];
    
    UIGraphicsBeginImageContext(label.frame.size);
    [[UIImage imageNamed:@"hei.png"] drawInRect:label.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    label.backgroundColor = [UIColor colorWithPatternImage:image];
    }
}
@end
