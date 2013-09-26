//
//  EnemyRobot.m
//  Chapter1
//
//  Created by Dong Yiming on 9/25/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "EnemyRobot.h"

@implementation EnemyRobot

- (void)dealloc
{
    _delegate = nil;
    [_robotWalkingAnim release];
    [_raisePhaserAnim release];
    [_shootPhaserAnim release];
    [_lowerPhaserAnim release];
    [_torsoHitAnim release];
    [_headHitAnim release];
    [_robotDeathAnim release];
    
    [super dealloc];
}

-(void)shootPhaser {
    CGPoint phaserFiringPosition;
    PhaserDirection phaserDir;
    CGRect boundingBox = self.boundingBox;
    CGPoint position = self.position;
    
    float xPosition = position.x + boundingBox.size.width * .542f;
    float yPosition = position.y + boundingBox.size.height * .25f;
    
    if (self.flipX)
    {
        CCLOG(@"Facing right, Firing to the right");
        phaserDir = kDirectionRight;
    }
    else
    {
        phaserDir = kDirectionLeft;
        xPosition = position.x - boundingBox.size.width * .542f; // Reverse direction
    }
    
    phaserFiringPosition = ccp(xPosition, yPosition);
    [_delegate createPhaserWithDirection:phaserDir andPosition:phaserFiringPosition];
}

-(CGRect)eyesightBoundingBox
{
    // Eyesight is 3 robot widths in the direction the robot is facing
    CGRect robotSightBoundingBox;
    CGRect robotBoundingBox = self.adjustedBoundingBox;
    if (self.flipX)
    {
        robotSightBoundingBox = CGRectMake(robotBoundingBox.origin.x, robotBoundingBox.origin.y, robotBoundingBox.size.width * 3.f, robotBoundingBox.size.height);
    }
    else
    {
        robotSightBoundingBox = CGRectMake(robotBoundingBox.origin.x - robotBoundingBox.size.width * 2.f, robotBoundingBox.origin.y, robotBoundingBox.size.width * 3.f, robotBoundingBox.size.height);
    }
    
    return robotSightBoundingBox;
}

-(void)changeState:(CharacterStates)newState
{
    if (self.characterState == kStateDead)
    {
        return; // No need to change state further once I am dead
    }
    
    [self stopAllActions];
    id action = nil;
    self.characterState = newState;
    
    switch (newState) {
        case kStateSpawning:
        {
            // fade out the sprite if it was visible before
            [self runAction:[CCFadeOut actionWithDuration:0.f]];
            self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"teleport.png"];
            
            action = [CCSpawn actions:[CCRotateBy actionWithDuration:1.5f angle:360]
                      , [CCFadeIn actionWithDuration:1.5f]
                      , nil];
        }
            break;
            
        case kStateIdle:
        {
            CCLOG(@"EnemyRobot->Changing State to Idle");
            self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"an1_anim1.png"];
        }
            break;
            
        case kStateWalking:
        {
            CCLOG(@"EnemyRobot->Change state to walking");
            if (_isVikingWithinBoundingBox) {
                break;  // AI will change to attacking on next frame
            }
            
            float xPositionOffset = 150.f;
            if (_isVikingWithinSight)
            {
                if (_vikingCharacter.position.x < self.position.x)
                {
                    xPositionOffset = xPositionOffset * -1;
                }
            }
            else
            {
                if (CCRANDOM_0_1() > .5f)
                {
                    xPositionOffset = xPositionOffset * -1;
                }
                
                self.flipX = (xPositionOffset > 0.f);
            }
            
            action = [CCSpawn actions:
                      [CCAnimate actionWithAnimation:_robotWalkingAnim]
                      , [CCMoveTo actionWithDuration:2.4f position:ccp(self.position.x + xPositionOffset, self.position.y)]
                      , nil];
        }
            break;
            
        case kStateAttacking:
        {
            CCLOG(@"EnemyRobot->Changing state to attacking");
            action = [CCSequence actions:
                      [CCAnimate actionWithAnimation:_raisePhaserAnim]
                      , [CCDelayTime actionWithDuration:1.f]
                      , [CCAnimate actionWithAnimation:_shootPhaserAnim]
                      , [CCCallFunc actionWithTarget:self selector:@selector(shootPhaser)]
                      , [CCAnimate actionWithAnimation:_lowerPhaserAnim]
                      , [CCDelayTime actionWithDuration:2.f]
                      , nil];
        }
            break;
            
        case kStateTakingDamage:
        {
            CCLOG(@"EnemyRobot->Changing state to takingDamage");
            if (_vikingCharacter.getWeaponDamage > kVikingFistDamage)
            {
                // if the viking has the mallet, then
                _headHitAnim.restoreOriginalFrame = YES;
                action = [CCAnimate actionWithAnimation:_headHitAnim];
            }
            else
            {
                // viking does not have weapon, body blow
                _torsoHitAnim.restoreOriginalFrame = YES;
                action = [CCAnimate actionWithAnimation:_torsoHitAnim];
            }
        }
            break;
            
        case kStateDead:
        {
            CCLOG(@"EnemyRobot-> Going to dead state");
            action = [CCSequence actions:
                      [CCAnimate actionWithAnimation:_robotDeathAnim]
                      , [CCDelayTime actionWithDuration:2.f]
                      , [CCFadeOut actionWithDuration:2.f]
                      , nil];
        }
            break;
            
        default:
            CCLOG(@"Enemy Robot -> Unknown charState %d", self.characterState);
            break;
    }
    
    if (action)
    {
        [self runAction:action];
    }
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects
{
    [self checkAndClampSpritePosition];
    
    if (self.characterState != kStateDead && self.characterHealth <= 0)
    {
        [self changeState:kStateDead];
        return;
    }
    
    _vikingCharacter = (GameCharacter *)[self.parent getChildByTag:kVikingSpriteTagValue];
    
    CGRect vikingBoundingBox = _vikingCharacter.adjustedBoundingBox;
    CGRect robotBoundingBox = self.adjustedBoundingBox;
    CGRect robotSightBoundingBox = [self eyesightBoundingBox];
    
    _isVikingWithinBoundingBox = CGRectIntersectsRect(vikingBoundingBox, robotBoundingBox);
    _isVikingWithinSight = CGRectIntersectsRect(vikingBoundingBox, robotSightBoundingBox);
    
    if (_isVikingWithinBoundingBox && _vikingCharacter.characterState == kStateAttacking)
    {
        if (self.characterState != kStateTakingDamage && self.characterState != kStateDead)
        {
            self.characterHealth -= _vikingCharacter.getWeaponDamage;
            if (self.characterHealth > 0)
            {
                [self changeState:kStateTakingDamage];
            }
            else
            {
                [self changeState:kStateDead];
            }
            
            return; // Nothing to update further, stop and show damage
        }
    }
    
    if (self.numberOfRunningActions == 0)
    {
        if (self.characterState == kStateDead)
        {
            self.visible = NO;
            [self removeFromParentAndCleanup:YES];
        }
        else if (_vikingCharacter.characterState == kStateDead)
        {
            // viking is dead, walk around the scene
            [self changeState:kStateWalking];
        }
        else if (_isVikingWithinSight)
        {
            [self changeState:kStateAttacking];
        }
        else
        {
            // viking alive and out of sight, resume walking
            [self changeState:kStateWalking];
        }
    }
}

-(CGRect)adjustedBoundingBox
{
    CGRect enemyRobotBoundingBox = self.boundingBox;
    float xOffsetAmount = enemyRobotBoundingBox.size.width * .18f;
    float yCropAmount = enemyRobotBoundingBox.size.height *.05f;
    
    enemyRobotBoundingBox.origin.x += xOffsetAmount;
    enemyRobotBoundingBox.size.width -= xOffsetAmount;
    enemyRobotBoundingBox.size.height -= yCropAmount;
    
    return enemyRobotBoundingBox;
}

#pragma mark -
#pragma mark initAnimations
-(void)initAnimations
{
    self.robotWalkingAnim = [self loadPlistForAnimationWithName:@"robotWalkingAnim" andClassName:NSStringFromClass([self class])];
    self.raisePhaserAnim = [self loadPlistForAnimationWithName:@"raisePhaserAnim" andClassName:NSStringFromClass([self class])];
    self.shootPhaserAnim = [self loadPlistForAnimationWithName:@"shootPhaserAnim" andClassName:NSStringFromClass([self class])];
    self.lowerPhaserAnim = [self loadPlistForAnimationWithName:@"lowerPhaserAnim" andClassName:NSStringFromClass([self class])];
    self.torsoHitAnim = [self loadPlistForAnimationWithName:@"torsoHitAnim" andClassName:NSStringFromClass([self class])];
    self.headHitAnim = [self loadPlistForAnimationWithName:@"headHitAnim" andClassName:NSStringFromClass([self class])];
    self.robotDeathAnim = [self loadPlistForAnimationWithName:@"robotDeathAnim" andClassName:NSStringFromClass([self class])];
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
    _isVikingWithinBoundingBox = NO;
    _isVikingWithinSight = NO;
    self.gameObjectType = kEnemyTypeAlienRobot;
    [self initAnimations];
    srandom(time(NULL));
}

@end
