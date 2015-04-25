//
//  ExamplesController.h
//  popAnimation
//
//  Created by Michael Wilson on 8/11/14.
//
//

#import <UIKit/UIKit.h>
#import "BasicAnimationController.h"
#import "SpringAnimationController.h"
#import "DecayAnimationController.h"

@interface ExamplesController : UITabBarController

@property (nonatomic, retain) BasicAnimationController *basicAnimationController;
@property (nonatomic, retain) SpringAnimationController *springAnimationController;
@property (nonatomic, retain) DecayAnimationController *decayAnimationController;

@end
