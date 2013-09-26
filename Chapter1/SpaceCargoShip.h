//
//  SpaceCargoShip.h
//  Chapter1
//
//  Created by Dong Yiming on 9/25/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "GameObject.h"

@interface SpaceCargoShip : GameObject
{
    BOOL    _hasDroppedMallet;
}

@property (nonatomic,assign) id <GameplayLayerDelegate> delegate;

@end
