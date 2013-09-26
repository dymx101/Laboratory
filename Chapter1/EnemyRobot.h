//
//  EnemyRobot.h
//  Chapter1
//
//  Created by Dong Yiming on 9/25/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "GameCharacter.h"

@interface EnemyRobot : GameCharacter
{
    BOOL            _isVikingWithinBoundingBox;
    BOOL            _isVikingWithinSight;
    GameCharacter   *_vikingCharacter;
}

@property (nonatomic,assign) id <GameplayLayerDelegate> delegate;
@property (nonatomic, retain) CCAnimation *robotWalkingAnim;
@property (nonatomic, retain) CCAnimation *raisePhaserAnim;
@property (nonatomic, retain) CCAnimation *shootPhaserAnim;
@property (nonatomic, retain) CCAnimation *lowerPhaserAnim;
@property (nonatomic, retain) CCAnimation *torsoHitAnim;
@property (nonatomic, retain) CCAnimation *headHitAnim;
@property (nonatomic, retain) CCAnimation *robotDeathAnim;

-(void)initAnimations;
@end
