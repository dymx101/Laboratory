//
//  Health.m
//  Chapter1
//
//  Created by Dong Yiming on 9/25/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "Health.h"

@implementation Health

- (void)dealloc
{
    [_healthAnim release];
    
    [super dealloc];
}

-(void)changeState:(CharacterStates)newState
{
    if (newState == kStateSpawning)
    {
        id action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:_healthAnim]];
        [self runAction:action];
    }
    else
    {
        self.visible = NO;  //Picked up
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

-(void)initAnimations {
    self.healthAnim = [self loadPlistForAnimationWithName:@"healthAnim" andClassName:NSStringFromClass([self class])];
}

- (id)init
{
    self = [super init];
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
    self.gameObjectType = kPowerUpTypeHealth;
}

-(id)initWithSpriteFrameName:(NSString *)spriteFrameName
{
    self = [super initWithSpriteFrameName:spriteFrameName];
    if (self) {
        [self _doInit];
    }
    return self;
}

@end
