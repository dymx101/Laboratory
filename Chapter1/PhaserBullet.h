//
//  PhaserBullet.h
//  Chapter1
//
//  Created by Dong Yiming on 9/25/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "GameCharacter.h"

@interface PhaserBullet : GameCharacter

@property PhaserDirection myDirection;
@property (nonatomic,retain) CCAnimation *firingAnim;
@property (nonatomic,retain) CCAnimation *travelingAnim;

@end
