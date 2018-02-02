//
//  TileView.h
//  p06-chen-liu
//
//  Created by MingzhaoChen on 4/14/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#ifndef TileView_h
#define TileView_h

#import <UIKit/UIKit.h>

@interface TileView : UIView
@property (nonatomic, strong) UILabel *label;
@property (nonatomic) int value;

-(void)updateLabel;
@end


#endif /* TileView_h */
