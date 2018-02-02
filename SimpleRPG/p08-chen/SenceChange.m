//
//  SenceChange.m
//  p08-chen
//
//  Created by MingzhaoChen on 5/8/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>


//
//  GameOverScence.m
//  p04-Side-Scrolling
//
//  Created by MingzhaoChen on 3/13/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "SenceChange.h"
#import "GameSence.h"

@implementation SenceChange
{
    AVPlayer *_player;
    SKVideoNode *_videoNode;
}




-(void)setupMovie
{
    if(1){
        NSURL *fileURL = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:@"happy" ofType:@"mov"]];
        _player = [AVPlayer playerWithURL: fileURL];
        
        _videoNode = [[SKVideoNode alloc] initWithAVPlayer:_player];
        _videoNode.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
        _videoNode.position = CGPointMake(CGRectGetMidX(self.frame),
                                          CGRectGetMidY(self.frame));
        
        [self addChild:_videoNode];
        
        _player.volume = 1.0;
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        label.text = @"Happy ending!~";
        
        label.fontSize = 24;
        label.fontColor = [SKColor redColor];
        label.position = CGPointMake(self.size.width/2,  50);
        [self addChild:label];
        [_videoNode play];
    }
    
    //[self addback];
}

-(id)initWithSize:(CGSize)size won:(BOOL)won {
    if (self = [super initWithSize:size]) {
        
        // 1
        if(won){
            
            [self setupMovie];
            
        }
        else{
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"back"];
        background.size = self.frame.size;
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        // 3
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        if(won){
            label.text =@"Victory!";}
        else
        {
            label.text = @"Game Over, try again...!";
        }
        label.fontSize = 40;
        label.fontColor = [SKColor redColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:label];
        
        // 4
        [self runAction:
         [SKAction sequence:@[
                              [SKAction waitForDuration:3.5],
                              [SKAction runBlock:^{
             // 5
             SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
             SKScene * myScene = [[GameScence alloc] initWithSize:self.size];
             [self.view presentScene:myScene transition: reveal];
         }]
                              ]]
         ];
            
        }
        
    }
    return self;
}

@end
