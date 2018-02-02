//
//  GameScene.h
//  p04-Side-Scrolling
//
//  Created by MingzhaoChen on 2/26/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

@interface GameScene : SKScene

@property (nonatomic) NSMutableArray<GKEntity *> *entities;
@property (nonatomic) NSMutableDictionary<NSString*, GKGraph *> *graphs;

@end
