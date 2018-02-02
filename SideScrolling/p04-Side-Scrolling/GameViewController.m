//
//  GameViewController.m
//  p04-Side-Scrolling
//
//  Created by MingzhaoChen on 2/26/17.
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

//- (void)viewDidLoad {
//    [super viewDidLoad];
////
////    // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
////    // including entities and graphs.
////    GKScene *scene = [GKScene sceneWithFileNamed:@"GameScene"];
////    
////    // Get the SKScene from the loaded GKScene
////    GameScene *sceneNode = (GameScene *)scene.rootNode;
////    
////    // Copy gameplay related content over to the scene
////    sceneNode.entities = [scene.entities mutableCopy];
////    sceneNode.graphs = [scene.graphs mutableCopy];
////    
////    // Set the scale mode to scale to fit the window
////    sceneNode.scaleMode = SKSceneScaleModeAspectFill;
////    
//    SKView *skView = (SKView *)self.view;
//    
//    // Present the scene
//    //[skView presentScene:sceneNode];
//    
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
//    
//    SKScene * scene = [GameScene sceneWithSize:skView.bounds.size];
//    scene.scaleMode = SKSceneScaleModeAspectFill;
//    
//    [skView presentScene:scene];
//}

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
