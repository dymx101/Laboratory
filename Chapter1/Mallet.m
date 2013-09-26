//
//  Mallet.m
//  Chapter1
//
//  Created by Dong Yiming on 9/24/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "Mallet.h"

@implementation Mallet

- (void)dealloc
{
    [_malletAnim release];
    
    [super dealloc];
}

-(void)changeState:(CharacterStates)newState
{
    if (newState == kStateSpawning) {
        id action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:_malletAnim]];
        [self runAction:action];
    } else {
        self.visible = NO;  // picked up
        [self removeFromParentAndCleanup:YES];
    }
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects
{
    float groundHeight = self.screenSize.height * .065f;
    if (self.position.y > groundHeight)
    {
        self.position = ccp(self.position.x, self.position.y - 5.f);
    }
}

-(void)initAnimations
{
    self.malletAnim = [self loadPlistForAnimationWithName:@"malletAnim" andClassName:NSStringFromClass([self class])];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self _doInit];
    }
    return self;
}

-(id)initWithSpriteFrameName:(NSString *)spriteFrameName
{
    self = [super initWithSpriteFrameName:spriteFrameName];
    if (self) {
        [self _doInit];
    }
    return self;
}

-(void)_doInit
{
    self.screenSize = [CCDirector sharedDirector].winSize;
    [self initAnimations];
    [self changeState:kStateSpawning];
    self.gameObjectType = kPowerUpTypeMallet;
}

@end
