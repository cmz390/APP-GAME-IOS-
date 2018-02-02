//
//  GameSence.m
//  p08-chen
//
//  Created by MingzhaoChen on 5/8/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GameSence.h"
#import "SenceChange.h"
#import <AVFoundation/AVFoundation.h>

@interface GameScence () <SKPhysicsContactDelegate>

@property (nonatomic) SKSpriteNode *penguin;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;


@end


@implementation GameScence
{
    AVPlayer *_player;
    SKVideoNode *_videoNode;
}

int smarker = 0;
int bosscome = 0;
int bossposition = 0;

-(void)setupMovie
{
    if(smarker < 1){
    NSURL *fileURL = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:@"beginmovie" ofType:@"mov"]];
    _player = [AVPlayer playerWithURL: fileURL];
    
    _videoNode = [[SKVideoNode alloc] initWithAVPlayer:_player];
    _videoNode.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _videoNode.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame));
    
    [self addChild:_videoNode];
    
    _player.volume = 1.0;
    
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];

    label.text = @"Skip or continue";

    label.fontSize = 24;
    label.fontColor = [SKColor redColor];
    label.position = CGPointMake(self.size.width/2,  50);
    [self addChild:label];
    [_videoNode play];
    }
    
    //[self addback];
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//
//}
//
//-(void)update:(CFTimeInterval)currentTime
//{
//    //
//}


int penguinY;
int penguinX;
int destroyed;
int bossdestroyed;
int addmore;

//Math
static const uint32_t projectileCategory     =  0x1 << 0;
static const uint32_t monsterCategory        =  0x1 << 1;
static const uint32_t penguinCategory        =  0x1 << 2;
static const uint32_t bossCategory           =  0x1 << 3;

//static inline CGPoint rwAdd(CGPoint a, CGPoint b) {
//    return CGPointMake(a.x + b.x, a.y + b.y);
//}
//
//static inline CGPoint rwSub(CGPoint a, CGPoint b) {
//    return CGPointMake(a.x - b.x, a.y - b.y);
//}
//
//static inline CGPoint rwMult(CGPoint a, float b) {
//    return CGPointMake(a.x * b, a.y * b);
//}

static inline float rwLength(CGPoint a) {
    return sqrtf(a.x * a.x + a.y * a.y);
}

// Makes a vector have a length of 1
static inline CGPoint rwNormalize(CGPoint a) {
    float length = rwLength(a);
    return CGPointMake(a.x / length, a.y / length);
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //
    smarker ++;
    if(smarker >1){
    // 1 - Choose one of the touches to work with
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    penguinY = location.y;
    penguinX = location.x;
    
    SKSpriteNode * projectile = [SKSpriteNode spriteNodeWithImageNamed:@"kf"];
    projectile.position = self.penguin.position;
    
    
    CGPoint offset = CGPointMake(location.x - projectile.position.x, location.y - projectile.position.y);
    [self addChild:projectile];
    
    
    // 6 - Get the direction of where to shoot
    CGPoint direction = rwNormalize(offset);
    
    // 7 - Make it shoot far enough to be guaranteed off screen
    CGPoint shootAmount = CGPointMake(direction.x * 1000, direction.y * 1000);
    
    // 8 - Add the shoot amount to the current position
    CGPoint realDest = CGPointMake(shootAmount.x + projectile.position.x, shootAmount.y + projectile.position.y);
    
    // 9 - Create the actions
    float velocity = 480.0/1.0;
    float realMoveDuration = self.size.width / velocity;
    SKAction * actionMove = [SKAction moveTo:realDest duration:realMoveDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    [projectile runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
    projectile.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:projectile.size.width/2];
    projectile.physicsBody.dynamic = YES;
    projectile.physicsBody.categoryBitMask = projectileCategory;
    projectile.physicsBody.contactTestBitMask = monsterCategory;
    projectile.physicsBody.collisionBitMask = 0;
    projectile.physicsBody.usesPreciseCollisionDetection = YES;
        
    }
    else{
        [_videoNode pause];
        [_videoNode removeFromParent];
        //[self removeAllChildren];
        [self addback];
    }

}

- (void)update:(NSTimeInterval)currentTime {
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    if(smarker >=1){
    self.lastSpawnTimeInterval += timeSinceLast;
    [self penguinMove];
    if(self.lastSpawnTimeInterval > 1.5){
        self.lastSpawnTimeInterval = 0;
        if(addmore==1 && bosscome ==0) [self addMonster];
        if(bosscome == 1) {[self addMonster2:0];
            [self addMonster2:1];
            [self addMonster2:2];
            //[self addMonster2:3];
        }
        
    }
    }
}



-(id)initWithSize:(CGSize)size{
    
    if(self = [super initWithSize:size]){
        
 
        if(smarker >1) [self addback];
        else          [self setupMovie];

        
        
        
//        SKVideoNode *sample = [SKVideoNode videoNodeWithFileNamed:@"beginmovie.mov"];
//        sample.position = CGPointMake(CGRectGetMidX(self.frame),
//                                      CGRectGetMidY(self.frame));
//        [self addChild: sample];
//        [sample play];
        

//        self.penguin = [SKSpriteNode spriteNodeWithImageNamed: @"bear"];
//        self.penguin.position = CGPointMake(self.penguin.size.width/2, self.frame.size.height/2);
//        penguinY = self.frame.size.height/2;
//        penguinX = self.penguin.size.width/2;
//        [self addChild:self.penguin];
//        self.physicsWorld.gravity = CGVectorMake(0,0);
//        self.physicsWorld.contactDelegate = self;
//        
//        destroyed = 0;
//        bossdestroyed = 0;
//        addmore = 1;
//        _penguin.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_penguin.size]; // 1
//        _penguin.physicsBody.dynamic = YES; // 2
//        _penguin.physicsBody.categoryBitMask = penguinCategory; // 3
//        _penguin.physicsBody.contactTestBitMask = monsterCategory | bossCategory; // 4
//        _penguin.physicsBody.collisionBitMask = 0; // 5
    }
    return self;
}

-(void) addback
{

    //[self removeAllChildren];
    self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"back"];
    background.size = self.frame.size;
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:background];
    
            self.penguin = [SKSpriteNode spriteNodeWithImageNamed: @"knight"];
            self.penguin.position = CGPointMake(self.penguin.size.width/2+30, self.frame.size.height/2);
            penguinY = self.frame.size.height/2;
            penguinX = self.penguin.size.width/2;
            [self addChild:self.penguin];
            self.physicsWorld.gravity = CGVectorMake(0,0);
            self.physicsWorld.contactDelegate = self;
    
            destroyed = 0;
            bossdestroyed = 0;
            addmore = 1;
            _penguin.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_penguin.size]; // 1
            _penguin.physicsBody.dynamic = YES; // 2
            _penguin.physicsBody.categoryBitMask = penguinCategory; // 3
            _penguin.physicsBody.contactTestBitMask = monsterCategory | bossCategory; // 4
            _penguin.physicsBody.collisionBitMask = 0; // 5
}






- (void) penguinMove{
    
    int actualDuration = 1.0;
    
    SKAction * actionMove = [SKAction moveTo: CGPointMake(self.penguin.size.width/2+30, penguinY) duration:actualDuration];
    
    [_penguin runAction:[SKAction sequence:@[actionMove]]];
}

- (void) addMonster{
    
    SKSpriteNode *monster = [SKSpriteNode spriteNodeWithImageNamed:@"pen"];
    int minY = monster.size.height /2;
    int rangeY = self.frame.size.height - monster.size.height;
    int actualY = (arc4random() % rangeY) + minY;
    
    monster.position = CGPointMake(self.frame.size.width + monster.size.width/2, actualY);
    
    
    [self addChild:monster];
    
    int minDuration = 2.0;
    int rangeDuration = 2.0;
    int actualDuration = (arc4random()% rangeDuration) + minDuration;
    
    SKAction * actionMove = [SKAction moveTo: CGPointMake(-monster.size.width/2, actualY) duration:actualDuration*4];
    
    
    SKAction *actionMoveDone = [SKAction removeFromParent];
    
    [monster runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
    
    
    monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:monster.size]; // 1
    monster.physicsBody.dynamic = YES; // 2
    monster.physicsBody.categoryBitMask = monsterCategory; // 3
    monster.physicsBody.contactTestBitMask = projectileCategory; // 4
    monster.physicsBody.collisionBitMask = 0; // 5
    
    
}
- (void) addMonster2: (int) i{
    
    SKSpriteNode *monster = [SKSpriteNode spriteNodeWithImageNamed:@"fire"];
    //int minY = monster.size.height /2;
    //int rangeY = self.frame.size.height - monster.size.height;
    //int actualY = (arc4random() % rangeY) + minY;
    
    monster.position = CGPointMake(bossposition - 10, self.frame.size.height/2);
    
    
    [self addChild:monster];
    
    int minDuration = 2.0;
   // int rangeDuration = 2.0;
    int actualDuration =  minDuration;
    
    SKAction * actionMove = [SKAction moveTo: CGPointMake(-monster.size.width/2, i * self.frame.size.height/2) duration:actualDuration*4];
    
    
    SKAction *actionMoveDone = [SKAction removeFromParent];
    
    [monster runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
    
    
    monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:monster.size]; // 1
    monster.physicsBody.dynamic = YES; // 2
    monster.physicsBody.categoryBitMask = monsterCategory; // 3
    monster.physicsBody.contactTestBitMask = projectileCategory; // 4
    monster.physicsBody.collisionBitMask = 0; // 5
    
    
}


- (void) addBoss{
    
    SKSpriteNode *boss = [SKSpriteNode spriteNodeWithImageNamed:@"boss"];
    bosscome =1;
    
    bossposition = self.frame.size.width - boss.size.width;
    boss.position = CGPointMake(self.frame.size.width - boss.size.width/2, self.frame.size.height/2);
    
    
    [self addChild:boss];
    
    int actualDuration = 4.0;
    
    SKAction * actionMove = [SKAction moveTo: CGPointMake(self.frame.size.width - boss.size.width/2, self.frame.size.height/2) duration:actualDuration*2];
    
    
    SKAction *actionMoveDone = [SKAction removeFromParent];
    
    [boss runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    boss.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:boss.size]; // 1
    boss.physicsBody.dynamic = YES; // 2
    boss.physicsBody.categoryBitMask = bossCategory; // 3
    boss.physicsBody.contactTestBitMask = projectileCategory; // 4
    boss.physicsBody.collisionBitMask = 0; // 5
    
    
}



- (void)projectile:(SKSpriteNode *)projectile didCollideWithMonster:(SKSpriteNode *)monster {
    [projectile removeFromParent];
    [monster removeFromParent];
    destroyed++;
    if (destroyed > 10) {
        destroyed = 0;
        addmore = 0;
        [self addBoss];
        //        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        //        SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:YES];
        //        [self.view presentScene:gameOverScene transition: reveal];
    }
}

- (void)projectileboss:(SKSpriteNode *)projectile didCollideWithMonster:(SKSpriteNode *)boss {
    [projectile removeFromParent];
    bossdestroyed++;
    if (bossdestroyed > 10) {
        bossdestroyed = 0;
        bosscome = 0;
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * gameOverScene = [[SenceChange alloc] initWithSize:self.size won:YES];
        [self.view presentScene:gameOverScene transition: reveal];
    }
}


-(void)Gameover: (SKSpriteNode *)monster{
    //[monster removeFromParent];
    SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
    SKScene * gameOverScene = [[SenceChange alloc] initWithSize:self.size won:NO];
    [self.view presentScene:gameOverScene transition: reveal];
    destroyed = 0;
    bosscome  = 0;
}




- (void)didBeginContact:(SKPhysicsContact *)contact
{
    // 1
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    // 2
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
        (secondBody.categoryBitMask & monsterCategory) != 0)
    {
        [self projectile:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
    }
    
    
    // 3
    if ((firstBody.categoryBitMask & monsterCategory) != 0 &&
        (secondBody.categoryBitMask & penguinCategory) != 0)
    {
        [self Gameover:(SKSpriteNode *) firstBody.node];
    }
    
    // 2
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
        (secondBody.categoryBitMask & bossCategory) != 0)
    {
        [self projectileboss:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
    }
    
    // 3
    if ((firstBody.categoryBitMask & penguinCategory) != 0 &&
        (secondBody.categoryBitMask & bossCategory) != 0)
    {
        [self Gameover:(SKSpriteNode *) firstBody.node];
    }
    
}

//
@end
