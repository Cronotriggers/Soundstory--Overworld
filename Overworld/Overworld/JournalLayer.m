//
//  JournalLayer.m
//  Overworld
//
//  Created by Matthew LoPresti on 7/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "JournalLayer.h"


@implementation JournalLayer

-(id) init
{
    
    self = [super init];
    
    if (self != nil) {
        
        bg = [CCSprite spriteWithFile:@"journal_bg.png"];
        bg.position = ccp(240, 160);
        [self addChild:bg];
    }
    
    return self;
}

@end
