//
//  ViewController.m
//  PSTestAnimProgress
//
//  Created by D. D. on 4/25/15.
//  Copyright (c) 2015 PhotoMagic. All rights reserved.
//

#import "AnimationProgressVC.h"

@interface AnimationProgressVC () {
    
    UIView *_animView;
}
@property(nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation AnimationProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _animView = [UIView new];
    _animView.backgroundColor = [UIColor magentaColor];
    _animView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:_animView];
    
    [self animateGearKnob];
}


- (void)animateGearKnob {
    
    // invalidate any pending timer
    [self.displayLink invalidate];
    
    // create a timer that's synchronized with the refresh rate of the display
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateDuringAnimation)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    // launch the animation
    [UIView animateWithDuration:0.3 delay:0 options:0 animations:^{
        
        _animView.frame = CGRectMake(100, 200, 200, 200);
        
    } completion:^(BOOL finished) {
        
        // terminate the timer when the animation is complete
        [self.displayLink invalidate];
        self.displayLink = nil;
    }];
}


- (void)updateDuringAnimation {
    
    NSString *rect = NSStringFromCGRect(((CALayer *)_animView.layer.presentationLayer).frame);
    NSLog(@"%@", rect);
    
}


@end
