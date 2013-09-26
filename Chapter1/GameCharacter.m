//
//  GameCharacter.m
//  Chapter1
//
//  Created by Dong Yiming on 9/21/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "GameCharacter.h"

@implementation GameCharacter

-(int)getWeaponDamage
{
    CCLOG(@"getWeaponDamage should be overridden");
    return 0;
}

-(void)checkAndClampSpritePosition
{
    CGPoint currentSpritePosition = [self position];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // Clamp for the iPad
        if (currentSpritePosition.x < 30.f) {
            [self setPosition:ccp(30.f, currentSpritePosition.y)];
        } else if (currentSpritePosition.x > 1000.f){
            [self setPosition:ccp(1000.f, currentSpritePosition.y)];
        }
    } else {
        // Clamp for iPhone, iPhone 4, or iPod Touch
        if (currentSpritePosition.x < 24.f) {
            self.position = ccp(24.f, currentSpritePosition.y);
        } else if (currentSpritePosition.x > 456.f) {
            self.position = ccp(456.f, currentSpritePosition.y);
        }
    }
}

@end
