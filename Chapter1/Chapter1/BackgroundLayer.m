//
//  BackgroundLayer.m
//  Chapter1
//
//  Created by Dong Yiming on 9/19/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "BackgroundLayer.h"

@implementation BackgroundLayer

- (id)init
{
    self = [super init];
    if (self) {
        
        CCSprite *backgroundImage;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            backgroundImage = [CCSprite spriteWithFile:@"background.png"];
        }
        else
        {
            backgroundImage = [CCSprite spriteWithFile:@"backgroundiPhone.png"];
        }
        
        CGSize screensize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:ccp(screensize.width / 2, screensize.height / 2)];
        
        [self addChild:backgroundImage z:0 tag:0];
        
//        id waveAction = [CCWaves actionWithDuration:20 size:CGSizeMake(20, 15) waves:5 amplitude:20 horizontal:NO vertical:YES];
//        [backgroundImage runAction:[CCRepeatForever actionWithAction:waveAction]];
    }
    return self;
}


@end
