//
//  GameObject.h
//  Chapter1
//
//  Created by Dong Yiming on 9/21/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "CCSprite.h"
#import "Constants.h"
#import "CommonProtocols.h"

@interface GameObject : CCSprite

@property (readwrite) BOOL isActive;
@property (readwrite) BOOL reactsToScreenBoundaries;
@property (readwrite) CGSize screenSize;
@property (readwrite) GameObjectType gameObjectType;

-(void)changeState:(CharacterStates)newState;

-(void)updateStateWithDeltaTime:(ccTime)deltaTime
           andListOfGameObjects:(CCArray*)listOfGameObjects;

-(CGRect)adjustedBoundingBox;

-(CCAnimation*)loadPlistForAnimationWithName:(NSString*)animationName
                                andClassName:(NSString*)className;

@end
