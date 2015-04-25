//
//  DecayAnimationController.m
//  popAnimation
//
//  Created by Michael Wilson on 8/12/14.
//
//

#import "DecayAnimationController.h"
#import <pop/POPDecayAnimation.h>

@implementation DecayAnimationController

@synthesize object;
@synthesize velocity;

- (id)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];

        object = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 50, 50)];
        object.backgroundColor = [UIColor redColor];

        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(draggedView:)];
        [self.view addGestureRecognizer:panGesture];

        [self.view addSubview:object];
    }
    return self;
}
- (void) draggedView:(UIPanGestureRecognizer*)panGesture {

    if (panGesture.state == UIGestureRecognizerStateBegan || panGesture.state == UIGestureRecognizerStateChanged) {

        CGPoint translation = [panGesture translationInView:self.view];
        object.center = CGPointMake(object.center.x + translation.x, object.center.y+translation.y);
        [object pop_removeAllAnimations];
        [panGesture setTranslation:CGPointZero inView:self.view];
    }
    else if (panGesture.state == UIGestureRecognizerStateEnded) {
        velocity = [panGesture velocityInView:object.superview];

        POPDecayAnimation *decayAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        decayAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        [object pop_addAnimation:decayAnimation forKey:@"decayAnimation"];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [object pop_removeAllAnimations];
    object.frame = CGRectMake(200, 100, 50, 50);
}

@end
