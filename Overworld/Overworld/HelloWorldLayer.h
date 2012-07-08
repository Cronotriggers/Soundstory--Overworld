//
//  HelloWorldLayer.h
//  Overworld
//
//  Created by Matthew LoPresti on 7/4/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#define CENTER_POINT_X 240
#define CENTER_POINT_Y 160
#define MAP_DRAG 0.4
#define PLAYER_SPEED 15
#define CAMERA_RESET_MIN 1
#define  CAMERA_SPEED 2
#define TOTAL_NUM_TOWNS 100

// HelloWorldLayer
@interface HelloWorldLayer : CCLayerColor
{
    CGPoint init_touch, destination, speed;
    CCSprite *bg1, *bg2, *bg3, *bg4;
    CCSprite *char_location;
    BOOL isCharMoving, isPaused, isCameraResetting;
    NSMutableArray *townsArray;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(void) createTowns;
-(void) update:(ccTime) dt;
-(void) moveCharToDestination:(ccTime) dt;
-(void) resetCamera:(ccTime) dt;

@end
