//
//  GameObject.m
//  Chapter1
//
//  Created by Dong Yiming on 9/21/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject

-(id) init {
    if((self=[super init])){
        CCLOG(@"GameObject init");
        [self _doBaseInit];
    }
    return self;
}

-(void)_doBaseInit
{
    _screenSize = [CCDirector sharedDirector].winSize;
    _isActive = YES;
    _gameObjectType = kObjectTypeNone;
}

-(id)initWithSpriteFrame:(CCSpriteFrame *)spriteFrame
{
    self = [super initWithSpriteFrame:spriteFrame];
    if (self) {
        [self _doBaseInit];
    }
    return self;
}

-(id)initWithSpriteFrameName:(NSString *)spriteFrameName
{
    self = [super initWithSpriteFrameName:spriteFrameName];
    if (self) {
        [self _doBaseInit];
    }
    
    return self;
}

-(void)changeState:(CharacterStates)newState {
    CCLOG(@"GameObject->changeState method should be overridden");
}
-(void)updateStateWithDeltaTime:(ccTime)deltaTime
           andListOfGameObjects:(CCArray*)listOfGameObjects {
    CCLOG(@"updateStateWithDeltaTime method should be overridden");
}
-(CGRect)adjustedBoundingBox {
    CCLOG(@"GameObect adjustedBoundingBox should be overridden");
    return [self boundingBox];
}

-(CCAnimation*)loadPlistForAnimationWithName:(NSString*)animationName
                                andClassName:(NSString*)className {
    CCAnimation *animationToReturn = nil;
    NSString *fullFileName = [NSString stringWithFormat:@"%@.plist", className];
    NSString *plistPath;
    
    // 1. get the path to the plist file
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:className ofType:@"plist"];
    }
    
    // 2.read in the plist file
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    // 3. if the plistDictionary was null, the file was not found
    if (plistDictionary == nil) {
        CCLOG(@"Error reading plist: %@.plist", className);
        return nil;
    }
    
    // 4. get just the mini-dictionary for this animation
    NSDictionary *animationSettngs = [plistDictionary objectForKey:animationName];
    if (animationSettngs == nil) {
        CCLOG(@"Could not loatate AnimationWithName:%@", animationName);
        return nil;
    }
    
    // 5. Get the delay value fot the animation
    float animationDelay = [[animationSettngs objectForKey:@"delay"] floatValue];
    animationToReturn = [CCAnimation animation];
    [animationToReturn setDelayPerUnit:animationDelay];
    
    // 6. Add the frames to the animation
    NSString *animationFramePrefix = [animationSettngs objectForKey:@"filenamePrefix"];
    NSString *animationFrames = [animationSettngs objectForKey:@"animationFrames"];
    NSArray *animationFrameNumbers = [animationFrames componentsSeparatedByString:@","];
    
    for (NSString *frameNumber in animationFrameNumbers) {
        NSString *frameName = [NSString stringWithFormat:@"%@%@.png", animationFramePrefix, frameNumber];
        [animationToReturn addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName]];
    }
    
    return animationToReturn;
}

@end
