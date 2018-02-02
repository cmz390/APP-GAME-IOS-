//
//  GameScene.h
//  p07-chen-liu-hu
//
//  Created by MingzhaoChen on 4/30/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#ifndef GameScene_h
#define GameScene_h
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

@interface GameScene : SKScene <NSStreamDelegate, SKPhysicsContactDelegate> {
    
    
    NSInputStream	*inputStream;
    NSOutputStream	*outputStream;

    
}


@property (nonatomic) NSMutableArray<GKEntity *> *entities;
@property (nonatomic) NSMutableDictionary<NSString*, GKGraph *> *graphs;

//@property (nonatomic) SKSpriteNode *penguin;
//@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
//@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@property (nonatomic, retain) NSInputStream *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;

@end
#endif /* GameScene_h */
