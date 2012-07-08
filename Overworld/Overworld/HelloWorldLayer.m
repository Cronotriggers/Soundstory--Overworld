//
//  HelloWorldLayer.m
//  Overworld
//
//  Created by Matthew LoPresti on 7/4/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "Town.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
    
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super initWithColor:ccc4(23,59,92,255)])) {
        
        bg1 = [CCSprite spriteWithFile:@"map.png"];
        bg2 = [CCSprite spriteWithFile:@"map.png"];
        bg3 = [CCSprite spriteWithFile:@"map.png"];
        bg4 = [CCSprite spriteWithFile:@"map.png"];
        
        bg1.position = ccp(CENTER_POINT_X - bg1.contentSize.width / 2, CENTER_POINT_Y + bg1.contentSize.height / 2);
        bg2.position = ccp(CENTER_POINT_X + bg2.contentSize.width / 2, CENTER_POINT_Y + bg2.contentSize.height / 2);
        bg3.position = ccp(CENTER_POINT_X + bg3.contentSize.width / 2, CENTER_POINT_Y - bg3.contentSize.height / 2);
        bg4.position = ccp(CENTER_POINT_X - bg4.contentSize.width / 2, CENTER_POINT_Y - bg4.contentSize.height / 2);
        
        [self addChild:bg1 z:0];
        [self addChild:bg2 z:0];
        [self addChild:bg3 z:0];
        [self addChild:bg4 z:0];
        
        char_location = [CCSprite spriteWithFile:@"gps_location.png"];
        char_location.position = ccp(240, 160);
        
        [self addChild:char_location];
        
        self.isTouchEnabled = TRUE;
        
        isCharMoving = FALSE;
        isPaused = FALSE;
        isCameraResetting = FALSE;
        
        [self createTowns];
        [self scheduleUpdate];
	}
	return self;
}

-(void) createTowns
{
    townsArray = [[NSMutableArray alloc] initWithCapacity:1];
    CCSpriteBatchNode *town_asset = [CCSpriteBatchNode batchNodeWithFile:@"town.png"];
    
    for (int ii = 0; ii< TOTAL_NUM_TOWNS; ii++) {
        Town *town = [[Town alloc ] initWithBatchNode:town_asset inLayer:self];
        [town setLocation:CGPointMake(arc4random() % 1024, arc4random() % 1024)];
        town.tag = ii;
        [townsArray addObject:town];
        [town release];
    }
    
}

-(void) update:(ccTime) dt
{
    if (isPaused == FALSE) {
        
        if (isCharMoving)
            [self moveCharToDestination:dt];
        
        if(isCameraResetting)
            [self resetCamera:dt];
        
    }
    
}

-(void) moveCharToDestination:(ccTime) dt
{
    
}

-(void) resetCamera:(ccTime) dt
{

    CGPoint increment = CGPointMake(CENTER_POINT_X - char_location.position.x, CENTER_POINT_Y - char_location.position.y);
    
    bg1.position = ccp(bg1.position.x + increment.x * dt * CAMERA_SPEED, bg1.position.y + increment.y * dt * CAMERA_SPEED);
    bg2.position = ccp(bg2.position.x + increment.x * dt * CAMERA_SPEED, bg2.position.y + increment.y * dt * CAMERA_SPEED);
    bg3.position = ccp(bg3.position.x + increment.x * dt * CAMERA_SPEED, bg3.position.y + increment.y * dt * CAMERA_SPEED);
    bg4.position = ccp(bg4.position.x + increment.x * dt * CAMERA_SPEED, bg4.position.y + increment.y * dt * CAMERA_SPEED);
    
    char_location.position = ccp(char_location.position.x + increment.x * dt * CAMERA_SPEED, char_location.position.y + increment.y * dt * CAMERA_SPEED);
    
    for (int ii = 0; ii< [townsArray count]; ii++) {
        CGPoint location = [[townsArray objectAtIndex:ii] getLocation];
        [[townsArray objectAtIndex:ii] setLocation:CGPointMake(location.x + increment.x * CAMERA_SPEED * dt, location.y + increment.y * CAMERA_SPEED * dt)];
    }
    
    if (increment.x > 0 && increment.x <= CAMERA_RESET_MIN){
        isCameraResetting = FALSE;
    }

    else if( increment.x< 0 && increment.x >= -CAMERA_RESET_MIN){
        isCameraResetting = FALSE;
    }
    
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isCameraResetting = FALSE;
    
    UITouch *touch = [touches anyObject];
    init_touch = [touch locationInView: [touch view]];
    
    switch (touch.tapCount) {
        case 1:
            [self checkTapActions];
            break;
        case 2:
            isCameraResetting = TRUE;
            break;
        default:
            break;
            
    }
    
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint new_touch = [touch locationInView:[touch view]];
    
    CGPoint adjusted_map_position = CGPointMake(new_touch.x - init_touch.x, new_touch.y - init_touch.y);
    
    bg1.position = ccp(bg1.position.x + (adjusted_map_position.x * MAP_DRAG), bg1.position.y - (adjusted_map_position.y* MAP_DRAG));
    bg2.position = ccp(bg2.position.x + (adjusted_map_position.x * MAP_DRAG), bg2.position.y - (adjusted_map_position.y* MAP_DRAG));
    bg3.position = ccp(bg3.position.x + (adjusted_map_position.x * MAP_DRAG), bg3.position.y - (adjusted_map_position.y* MAP_DRAG));
    bg4.position = ccp(bg4.position.x + (adjusted_map_position.x * MAP_DRAG), bg4.position.y - (adjusted_map_position.y* MAP_DRAG));
    
    char_location.position = ccp(char_location.position.x + (adjusted_map_position.x * MAP_DRAG), char_location.position.y - (adjusted_map_position.y  * MAP_DRAG));
    
    for (int ii = 0; ii< [townsArray count]; ii++) {
        CGPoint location = [[townsArray objectAtIndex:ii] getLocation];
        [[townsArray objectAtIndex:ii] setLocation:CGPointMake(location.x + (adjusted_map_position.x * MAP_DRAG), location.y - (adjusted_map_position.y* MAP_DRAG))];
    }
    
    init_touch = new_touch;
}

-(void) checkTapActions
{
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
