//
//  GameViewController.m
//  p07-chen-liu-hu
//
//  Created by MingzhaoChen on 4/30/17.
//  Copyright © 2017 MingzhaoChen. All rights reserved.
//


#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController


-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    SKView * skView = (SKView *) self.view;
    
    if(!skView.scene)
    {
        // Present the scene
        //[skView presentScene:sceneNode];
        
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        SKScene * scene = [GameScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        [skView presentScene:scene];
    }
    
}


- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
