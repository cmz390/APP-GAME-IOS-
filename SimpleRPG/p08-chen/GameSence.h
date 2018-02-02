//
//  GameSence.h
//  p08-chen
//
//  Created by MingzhaoChen on 5/8/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#ifndef GameSence_h
#define GameSence_h


#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

@interface GameScence : SKScene

@property (nonatomic) NSMutableArray<GKEntity *> *entities;
@property (nonatomic) NSMutableDictionary<NSString*, GKGraph *> *graphs;

@end

#endif /* GameSence_h */
