//
//  GameScene.m
//  Chapter1
//
//  Created by Dong Yiming on 9/19/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

- (id)init
{
    self = [super init];
    if (self) {
        BackgroundLayer *backgroundLayer = [BackgroundLayer node];
        [self addChild:backgroundLayer z:0];
        
        GameplayLayer *gameplayLayer = [GameplayLayer node];
        [self addChild:gameplayLayer z:5];
    }
    return self;
}

@end
