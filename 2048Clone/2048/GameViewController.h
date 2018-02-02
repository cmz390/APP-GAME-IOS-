//
//  GameViewController.h
//  2048
//
//  Created by MingzhaoChen on 2/5/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#ifndef GameViewController_h
#define GameViewController_h


#endif /* GameViewController_h */

#import <UIKit/UIKit.h>
@interface GameViewController : UIView

- (instancetype)initWithFrame:(CGRect)frame andContent:(int)demension;


- (void)getChangeWithDirection:(int)direct;


@end
