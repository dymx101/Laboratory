//
//  PhaserBullet.m
//  Chapter1
//
//  Created by Dong Yiming on 9/25/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "PhaserBullet.h"

@implementation PhaserBullet

- (void)dealloc
{
    [_travelingAnim release];
    [_firingAnim release];
    
    [super dealloc];
}

-(void)changeState:(CharacterStates)newState
{
    [self stopAllActions];
    id action = nil;
    self.characterState = newState;
    
    switch (newState) {
        case kStateSpawning:
        {
            CCLOG(@"Phaser->Change state to spawing");
            action = [CCAnimate actionWithAnimation:_firingAnim];
        }
            break;
            
        case kStateTraveling:
        {
            CCLOG(@"Phaser->Change state to traveling");
            CGPoint endLocation;
            if (_myDirection == kDirectionLeft)
            {
                endLocation = ccp(-10.f, self.position.y);
            }
            else
            {
                endLocation = ccp(self.screenSize.width + 24.f, self.position.y);
            }
            
            [self runAction:[CCMoveTo actionWithDuration:2.f position:endLocation]];
            
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:_travelingAnim]];
        }
            break;
            
        case kStateDead:
        {
            CCLOG(@"Phaser->Change state to dead");
            self.visible = NO;
            [self removeFromParentAndCleanup:YES];
        }
            
        default:
            break;
    }
    
    if (action)
    {
        [self runAction:action];
    }
}

-(BOOL)isOutSideOfScreen
{
    CGPoint currentSpritePosition = self.position;
    if (currentSpritePosition.x < 0.f || currentSpritePosition.x > self.screenSize.width)
    {
        [self changeState:kStateDead];
        return YES;
    }
    
    return NO;
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects
{
    if ([self isOutSideOfScreen]) {
        return;
    }
    
    if (self.numberOfRunningActions == 0)
    {
        if (self.characterState == kStateSpawning)
        {
            [self changeState:kStateTraveling];
            return;
        }
        else
        {
            [self changeState:kStateDead];
            return;
        }
    }
}

-(void)initAnimations
{
    self.firingAnim = [self loadPlistForAnimationWithName:@"firingAnim" andClassName:NSStringFromClass([self class])];
    self.travelingAnim = [self loadPlistForAnimationWithName:@"travelingAnim" andClassName:NSStringFromClass([self class])];
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
    [self initAnimations];
    self.gameObjectType = kEnemyTypePhaser;
}

@end
