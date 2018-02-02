//
//  GameView.h
//  p06-chen-liu
//
//  Created by MingzhaoChen on 4/14/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#ifndef GameView_h
#define GameView_h

#import <UIKit/UIKit.h>
#import "TileView.h"

@interface GameView : UIView
@property (nonatomic, strong) NSArray *directions;
@property (nonatomic, strong) NSMutableArray *tiles;

@end


#endif /* GameView_h */
