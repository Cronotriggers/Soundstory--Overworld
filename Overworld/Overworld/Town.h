//
//  Town.h
//  Overworld
//
//  Created by Matthew LoPresti on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface Town : NSObject
{
    CCSprite *image;
    int tag;
}

@property int tag;

-(id) initWithBatchNode:(CCSpriteBatchNode *) sprite inLayer:(CCLayer *) layer;
-(CGPoint) getLocation;
-(void) setLocation:(CGPoint) location;

@end
