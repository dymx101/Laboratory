//
//  Viking.h
//  Chapter1
//
//  Created by Dong Yiming on 9/23/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "GameCharacter.h"
#import "SneakyButton.h"
#import "SneakyJoystick.h"

typedef enum {
    kLeftHook,
    kRightHook
} LastPunchType;

@interface Viking : GameCharacter {
    LastPunchType   _myLastPunch;
    BOOL            _isCarryingMallet;
    CCSpriteFrame   *_standingFrame;
    float           _millisecondsStayingIdle;
}
// Standing, Breathing, Walking
@property (nonatomic, retain) CCAnimation *breathingAnim;
@property (nonatomic, retain) CCAnimation *breathingMalletAnim;
@property (nonatomic, retain) CCAnimation *walkingAnim;
@property (nonatomic, retain) CCAnimation *walkingMalletAnim;
// Crouching, Standing Up, Jumping
@property (nonatomic, retain) CCAnimation *crouchingAnim;
@property (nonatomic, retain) CCAnimation *crouchingMalletAnim;
@property (nonatomic, retain) CCAnimation *standingUpAnim;
@property (nonatomic, retain) CCAnimation *standingUpMalletAnim;
@property (nonatomic, retain) CCAnimation *jumpingAnim;
@property (nonatomic, retain) CCAnimation *jumpingMalletAnim;
@property (nonatomic, retain) CCAnimation *afterJumpingAnim;
@property (nonatomic, retain) CCAnimation *afterJumpingMalletAnim;
// Punching
@property (nonatomic, retain) CCAnimation *rightPunchAnim;
@property (nonatomic, retain) CCAnimation *leftPunchAnim;
@property (nonatomic, retain) CCAnimation *malletPunchAnim;
// Taking Damage and Death
@property (nonatomic, retain) CCAnimation *phaserShockAnim;
@property (nonatomic, retain) CCAnimation *deathAnim;

@property (nonatomic,assign) SneakyJoystick *joystick;
@property (nonatomic,assign) SneakyButton *jumpButton;
@property (nonatomic,assign) SneakyButton *attackButton;
@end
