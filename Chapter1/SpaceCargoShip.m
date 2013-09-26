//
//  SpaceCargoShip.m
//  Chapter1
//
//  Created by Dong Yiming on 9/25/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "SpaceCargoShip.h"

@implementation SpaceCargoShip

-(void)dropCargo
{
    CGPoint cargoDropPosition = ccp(self.screenSize.width / 2, self.screenSize.height);
    if (!_hasDroppedMallet)
    {
        CCLOG(@"SpaceCargoShip --> Mallet Powerup was created!");
        _hasDroppedMallet = YES;
        [_delegate createObjectOfType:kPowerUpTypeMallet withHealth:0.f atLocation:cargoDropPosition withZValue:50];
    }
    else
    {
        CCLOG(@"SpaceCargoShip --> Health Powerup was created!");
        [_delegate createObjectOfType:kPowerUpTypeHealth withHealth:0.f atLocation:cargoDropPosition withZValue:50];
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        CCLOG(@"SpaceCargoShip init");
        
        [self _doInit];
    }
    return self;
}

-(void)_doInit
{
    _hasDroppedMallet = NO;
    float shipHeight = self.screenSize.height * 0.71f;
    CGPoint position1 = ccp(self.screenSize.width * -.48f, shipHeight);
    CGPoint position2 = ccp(self.screenSize.width * 2.0f, shipHeight);
    CGPoint position3 = ccp(position2.x * -1.f, shipHeight);
    CGPoint offScreen = ccp(self.screenSize.width * -1.f, self.screenSize.height * -1.f);
    
    id action = [CCRepeatForever actionWithAction:
                 [CCSequence actions:
                  [CCDelayTime actionWithDuration:2.f]
                  , [CCMoveTo actionWithDuration:.01f position:position1]
                  , [CCScaleTo actionWithDuration:.01f scale:.5f]
                  , [CCFlipX actionWithFlipX:YES]
                  
                  , [CCMoveTo actionWithDuration:8.5f position:position2]
                  , [CCScaleTo actionWithDuration:.1f scale:1.f]
                  , [CCFlipX actionWithFlipX:NO]
                  
                  , [CCMoveTo actionWithDuration:7.5f position:position3]
                  , [CCScaleTo actionWithDuration:.1f scale:2.f]
                  , [CCFlipX actionWithFlipX:YES]
                  
                  , [CCMoveTo actionWithDuration:6.5f position:position2]
                  , [CCFlipX actionWithFlipX:NO]
                  , [CCScaleTo actionWithDuration:.1f scale:2.f]
                  
                  , [CCMoveTo actionWithDuration:5.5f position:position3]
                  , [CCFlipX actionWithFlipX:YES]
                  , [CCScaleTo actionWithDuration:.1f scale:4.f]
                  
                  , [CCMoveTo actionWithDuration:4.5f position:position2]
                  , [CCCallFunc actionWithTarget:self selector:@selector(dropCargo)]
                  , [CCMoveTo actionWithDuration:0.f position:offScreen]
                  , nil]
                 ];
    
    [self runAction:action];
}

-(id)initWithSpriteFrameName:(NSString *)spriteFrameName
{
    self = [super initWithSpriteFrameName:spriteFrameName];
    if (self) {
        [self _doInit];
    }
    return self;
}

@end
