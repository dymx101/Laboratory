//
//  GameplayLayer.h
//  Chapter1
//
//  Created by Dong Yiming on 9/19/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "CCLayer.h"
#import "SneakyJoystick.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"
#import "Constants.h"
#import "CommonProtocols.h"
#import "RadarDish.h"
#import "Viking.h"

@interface GameplayLayer : CCLayer <GameplayLayerDelegate>
{
    //CCSprite            *vikingSprite;
    SneakyJoystick      *leftJoystick;
    SneakyButton        *jumpButton;
    SneakyButton        *attackButton;
    CCSpriteBatchNode   *sceneSpriteBatchNode;
}
@end
