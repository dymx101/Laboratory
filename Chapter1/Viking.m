//
//  Viking.m
//  Chapter1
//
//  Created by Dong Yiming on 9/23/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "Viking.h"

@implementation Viking

- (void) dealloc {
    _joystick = nil;
    _jumpButton = nil;
    _attackButton = nil;
    
    [_breathingAnim release];
    [_breathingMalletAnim release];
    [_walkingAnim release];
    [_walkingMalletAnim release];
    [_crouchingAnim release];
    [_crouchingMalletAnim release];
    [_standingUpAnim release];
    [_standingUpMalletAnim release];
    [_jumpingAnim release];
    [_jumpingMalletAnim release];
    [_afterJumpingAnim release];
    [_afterJumpingMalletAnim release];
    [_rightPunchAnim release];
    [_leftPunchAnim release];
    [_malletPunchAnim release];
    [_phaserShockAnim release];
    [_deathAnim release];
    
    [super dealloc];
}

-(BOOL)isCarryingWeapon {
    return _isCarryingMallet;
}

-(int)getWeaponDamage {
    if (_isCarryingMallet) {
        return kVikingMalletDamage;
    }
    return kVikingFistDamage;
}

-(void)applyJoystick:(SneakyJoystick *)aJoyStick forTimeDelta:(float)deltaTime
{
    CGPoint scaledValocity = ccpMult(aJoyStick.velocity, 128.f);
    CGPoint oldPosition = self.position;
    CGPoint newPosition = ccp(oldPosition.x + scaledValocity.x * deltaTime, oldPosition.y);
    self.position = newPosition;
    
    self.flipX = (oldPosition.x > newPosition.x);
}

-(void)checkAndClampSpritePosition
{
    if (self.characterState != kStateJumping)
    {
        if (self.position.y > 110.f) {
            self.position = ccp(self.position.x, 110.f);
        }
    }
    
    [super checkAndClampSpritePosition];
}

#pragma mark -
-(void)changeState:(CharacterStates)newState
{
    [self stopAllActions];
    id action = nil;
    id movementAction = nil;
    CGPoint newPosition;
    [self setCharacterState:newState];
    
    switch (newState)
    {
        case kStateIdle:
        {
            self.displayFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:(_isCarryingMallet ? @"sv_mallet_1.png" : @"sv_anim_1.png")];
        }
            break;
            
        case kStateWalking:
        {
            CCAnimation *anim = _isCarryingMallet ? _walkingMalletAnim : _walkingAnim;
            anim.restoreOriginalFrame = NO;
            action = [CCAnimate actionWithAnimation:anim];
        }
            break;
            
        case kStateCrouching:
        {
            CCAnimation *anim = _isCarryingMallet ? _crouchingMalletAnim : _crouchingAnim;
            anim.restoreOriginalFrame = NO;
            action = [CCAnimate actionWithAnimation:anim];
        }
            break;
            
        case kStateStandingUp:
        {
            CCAnimation *anim = _isCarryingMallet ? _standingUpMalletAnim : _standingUpAnim;
            anim.restoreOriginalFrame = NO;
            action = [CCAnimate actionWithAnimation:anim];
        }
            break;
            
        case kStateBreathing:
        {
            CCAnimation *anim = _isCarryingMallet ? _breathingMalletAnim : _breathingAnim;
            anim.restoreOriginalFrame = YES;
            action = [CCAnimate actionWithAnimation:anim];
        }
            break;
            
        case kStateJumping:
        {
            newPosition = ccp(self.screenSize.width * .2f, .0f);
            if (self.flipX) {
                newPosition = ccp(newPosition.x * -1.f, 0.f);
            }
            movementAction = [CCJumpBy actionWithDuration:.5f position:newPosition height:160.f jumps:1];
            
            CCAnimation *crouchAnim = _isCarryingMallet ? _crouchingMalletAnim : _crouchingAnim;
            crouchAnim.restoreOriginalFrame = NO;
            CCAnimation *jumpAnim = _isCarryingMallet ? _jumpingMalletAnim : _jumpingAnim;
            jumpAnim.restoreOriginalFrame = YES;
            CCAnimation *afterJumpAnim = _isCarryingMallet ? _afterJumpingMalletAnim : _afterJumpingAnim;
            afterJumpAnim.restoreOriginalFrame = NO;
            
            action = [CCSequence actions:
                      [CCAnimate actionWithAnimation:crouchAnim]
                      , [CCSpawn actions:[CCAnimate actionWithAnimation:jumpAnim], movementAction, nil]
                      , [CCAnimate actionWithAnimation:afterJumpAnim]
                      , nil];
        }
            break;
            
        case kStateAttacking:
        {
            if (_isCarryingMallet)
            {
                _malletPunchAnim.restoreOriginalFrame = YES;
                action = [CCAnimate actionWithAnimation:_malletPunchAnim];
            }
            else
            {
                if (kLeftHook == _myLastPunch)
                {
                    _myLastPunch = kRightHook;
                    _rightPunchAnim.restoreOriginalFrame = NO;
                    action = [CCAnimate actionWithAnimation:_rightPunchAnim];
                }
                else
                {
                    _myLastPunch = kLeftHook;
                    _leftPunchAnim.restoreOriginalFrame = NO;
                    action = [CCAnimate actionWithAnimation:_leftPunchAnim];
                }
            }
        }
            break;
            
        case kStateTakingDamage:
        {
            self.characterHealth -= 10.f;
            _phaserShockAnim.restoreOriginalFrame = NO;
            action = [CCAnimate actionWithAnimation:_phaserShockAnim];
        }
            break;
            
        case kStateDead:
        {
            _deathAnim.restoreOriginalFrame = NO;
            action = [CCAnimate actionWithAnimation:_deathAnim];
        }
            break;
            
        default:
            break;
    }
    
    if (action)
    {
        [self runAction:action];
    }
}

#pragma mark -
-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects {
    if (self.characterState == kStateDead) {
        return; // Nothing to do if the Viking is dead
    }
    
    if ((self.characterState == kStateTakingDamage) && (self.numberOfRunningActions > 0)) {
        return; // currently playing the taking damage animation
    }
    
    // Check for collisions
    // Change this to keep the object count from querying it each time
    CGRect myBoundingBox = self.adjustedBoundingBox;
    
    for (GameCharacter *character in listOfGameObjects) {
        // This is Ole the Viking himself, no need to check collision with one's self
        if (character.tag == kVikingSpriteTagValue) {
            continue;
        }
        
        CGRect characterBox = character.adjustedBoundingBox;
        if (CGRectIntersectsRect(myBoundingBox, characterBox)) {
            // Remove the PhaserBullet from the scene
            if (character.gameObjectType == kEnemyTypePhaser) {
                [self changeState:kStateTakingDamage];
                [character changeState:kStateDead];
            } else if (character.gameObjectType == kPowerUpTypeMallet) {
                // Update the frame to indicate Viking is carrying the mallet
                _isCarryingMallet = YES;
                [self changeState:kStateIdle];
                [character changeState:kStateDead];
            } else if (character.gameObjectType == kPowerUpTypeHealth) {
                self.characterHealth = 100.f;
                [character changeState:kStateDead];
            }
        }
    }
    
    [self checkAndClampSpritePosition];
    
    if (self.characterState == kStateIdle || self.characterState == kStateWalking
        || self.characterState == kStateCrouching || self.characterState == kStateStandingUp
        || self.characterState == kStateBreathing) {
        if (_jumpButton.active) {
            [self changeState:kStateJumping];
        } else if (_attackButton.active) {
            [self changeState:kStateAttacking];
        } else if (_joystick.velocity.x == 0.f && _joystick.velocity.y == 0.f) {
            if (self.characterState == kStateCrouching) {
                [self changeState:kStateStandingUp];
            }
        } else if (_joystick.velocity.y < -.45f) {
            if (self.characterState != kStateCrouching) {
                [self changeState:kStateCrouching];
            }
        } else if (_joystick.velocity.x != .0f) {
            if (self.characterState != kStateWalking) {
                [self changeState:kStateWalking];
            }
            [self applyJoystick:_joystick forTimeDelta:deltaTime];
        }
    }
    
    if (self.numberOfRunningActions == 0)
    {
        // Not playing an animation
        if (self.characterHealth <= 0.f)
        {
            [self changeState:kStateDead];
        }
        else if (self.characterState == kStateIdle)
        {
            _millisecondsStayingIdle += deltaTime;
            if (_millisecondsStayingIdle > kVikingIdleTimer)
            {
                [self changeState:kStateBreathing];
            }
        }
        else if (self.characterState != kStateCrouching && self.characterState != kStateIdle)
        {
            _millisecondsStayingIdle = 0.f;
            [self changeState:kStateIdle];
        }
    }
}

#pragma mark -
-(CGRect)adjustedBoundingBox
{
    CGRect vikingBoundingBox = self.boundingBox;
    float xOffset = vikingBoundingBox.size.width * (self.flipX ? .4217f : .1566f);
    float xCropAmount = vikingBoundingBox.size.width * .5482f;
    float yCropAmount = vikingBoundingBox.size.height * .095f;
    
    vikingBoundingBox = CGRectMake(vikingBoundingBox.origin.x + xOffset
                                   , vikingBoundingBox.origin.y
                                   , vikingBoundingBox.size.width - xCropAmount
                                   , vikingBoundingBox.size.height - yCropAmount);
    
    if (self.characterState == kStateCrouching)
    {
        // shrink the bounding box to 56% of height
        // 88 pixels on top on iPad
        vikingBoundingBox = CGRectMake(vikingBoundingBox.origin.x
                                       , vikingBoundingBox.origin.y
                                       , vikingBoundingBox.size.width
                                       , vikingBoundingBox.size.height * .65f);
    }
    
    return vikingBoundingBox;
}

#pragma mark -
-(void)initAnimations {
    self.breathingAnim = [self loadPlistForAnimationWithName:@"breathingAnim" andClassName:NSStringFromClass([self class])];
    self.breathingMalletAnim = [self loadPlistForAnimationWithName:@"breathingMalletAnim" andClassName:NSStringFromClass([self class])];
    
    self.walkingAnim = [self loadPlistForAnimationWithName:@"walkingAnim" andClassName:NSStringFromClass([self class])];
    self.walkingMalletAnim = [self loadPlistForAnimationWithName:@"walkingMalletAnim" andClassName:NSStringFromClass([self class])];
    
    self.crouchingAnim = [self loadPlistForAnimationWithName:@"crouchingAnim" andClassName:NSStringFromClass([self class])];
    self.crouchingMalletAnim = [self loadPlistForAnimationWithName:@"crouchingMalletAnim" andClassName:NSStringFromClass([self class])];
    
    self.standingUpAnim = [self loadPlistForAnimationWithName:@"standingUpAnim" andClassName:NSStringFromClass([self class])];
    self.standingUpMalletAnim = [self loadPlistForAnimationWithName:@"standingUpMalletAnim" andClassName:NSStringFromClass([self class])];
    
    self.jumpingAnim = [self loadPlistForAnimationWithName:@"jumpingAnim" andClassName:NSStringFromClass([self class])];
    self.jumpingMalletAnim = [self loadPlistForAnimationWithName:@"jumpingMalletAnim" andClassName:NSStringFromClass([self class])];
    
    self.afterJumpingAnim = [self loadPlistForAnimationWithName:@"afterJumpingAnim" andClassName:NSStringFromClass([self class])];
    self.afterJumpingMalletAnim = [self loadPlistForAnimationWithName:@"afterJumpingMalletAnim" andClassName:NSStringFromClass([self class])];
    
    // Punches
    self.rightPunchAnim = [self loadPlistForAnimationWithName:@"rightPunchAnim" andClassName:NSStringFromClass([self class])];
    self.leftPunchAnim = [self loadPlistForAnimationWithName:@"leftPunchAnim" andClassName:NSStringFromClass([self class])];
    self.malletPunchAnim = [self loadPlistForAnimationWithName:@"malletPunchAnim" andClassName:NSStringFromClass([self class])];
    
    // Taking damage and death
    self.phaserShockAnim = [self loadPlistForAnimationWithName:@"phaserShockAnim" andClassName:NSStringFromClass([self class])];
    self.deathAnim = [self loadPlistForAnimationWithName:@"vikingDeathAnim" andClassName:NSStringFromClass([self class])];
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
    _joystick = nil;
    _jumpButton = nil;
    _attackButton = nil;
    
    self.gameObjectType = kVikingType;
    _myLastPunch = kRightHook;
    _millisecondsStayingIdle = 0.f;
    _isCarryingMallet = NO;
    
    [self initAnimations];
}

- (id) initWithSpriteFrame:(CCSpriteFrame*)spriteFrame
{
    self = [super initWithSpriteFrame:spriteFrame];
    if (self) {
        [self _doInit];
    }
    
    return self;
}

@end
