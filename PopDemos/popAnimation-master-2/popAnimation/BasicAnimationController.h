//
//  BasicAnimationController.h
//  popAnimation
//
//  Created by Michael Wilson on 8/12/14.
//
//

#import <UIKit/UIKit.h>
#import <pop/POPBasicAnimation.h>
#import <Pop/POP.h>

@interface BasicAnimationController : UIViewController <POPAnimationDelegate>

@property (nonatomic, retain) UIView *object;

@end
