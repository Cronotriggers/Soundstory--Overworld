//
//  Town.m
//  Overworld
//
//  Created by Matthew LoPresti on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Town.h"

@implementation Town

@synthesize tag;

-(id) initWithBatchNode:(CCSpriteBatchNode *) sprite inLayer:(CCLayer *) layer
{
    self = [super init];
    
    if (self != nil) {
        
        image = [CCSprite spriteWithBatchNode:sprite rect:CGRectMake(0, 0, 16, 16)];
        [layer addChild:image];
    }
    
    return self;
}

//returns town's location
-(CGPoint) getLocation
{
    return image.position;
}

-(void) setLocation:(CGPoint) location
{
    image.position = ccp(location.x, location.y);
}

@end
