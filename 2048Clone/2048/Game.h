//
//  Game.h
//  2048
//
//  Created by MingzhaoChen on 2/7/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//

#ifndef Game_h
#define Game_h



#import <UIKit/UIKit.h>

@interface Game : UIViewController
{
    UILabel *label1, *label2, *label3, *label4, *label5, *label6, *label7,*label8, *label9, *label10, *label11, *label12, *label13, *label14, *label15, *label16,*score;
    

}
@property (nonatomic, retain) IBOutlet UILabel *label1, *label2, *label3, *label4, *label5, *label6, *label7,*label8, *label9, *label10, *label11, *label12, *label13, *label14, *label15, *label16,*score;

@end




#endif /* Game_h */
