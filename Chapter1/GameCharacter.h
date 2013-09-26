//
//  GameCharacter.h
//  Chapter1
//
//  Created by Dong Yiming on 9/21/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "GameObject.h"

@interface GameCharacter : GameObject

-(void)checkAndClampSpritePosition;
-(int)getWeaponDamage;

@property (readwrite) int characterHealth;
@property (readwrite) CharacterStates characterState;

@end
