//
//  GameplayLayer.m
//  Chapter1
//
//  Created by Dong Yiming on 9/19/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "GameplayLayer.h"

#import "SpaceCargoShip.h"
#import "EnemyRobot.h"
#import "PhaserBullet.h"
#import "Mallet.h"
#import "Health.h"

@implementation GameplayLayer
- (id)init
{
    self = [super init];
    if (self) {
        CGSize screensize = [CCDirector sharedDirector].winSize;
        self.touchEnabled = YES;
        
        srand(time(NULL));  // Seeds the random number generator
        
        // 1
//        vikingSprite = [CCSprite spriteWithFile:@"sv_anim_1.png"];       
//        [self addChild:vikingSprite];
        
        // 2. create CCSpriteBatchNode
        //CCSpriteBatchNode *chapter2SpriteBatchNode;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlas.plist"];
            sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];
        } else {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlasiPhone.plist"];
            sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlasiPhone.png"];
        }
        
        [self addChild:sceneSpriteBatchNode z:0];
        [self initJoystickAndButtons];
        
        Viking *viking = [[Viking alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sv_anim_1.png"]];
        viking.joystick = leftJoystick;
        viking.jumpButton = jumpButton;
        viking.attackButton = attackButton;
        viking.position = ccp(screensize.width * .35f, screensize.height * .14f);
        viking.characterHealth = 100;
        
        [sceneSpriteBatchNode addChild:viking z:kVikingSpriteZValue tag:kVikingSpriteTagValue];
        
        [self createObjectOfType:kEnemyTypeRadarDish withHealth:100 atLocation:ccp(screensize.width * .878f, screensize.height * .13f) withZValue:10];
        
        [self scheduleUpdate];
        
        [self schedule:@selector(addEnemy) interval:10.f];
        [self createObjectOfType:kEnemyTypeSpaceCargoShip withHealth:0 atLocation:ccp(screensize.width * -.5f, screensize.height * .74f) withZValue:50];
        
        // create viking sprite from cache
//        vikingSprite = [CCSprite spriteWithSpriteFrameName:@"sv_anim_1.png"];
//        [sceneSpriteBatchNode addChild:vikingSprite];
//        [self addChild:sceneSpriteBatchNode];
//        
//        [vikingSprite setPosition:ccp(screensize.width / 2, screensize.height * .17f)];
//        
//        // create robot from image file
//        CCSprite *animatingRobot = [CCSprite spriteWithFile:@"an1_anim1.png"];
//        [animatingRobot setPosition:ccp(vikingSprite.position.x + 50.f, vikingSprite.position.y)];
//        [self addChild:animatingRobot];
//        
//        CCAnimation *robotAnim = [CCAnimation animation];
//        [robotAnim addSpriteFrameWithFilename:@"an1_anim2.png"];
//        [robotAnim addSpriteFrameWithFilename:@"an1_anim3.png"];
//        [robotAnim addSpriteFrameWithFilename:@"an1_anim4.png"];
//        robotAnim.delayPerUnit = .5f;
//        robotAnim.restoreOriginalFrame = YES;
//        
//        id robotAnimationAction = [CCAnimate actionWithAnimation:robotAnim];
//        id repeatRobotAnimation = [CCRepeatForever actionWithAction:robotAnimationAction];
//        [animatingRobot runAction:repeatRobotAnimation];
//        
//        // animation example with a CCSpriteBatchNode
//        CCAnimation *exampleAnim = [CCAnimation animation];
//        [exampleAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sv_anim_2.png"]];
//        [exampleAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sv_anim_3.png"]];
//        [exampleAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sv_anim_4.png"]];
//        exampleAnim.delayPerUnit = .5f;
//        exampleAnim.restoreOriginalFrame = NO;
//        
//        id animateAction = [CCAnimate actionWithAnimation:exampleAnim];
//        id repeatAction = [CCRepeatForever actionWithAction:animateAction];
//        [vikingSprite runAction:repeatAction];
//        
//        //
//        [self initJoystickAndButtons];
//        [self scheduleUpdate];
//        
//        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
//        {
//            [vikingSprite setScaleX:screensize.width / 1024.f];
//            [vikingSprite setScaleY:screensize.height / 768.f];
//        }
    }
    return self;
}

-(void)initJoystickAndButtons
{
    CGSize screensize = [CCDirector sharedDirector].winSize;
    
    CGRect joystickBaseDimensions = CGRectMake(0, 0, 128.f, 128.f);
    CGRect jumpButtonDimensions = CGRectMake(0, 0, 64.f, 64.f);
    CGRect attackButtonDimensions = CGRectMake(0, 0, 64.f, 64.f);
    
    CGPoint joystickBasePosition, jumpButtonPosition, attackButtonPosition;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        joystickBasePosition = ccp(screensize.width * 0.0625f, screensize.height * 0.052f);
        jumpButtonPosition = ccp(screensize.width * .946f, screensize.height * .052f);
        attackButtonPosition = ccp(screensize.width * .947f, screensize.height * .169f);
    }
    else
    {
        joystickBasePosition = ccp(screensize.width * .07f, screensize.height * .11f);
        jumpButtonPosition = ccp(screensize.width * .93f, screensize.height * .11f);
        attackButtonPosition = ccp(screensize.width * .93f, screensize.height * .35f);
    }
    
    SneakyJoystickSkinnedBase *joystickBase = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    joystickBase.position = joystickBasePosition;
    joystickBase.backgroundSprite = [CCSprite spriteWithFile:@"dpadDown.png"];
    joystickBase.thumbSprite = [CCSprite spriteWithFile:@"joystickDown.png"];
    joystickBase.joystick = [[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    leftJoystick = [joystickBase.joystick retain];
    [self addChild:joystickBase];
    
    SneakyButtonSkinnedBase *jumpButtonBase = [[SneakyButtonSkinnedBase new] autorelease];
    jumpButtonBase.position = jumpButtonPosition;
    jumpButtonBase.defaultSprite = [CCSprite spriteWithFile:@"jumpUp.png"];
    jumpButtonBase.activatedSprite = [CCSprite spriteWithFile:@"jumpDown.png"];
    jumpButtonBase.pressSprite = [CCSprite spriteWithFile:@"jumpDown.png"];
    jumpButtonBase.button = [[SneakyButton alloc] initWithRect:jumpButtonDimensions];
    jumpButton = [jumpButtonBase.button retain];
    jumpButton.isToggleable = NO;
    [self addChild:jumpButtonBase];
    
    SneakyButtonSkinnedBase *attackButtonBase = [[SneakyButtonSkinnedBase new] autorelease];
    attackButtonBase.position = attackButtonPosition;
    attackButtonBase.defaultSprite = [CCSprite spriteWithFile:@"handUp.png"];
    attackButtonBase.activatedSprite = [CCSprite spriteWithFile:@"handDown.png"];
    attackButtonBase.pressSprite = [CCSprite spriteWithFile:@"handDown.png"];
    attackButtonBase.button = [[SneakyButton alloc] initWithRect:attackButtonDimensions];
    attackButton = [attackButtonBase.button retain];
    attackButton.isToggleable = NO;
    [self addChild:attackButtonBase];
}

//-(void)applyJoyStick:(SneakyJoystick *)aJoystick toNode:(CCNode *)tempNode fromTimeDelta:(float)deltaTime
//{
//    CGPoint scaledVelocity = ccpMult(aJoystick.velocity, 1024.f);
//    CGPoint newPositon = ccp(tempNode.position.x + scaledVelocity.x * deltaTime, tempNode.position.y /*+ scaledVelocity.y * deltaTime*/);
//    newPositon.x = MAX(vikingSprite.textureRect.size.width / 2, newPositon.x);
//    newPositon.x = min([CCDirector sharedDirector].winSize.width, newPositon.x);
//    [tempNode setPosition:newPositon];
//   
//    if (jumpButton.active)
//    {
//        CCLOG(@"Jump button is pressed");
//    }
//    
//    if (attackButton.active)
//    {
//        CCLOG(@"Attack button is pressed");
//    }
//}

#pragma mark -
#pragma mark Update Method
-(void)update:(ccTime)delta
{
    //[self applyJoyStick:leftJoystick toNode:vikingSprite fromTimeDelta:delta];
    
    CCArray *listOfGagemObjects = sceneSpriteBatchNode.children;
    CCLOG(@"object count:%d", listOfGagemObjects.count);
    
    GameCharacter *viking = (GameCharacter *)[sceneSpriteBatchNode getChildByTag:kVikingSpriteTagValue];
    [viking updateStateWithDeltaTime:delta andListOfGameObjects:listOfGagemObjects];
    
    listOfGagemObjects = sceneSpriteBatchNode.children;
    CCLOG(@"object count:%d", listOfGagemObjects.count);
    for (GameCharacter *tempChar in listOfGagemObjects) {
        [tempChar updateStateWithDeltaTime:delta andListOfGameObjects:listOfGagemObjects];
        
//        if (tempChar.gameObjectType == kEnemyTypeRadarDish && tempChar.characterState == kStateDead)
//        {
//            CCLOG(@"Level Completed!");
//        }
    }
}

-(void)dealloc
{
    [leftJoystick release];
    [jumpButton release];
    [attackButton release];
    
    [super dealloc];
}

#pragma mark -
-(void)createObjectOfType:(GameObjectType)objectType withHealth:(int)initialHealth atLocation:(CGPoint)spawnLocation withZValue:(int)ZValue
{
    if (objectType == kEnemyTypeRadarDish)
    {
        CCLOG(@"Creating the Radar Enemy");
        RadarDish *radarDish = [[RadarDish alloc] initWithSpriteFrameName:@"radar_1.png"];
        radarDish.characterHealth = initialHealth;
        radarDish.position = spawnLocation;
        //[radarDish runAction:[CCFlipX actionWithFlipX:YES]];
        [sceneSpriteBatchNode addChild:radarDish z:ZValue tag:kRadarDishTagValue];
        [radarDish release];
    }
    else if (kEnemyTypeAlienRobot == objectType)
    {
        CCLOG(@"Creating the Alien Robot");
        EnemyRobot *enemyRobot = [[EnemyRobot alloc] initWithSpriteFrameName:@"an1_anim1.png"];
        enemyRobot.characterHealth = initialHealth;
        enemyRobot.position = spawnLocation;
        [enemyRobot changeState:kStateSpawning];
        [sceneSpriteBatchNode addChild:enemyRobot z:ZValue];
        enemyRobot.delegate = self;
        [enemyRobot release];
    }
    else if (kEnemyTypeSpaceCargoShip == objectType)
    {
        SpaceCargoShip *ship = [[SpaceCargoShip alloc] initWithSpriteFrameName:@"ship_2.png"];
        ship.delegate = self;
        ship.position = spawnLocation;
        [sceneSpriteBatchNode addChild:ship z:ZValue];
        [ship release];
    }
    else if (kPowerUpTypeMallet == objectType)
    {
        Mallet *mallet = [[Mallet alloc] initWithSpriteFrameName:@"mallet_1.png"];
        mallet.position = spawnLocation;
        [sceneSpriteBatchNode addChild:mallet];
        [mallet release];
    }
    else if (kPowerUpTypeHealth == objectType)
    {
        Health *health = [[Health alloc] initWithSpriteFrameName:@"sandwich_1.png"];
        health.position = spawnLocation;
        [sceneSpriteBatchNode addChild:health];
        [health release];
    }
}

-(void)createPhaserWithDirection:(PhaserDirection)phaserDirection andPosition:(CGPoint)spawnPosition
{
    PhaserBullet *phaserBullet = [[PhaserBullet alloc] initWithSpriteFrameName:@"beam_1.png"];
    phaserBullet.position = spawnPosition;
    phaserBullet.myDirection = phaserDirection;
    phaserBullet.characterState = kStateSpawning;
    [sceneSpriteBatchNode addChild:phaserBullet];
    [phaserBullet release];
}

-(void)addEnemy
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    RadarDish *radarDish = (RadarDish *)[sceneSpriteBatchNode getChildByTag:kRadarDishTagValue];
    
    if (radarDish)
    {
        if (radarDish.characterState != kStateDead)
        {
            [self createObjectOfType:kEnemyTypeAlienRobot withHealth:100 atLocation:ccp(screenSize.width * .195f, screenSize.height * .1432f) withZValue:2];
        }
        else
        {
            [self unschedule:@selector(addEnemy)];
        }
    }
}

@end
