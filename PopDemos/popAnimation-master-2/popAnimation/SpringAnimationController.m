//
//  SpringAnimationController.m
//  popAnimation
//
//  Created by Michael Wilson on 8/12/14.
//
//

#import "SpringAnimationController.h"
#import <pop/POPSpringAnimation.h>

@implementation SpringAnimationController

@synthesize object;
@synthesize start;
@synthesize velocity;

- (id)init {
    self = [super init];
    if (self) {

        self.view.backgroundColor = [UIColor whiteColor];

        CGRect rect = self.view.frame;
        rect.size.height = rect.size.height - 44;
        object = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-200)/2.0, (rect.size.height-200)/2.0, 200, 200)];
        object.backgroundColor = [UIColor redColor];

        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipedView:)];
        [self.view addGestureRecognizer:panGesture];

        [self.view addSubview:object];
    }
    return self;
}


- (void)swipedView:(UIPanGestureRecognizer *)panGesture {
    //velocity = [panGesture velocityInView:object.superview];
    CGPoint location = [panGesture locationInView:object.superview];

    if (panGesture.state == UIGestureRecognizerStateBegan) {
        start = location;

        //Anchor the original touch point.
        CGPoint anchor = [panGesture locationInView:object];
        [self setAnchorPoint:CGPointMake(anchor.x/object.frame.size.width, anchor.y/object.frame.size.height)];

        [object pop_removeAllAnimations];
    }
    else if (panGesture.state == UIGestureRecognizerStateChanged) {
        object.center = location;
    }
    else if (panGesture.state == UIGestureRecognizerStateEnded) {
        velocity = [panGesture velocityInView:object.superview];
        POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        springAnimation.toValue = [NSValue valueWithCGPoint:start];
        springAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        springAnimation.dynamicsTension = 500;
        springAnimation.dynamicsFriction = 15.0;
        [object pop_addAnimation:springAnimation forKey:@"springAnimation"];
    }
}

- (void)setAnchorPoint:(CGPoint)anchorPoint {
    // The anchor point is a value between 0 and 1.
    CGPoint oldPoint = CGPointMake(object.bounds.size.width * object.layer.anchorPoint.x, object.bounds.size.height * object.layer.anchorPoint.y);
    CGPoint newPoint = CGPointMake(object.bounds.size.width * anchorPoint.x, object.bounds.size.height * anchorPoint.y);

    newPoint = CGPointApplyAffineTransform(newPoint, object.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, object.transform);

    CGPoint position = object.layer.position;

    position.x -= oldPoint.x;
    position.x += newPoint.x;

    position.y -= oldPoint.y;
    position.y += newPoint.y;

    object.layer.position = position;
    object.layer.anchorPoint = anchorPoint;
}

@end
