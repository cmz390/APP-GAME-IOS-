//
//  GameScene.m
//  p07-chen-liu-hu
//
//  Created by MingzhaoChen on 4/30/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//
#import "GameScene.h"
#import "GameOverScence.h"

//@interface GameScene () <SKPhysicsContactDelegate>
//
//@property (nonatomic) SKSpriteNode *penguin;
//@property (nonatomic) SKSpriteNode *penguin2;
//
//@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
//@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
//
//
//@end
//
//
//@implementation GameScene
//
//@synthesize inputStream, outputStream;
//
//
//


#import "GameScene.h"
#import "GameOverScence.h"

@interface GameScene () <NSStreamDelegate, SKPhysicsContactDelegate>

@property (nonatomic) SKSpriteNode *penguin;
@property (nonatomic) SKSpriteNode *penguin2;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;


@end


@implementation GameScene


@synthesize inputStream, outputStream;
//
int tpid;
int penguinY[2];
int penguinX[2];
int destroyed[2];
int winindex[2];
int oldround[2];
int newround[2];
int bossdestroyed;
int addmore;
int gamebegin;


//
//int roundnum = 0;
//int actionmarker = 0;
////Math
static const uint32_t projectileCategory     =  0x1 << 0;
static const uint32_t projectile2Category     =  0x1 << 1;

static const uint32_t monsterCategory        =  0x1 << 2;

static const uint32_t penguinCategory        =  0x1 << 3;
static const uint32_t penguin2Category       =  0x1 << 4;

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


- (void) initNetworkCommunication {
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"192.168.1.102", 80, &readStream, &writeStream);
    
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
    
}

//
-(id)initWithSize:(CGSize)size{
    
    if(self = [super initWithSize:size]){
        
        tpid = 0;
        newround[0] = 0;
        newround[1] = 0;
        oldround[0] = 0;
        oldround[1] = 0;
        penguinY[0] = 0;
        penguinX[0] = 0;
        penguinY[1] = 0;
        penguinX[1] = 0;
        gamebegin = 0;
        //Connect to Server
        [self initNetworkCommunication];
        
        
        sleep(1);
        
        NSLog(@"sfhkdshf:%d", tpid);
        //        while(gamebegin == 0)
        //
        //
        //self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"b"];
        background.size = self.frame.size;
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        
        //Two player: local: penguin, remote: penguin2
        //local player:
        if(tpid == 0)
        {self.penguin = [SKSpriteNode spriteNodeWithImageNamed: @"bear"];}
        else
        {
            self.penguin = [SKSpriteNode spriteNodeWithImageNamed: @"boss"];
        }
        self.penguin.position = CGPointMake(self.frame.size.width/8, self.frame.size.height/2);
        
        penguinY[tpid] = self.frame.size.height/2;
        penguinX[tpid] = self.frame.size.width/8;
        
        [self addChild:self.penguin];
        
        //remote player:
        if(tpid == 0)
        {self.penguin2 = [SKSpriteNode spriteNodeWithImageNamed: @"boss"];}
        else
        {
            self.penguin2 = [SKSpriteNode spriteNodeWithImageNamed: @"bear"];
        }
        self.penguin2.position = CGPointMake(self.frame.size.width * 7 /8, self.frame.size.height/2);
        
        penguinY[(tpid+1)%2] = self.frame.size.height/2;
        penguinX[(tpid+1)%2] = self.frame.size.width * 7 /8;
        
        [self addChild:self.penguin2];
        
        
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
        destroyed[tpid] = 0;
        destroyed[(tpid+1)%2] = 0;
        
        bossdestroyed = 0;
        addmore = 1;
        
        
        _penguin.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_penguin.size]; // 1
        _penguin.physicsBody.dynamic = YES; // 2
        _penguin.physicsBody.categoryBitMask = penguinCategory; // 3
        _penguin.physicsBody.contactTestBitMask = monsterCategory; // 4
        _penguin.physicsBody.collisionBitMask = 0; // 5
        
        
        
        _penguin2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_penguin2.size]; // 1
        _penguin2.physicsBody.dynamic = YES; // 2
        _penguin2.physicsBody.categoryBitMask = penguin2Category; // 3
        _penguin2.physicsBody.contactTestBitMask = monsterCategory ; // 4
        _penguin2.physicsBody.collisionBitMask = 0; // 5
        
        
        [self set];
        
        
    }
    return self;
}
//
//
////
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 1 - Choose one of the touches to work with
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    penguinX[tpid] = location.x;
    
    if(location.x > self.frame.size.width/2)
        penguinX[tpid] = self.frame.size.width/2.2;
    penguinY[tpid] = location.y;
    newround[tpid] ++;
    [self addprojectile];
    
}


-(void) addprojectile{
    
    //--------------------update to the server-----------------
    if(newround[tpid]> oldround[tpid] || newround[(tpid+1)%2] > oldround[(tpid+1)%2])
        [self set];
    
    sleep(0.03);
    
    //--------------------fetch from the server----------------
    if(penguinX[(tpid+1)%2]!=0){
        penguinX[(tpid+1)%2] = self.frame.size.width - penguinX[(tpid+1)%2];
        
        if(penguinX[(tpid+1)%2] < self.frame.size.width/2)
            penguinX[tpid] = self.frame.size.width - self.frame.size.width/2.2;
        
        penguinY[(tpid+1)%2] = penguinY[(tpid+1)%2];}
    
    
    if(newround[tpid]> oldround[tpid]){
        
        oldround[tpid] = newround[tpid];
        SKSpriteNode * projectile = [SKSpriteNode spriteNodeWithImageNamed:@"fish"];
        projectile.position = self.penguin.position;
        
        
        CGPoint offset = CGPointMake(penguinX[tpid] - projectile.position.x, penguinY[tpid] - projectile.position.y);
        [self addChild:projectile];
        
        
        // 6 - Get the direction of where to shoot
        CGPoint direction = rwNormalize(offset);
        
        // 7 - Make it shoot far enough to be guaranteed off screen
        CGPoint shootAmount = CGPointMake(direction.x * 1000, direction.y * 1000);
        
        // 8 - Add the shoot amount to the current position
        CGPoint realDest = CGPointMake(shootAmount.x + projectile.position.x, shootAmount.y + projectile.position.y);
        
        // 9 - Create the actions
        float velocity = 480.0/1.0;
        float realMoveDuration = self.size.width / velocity * 2;
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
    
    
    if(newround[(tpid+1)%2] > oldround[(tpid+1)%2])
    {
        oldround[(tpid+1)%2] = newround[(tpid+1)%2];
        SKSpriteNode * projectile2 = [SKSpriteNode spriteNodeWithImageNamed:@"fish"];
        projectile2.position = self.penguin2.position;
        
        
        CGPoint offset2 = CGPointMake( penguinX[(tpid+1)%2] - projectile2.position.x, penguinY[(tpid+1)%2] - projectile2.position.y);
        [self addChild:projectile2];
        
        
        // 6 - Get the direction of where to shoot
        CGPoint direction2 = rwNormalize(offset2);
        
        // 7 - Make it shoot far enough to be guaranteed off screen
        CGPoint shootAmount2 = CGPointMake(direction2.x * 1000, direction2.y * 1000);
        
        // 8 - Add the shoot amount to the current position
        CGPoint realDest2 = CGPointMake(shootAmount2.x + projectile2.position.x, shootAmount2.y + projectile2.position.y);
        
        // 9 - Create the actions
        float velocity2 = 480.0/1.0;
        float realMoveDuration2 = self.size.width / velocity2 *2;
        SKAction * actionMove2 = [SKAction moveTo:realDest2 duration:realMoveDuration2];
        SKAction * actionMoveDone2 = [SKAction removeFromParent];
        [projectile2 runAction:[SKAction sequence:@[actionMove2, actionMoveDone2]]];
        
        projectile2.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:projectile2.size.width/2];
        projectile2.physicsBody.dynamic = YES;
        projectile2.physicsBody.categoryBitMask = projectile2Category;
        projectile2.physicsBody.contactTestBitMask = monsterCategory;
        projectile2.physicsBody.collisionBitMask = 0;
        projectile2.physicsBody.usesPreciseCollisionDetection = YES;
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
    
    self.lastSpawnTimeInterval += timeSinceLast;
    [self penguinMove];
    if(self.lastSpawnTimeInterval > 1){
        self.lastSpawnTimeInterval = 0;
        if(1) {[self addMonster:1];
            [self addMonster:2];  [self addMonster:3];
        }
        
    }
}









- (void) penguinMove{
    
    int actualDuration = 2.0;
    
    SKAction * actionMove1 = [SKAction moveTo: CGPointMake(self.frame.size.width/8, penguinY[tpid]) duration:actualDuration];
    
    [_penguin runAction:[SKAction sequence:@[actionMove1]]];
    
    SKAction * actionMove2 = [SKAction moveTo: CGPointMake(7 * self.frame.size.width /8, penguinY[(tpid+1)%2]) duration:actualDuration];
    
    [_penguin2 runAction:[SKAction sequence:@[actionMove2]]];
    
}

- (void) addMonster: (int) n{
    
    SKSpriteNode *monster = [SKSpriteNode spriteNodeWithImageNamed:@"pen"];
    
    //    int minY = monster.size.height /2;
    //    int rangeY = self.frame.size.height - monster.size.height;
    //    int actualY = (arc4random() % rangeY) + minY;
    
    int fixed_X = self.frame.size.width/2;
    if(n==2) fixed_X = fixed_X - self.frame.size.width/6;
    if(n==3) fixed_X = fixed_X + self.frame.size.width/6;
    
    monster.position = CGPointMake(self.frame.size.width/2, self.frame.size.height + monster.size.height);
    
    
    [self addChild:monster];
    
    //    int minDuration = 2.0;
    //    int rangeDuration = 2.0;
    //int actualDuration = (arc4random()% rangeDuration) + minDuration;
    
    int actualDuration = 1;
    SKAction * actionMove = [SKAction moveTo: CGPointMake(fixed_X, - monster.size.height) duration:actualDuration*4];
    
    
    SKAction *actionMoveDone = [SKAction removeFromParent];
    
    [monster runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
    
    
    monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:monster.size]; // 1
    monster.physicsBody.dynamic = YES; // 2
    monster.physicsBody.categoryBitMask = monsterCategory; // 3
    monster.physicsBody.contactTestBitMask = projectileCategory | projectile2Category; // 4
    monster.physicsBody.collisionBitMask = 0; // 5
    
    
}

//
//- (void) addBoss{
//
//    SKSpriteNode *boss = [SKSpriteNode spriteNodeWithImageNamed:@"boss"];
//
//    boss.position = CGPointMake(self.frame.size.width + boss.size.width/2, self.frame.size.height/2);
//
//
//    [self addChild:boss];
//
//    int actualDuration = 4.0;
//
//    SKAction * actionMove = [SKAction moveTo: CGPointMake(-boss.size.width/2, self.frame.size.height/2) duration:actualDuration*10];
//
//
//    SKAction *actionMoveDone = [SKAction removeFromParent];
//
//    [boss runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
//    boss.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:boss.size]; // 1
//    boss.physicsBody.dynamic = YES; // 2
//    boss.physicsBody.categoryBitMask = bossCategory; // 3
//    boss.physicsBody.contactTestBitMask = projectileCategory; // 4
//    boss.physicsBody.collisionBitMask = 0; // 5
//
//
//}



- (void)projectile1:(SKSpriteNode *)projectile didCollideWithMonster:(SKSpriteNode *)monster {
    [projectile removeFromParent];
    [monster removeFromParent];
    destroyed[tpid]++;
    if (destroyed[tpid] > 20) {
        destroyed[tpid] = 0;
        addmore = 0;
        
        //win
        //[self addBoss];
        [self gameovermessage];
        [self disconnect];
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:YES];
        [self.view presentScene:gameOverScene transition: reveal];
        destroyed[tpid] = 0;
        destroyed[(tpid+1)%2] = 0;
    }
}

- (void)projectile2:(SKSpriteNode *)projectile didCollideWithMonster:(SKSpriteNode *)monster {
    [projectile removeFromParent];
    [monster removeFromParent];
    destroyed[(tpid+1)%2]++;
    if (destroyed[(tpid+1)%2] > 20) {
        destroyed[(tpid+1)%2] = 0;
        addmore = 0;
        
        //lose
        
        //[self addBoss];
        //[self disconnect];
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:NO];
        [self.view presentScene:gameOverScene transition: reveal];
        destroyed[tpid] = 0;
        destroyed[(tpid+1)%2] = 0;
    }
}

//
-(void)Gameover{
    //[monster removeFromParent];
    SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
    SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:NO];
    [self.view presentScene:gameOverScene transition: reveal];
    destroyed[tpid] = 0;
    destroyed[(tpid+1)%2] = 0;
}
//
//
//
//
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
        [self projectile1:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
    }
    
    
    // 3
    //    if ((firstBody.categoryBitMask & monsterCategory) != 0 &&
    //        (secondBody.categoryBitMask & penguinCategory) != 0)
    //    {
    //        [self Gameover:(SKSpriteNode *) firstBody.node];
    //    }
    
    // 2
    if ((firstBody.categoryBitMask & projectile2Category) != 0 &&
        (secondBody.categoryBitMask & monsterCategory) != 0)
    {
        [self projectile2:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
    }
    
    // 3
    //    if ((firstBody.categoryBitMask & penguinCategory) != 0 &&
    //        (secondBody.categoryBitMask & bossCategory) != 0)
    //    {
    //        [self Gameover:(SKSpriteNode *) firstBody.node];
    //    }
    
}
//
//
////@end
//
//
////
////
////
////
//////################################Sever Part###################################
////
////
//////@synthesize messages;
////
////
////
////// round, healty, choice
////
////
////
////
//////Get, get pid from server,
////
//////Set round, healty, choice
////
//////fetch round, healty, choice
////
////
//////        NSArray *list= [test componentsSeparatedByString:@"&"];
////
////////字符串分割三段，标识为&
//////NSArray *list= [test componentsSeparatedByString:@"&"];
//////segment0=list[0];
//////segment1=list[1];
//////segment2=list[2];
////
////
//////- (void)viewDidLoad {
//////    [super viewDidLoad];
//////    [self initNetworkCommunication];
//////    //messages = [[NSMutableArray alloc] init];
//////    [self get];
//////    // [self set];
//////
//////}
////
////
//////
//- (void) get {
//
//    NSString *response  = [NSString stringWithFormat:@"get:0:0:0:0:"];
//    NSLog(@"%@", response);
//    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
//    [outputStream write:[data bytes] maxLength:[data length]];
//
//}

-(void) set {
    //pid, status[pid], healty[pid],choice[pid]
    
    NSString *response  = [NSString stringWithFormat:@"set:%d:%d:%d:%d:",tpid, penguinX[tpid], penguinY[tpid], newround[tpid]];
    NSLog(@"set:%@", response);
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    
}
//
//
//- (void) fetch {
//
//    NSString *response  = [NSString stringWithFormat:@"fetch:0:0:0:0:"];
//    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
//    [outputStream write:[data bytes] maxLength:[data length]];
//
//}
//
//
////NSString *string = @"5";
////int value = [string intValue];
//
- (void) messageReceived:(NSString *)message {
    
    //[self.messages addObject:message];
    NSArray *list= [message componentsSeparatedByString:@":"];
    
    
    NSLog(@"%@", list[0]);
    if([list[0] isEqualToString:@"conpid"])
    {
        tpid = [list[1] intValue];
        gamebegin = 1;
        //tpid = tpid % 2;
        //[self set];
    }
    else if ([list[0] isEqualToString:@"content"])
    {
        NSLog(@"SB");
        
        
        
        penguinX[0] = [list[1] intValue];
        penguinY[0] = [list[2] intValue];
        newround[0] = [list[3] intValue];
        
        penguinX[1] = [list[4] intValue];
        penguinY[1] = [list[5] intValue];
        newround[1] = [list[6] intValue];
        
        [self addprojectile];
        
    }
    else if([list[0] isEqualToString:@"gameover"])
    {
        
        [self disconnect];
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:NO];
        [self.view presentScene:gameOverScene transition: reveal];
        destroyed[tpid] = 0;
        destroyed[(tpid+1)%2] = 0;
    }
    
    
}

//
////uodate healty, round
//-(void) updateStatus{
//
//    if(choice[pid] == 1 && choice[(pid+1)%2]==1)
//    {
//        healty[pid] -= 200;
//        healty[(pid+1)%2] -=200;
//
//    }
//    else if(choice[pid] == 1 && choice[(pid+1)%2]==2)
//    {
//        healty[pid] +=0;
//        healty[(pid+1)%2] -=100;
//    }
//    else if(choice[pid] == 2 && choice[(pid+1)%2]==1)
//    {
//        healty[pid] -=100;
//        healty[(pid+1)%2] +=0;
//    }
//    else{
//        healty[pid] -=0;
//        healty[(pid+1)%2] +=0;
//    }
//    //status[pid] ++;
//    [self set];
////    [_Healty1 setText:[NSString stringWithFormat:@"%d", healty[pid]]];
////    [_Healty2 setText:[NSString stringWithFormat:@"%d", healty[(pid+1)%2]]];
////
//}
//
//
//-(IBAction)attack
//{
//    choice[pid] = 1;
//    if(actionmarker == 0)
//    {
//        actionmarker =1;
//        status[pid]++;
//    }
//
//    [self set];
//
//}
//
//
//-(IBAction)defence
//{
//    choice[pid] = 2;
//    if(actionmarker == 0)
//    {
//        actionmarker =1;
//        status[pid]++;
//    }
//
//    [self set];
//
//}
//
//
//
//
//
//
//
//
//##################################Fixed Part for Sever ############################################




-(void) gameovermessage {
    //pid, status[pid], healty[pid],choice[pid]
    
    NSString *response  = [NSString stringWithFormat:@"gameover:%d:0:0:0:",tpid];
    NSLog(@"set:%@", response);
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    
}
- (void) disconnect {
    
    //[self gameovermessage];
    
    [inputStream close];
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream close];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream setDelegate:nil];
    inputStream = nil;
    [outputStream setDelegate:nil];
    outputStream = nil;
    
    
}


- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
    NSLog(@"stream event %lu", (unsigned long)streamEvent);
    
    switch (streamEvent) {
            
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
        case NSStreamEventHasBytesAvailable:
            
            if (theStream == inputStream) {
                
                uint8_t buffer[1024];
                int len;
                
                while ([inputStream hasBytesAvailable]) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        
                        if (nil != output) {
                            
                            NSLog(@"server said: %@", output);
                            //[self messageReceived:output];
                            [self performSelectorOnMainThread:@selector(messageReceived:) withObject:output waitUntilDone:NO];
                            
                        }
                    }
                }
            }
            break;
            
            
        case NSStreamEventErrorOccurred:
            
            NSLog(@"Can not connect to the host!");
            break;
            
        case NSStreamEventEndEncountered:
            
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            theStream = nil;
            
            break;
        default:
            NSLog(@"Unknown event");
    }
    
}

//
//



@end
