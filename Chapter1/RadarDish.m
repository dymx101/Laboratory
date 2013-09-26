//
//  RadarDish.m
//  Chapter1
//
//  Created by Dong Yiming on 9/23/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "RadarDish.h"

@implementation RadarDish

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
    CCLOG(@"### RadarDish initialized");
    [self initAnimations];
    self.characterHealth = 100.f;
    self.gameObjectType = kEnemyTypeRadarDish;
    [self changeState:kStateSpawning];
}

-(id)initWithSpriteFrameName:(NSString*)spriteFrameName
{
    self = [super initWithSpriteFrameName:spriteFrameName];
    if (self) {
        [self _doInit];
    }
    return self;
}

-(void)initAnimations {
    self.tiltingAnim = [self loadPlistForAnimationWithName:@"tiltingAnim" andClassName:NSStringFromClass([self class])];
    self.transmittingAnim = [self loadPlistForAnimationWithName:@"transmittingAnim" andClassName:NSStringFromClass([self class])];
    self.takingAHitAnim = [self loadPlistForAnimationWithName:@"takingAHitAnim" andClassName:NSStringFromClass([self class])];
    //_takingAHitAnim.delayPerUnit = 1.f;
    self.blowingUpAnim = [self loadPlistForAnimationWithName:@"blowingUpAnim" andClassName:NSStringFromClass([self class])];
}

- (void) dealloc{
    [_tiltingAnim release];
    [_transmittingAnim release];
    [_takingAHitAnim release];
    [_blowingUpAnim release];
    [super dealloc];
}

-(void)changeState:(CharacterStates)newState
{
    [self stopAllActions];
    id action = nil;
    [self setCharacterState:newState];
    
    switch (newState)
    {
        case kStateSpawning:
            CCLOG(@"RadarDish->Starting the Spawning Animation");
            _tiltingAnim.restoreOriginalFrame = NO;
            action = [CCAnimate actionWithAnimation:_tiltingAnim];
            break;
            
        case kStateIdle:
            CCLOG(@"RadarDish->Changing State to Idle");
            _transmittingAnim.restoreOriginalFrame = NO;
            action = [CCAnimate actionWithAnimation:_transmittingAnim];
            break;
            
        case kStateTakingDamage:
            CCLOG(@"RadarDish->Change state to TakingDamage");
            self.characterHealth -= vikingCharacter.getWeaponDamage;
            if (self.characterHealth <= 0.f)
            {
                [self changeState:kStateDead];
            }
            else
            {
                _takingAHitAnim.restoreOriginalFrame = NO;
                action = [CCAnimate actionWithAnimation:_takingAHitAnim];
            }
            break;
            
        case kStateDead:
            CCLOG(@"RadarDish->Changing State to dead");
            _blowingUpAnim.restoreOriginalFrame = NO;
            action = [CCAnimate actionWithAnimation:_blowingUpAnim];
            break;
            
        default:
            break;
    }
    
    if (action)
    {
        [self runAction:action];
    }
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects
{
    if (self.characterState == kStateDead)
    {
        return;
    }
    
    vikingCharacter = (GameCharacter *)[self.parent getChildByTag:kVikingSpriteTagValue];
    CGRect vikingBoundingBox = [vikingCharacter adjustedBoundingBox];
    CharacterStates vikingState = vikingCharacter.characterState;
    
    // Calculate if the viking is attacking and nearby
    if ((vikingState == kStateAttacking) && (CGRectIntersectsRect(self.adjustedBoundingBox, vikingBoundingBox))) {
        if (self.characterState != kStateTakingDamage)
        {
            // If RadarDish is NOT already taking Damage
            [self changeState:kStateTakingDamage];
            return;
        }
    }
    
    if (self.numberOfRunningActions == 0 && (self.characterState != kStateDead)) {
        CCLOG(@"Going to Idle");
        [self changeState:kStateIdle];
        return;
    }
}

@end
