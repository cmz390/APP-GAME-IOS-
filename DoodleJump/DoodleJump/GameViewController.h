//
//  GameViewController.h
//  DoodleJump
//
//  Created by MingzhaoChen on 2/19/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#ifndef GameViewController_h
#define GameViewController_h


#import <UIKit/UIKit.h>
#import "GameView.h"

@interface GameViewController : UIViewController <GameViewDelegate>
{
    UILabel *label1, *label2;
}
@property (nonatomic, strong) IBOutlet GameView *gameView;
@property (nonatomic) int score;
@property (nonatomic, retain) IBOutlet UILabel *label1, *label2;


@end

#endif /* GameViewController_h */
