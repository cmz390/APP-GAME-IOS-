//
//  GameView.h
//  DoodleJump
//
//  Created by MingzhaoChen on 2/18/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#ifndef GameView_h
#define GameView_h


#import <UIKit/UIKit.h>
#import "Jumper.h"
#import "Brick.h"




@class GameView;
@protocol GameViewDelegate <NSObject>

@optional
- (void)updatelabel;
-(void)gameover;
@end

@interface GameView : UIView {
    
}
@property (nonatomic, weak) id <GameViewDelegate> delegate;
@property (nonatomic, strong) Jumper *jumper;
@property (nonatomic, strong) NSMutableArray *bricks;
@property (nonatomic) float tilt;
@property (nonatomic) int score;
-(void)arrange:(CADisplayLink *)sender;
@end


#endif /* GameView_h */
