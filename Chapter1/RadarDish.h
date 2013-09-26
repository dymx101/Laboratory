//
//  RadarDish.h
//  Chapter1
//
//  Created by Dong Yiming on 9/23/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "GameCharacter.h"

@interface RadarDish : GameCharacter
{
    GameCharacter   *vikingCharacter;
}
@property (nonatomic, retain) CCAnimation *tiltingAnim;
@property (nonatomic, retain) CCAnimation *transmittingAnim;
@property (nonatomic, retain) CCAnimation *takingAHitAnim;
@property (nonatomic, retain) CCAnimation *blowingUpAnim;
@end
