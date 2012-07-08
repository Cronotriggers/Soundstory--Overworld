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

-(id) initWithLocation:(CGPoint) location inLayer:(CCLayer *) layer
{
    self = [super init];
    
    if (self != nil) {
        
        image = [CCSprite spriteWithFile:@"town.png"];
        image.position = ccp(location.x, location.y);
        [layer addChild:image];
    }
    
    return self;
}

//returns town's location
-(CGPoint) location
{
    return image.position;
}

@end
