//
//  PathAnimationVC.m
//  PSTestAnimProgress
//
//  Created by D. D. on 4/25/15.
//  Copyright (c) 2015 PhotoMagic. All rights reserved.
//

#import "PathAnimationVC.h"
#import <QuartzCore/QuartzCore.h>

@interface PathAnimationVC () {
    UIView          *_animView;
    CAShapeLayer    *_maskLayer;
}

@end

@implementation PathAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _animView = [[UIView alloc] initWithFrame:self.view.bounds];
    _animView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_animView];
    
    _maskLayer = [[CAShapeLayer alloc] init];
    _maskLayer.path = [self fromPath].CGPath;
    _animView.layer.mask = _maskLayer;
    
    CABasicAnimation *pathAnim = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnim.fromValue = (__bridge id)([self fromPath].CGPath);
    pathAnim.toValue = (__bridge id)([self toPath2].CGPath);
    
    pathAnim.duration = 3;
    pathAnim.delegate = self;
    [pathAnim setValue:@"toPath2" forKey:@"id"];
    
    [_maskLayer addAnimation:pathAnim forKey:nil];
    
    _maskLayer.path = [self toPath2].CGPath;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString * animKey = [anim valueForKey:@"id"];
    
    if ([animKey isEqualToString:@"toPath2"]) {
        
        CABasicAnimation *pathAnim = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnim.fromValue = (__bridge id)([self toPath2].CGPath);
        pathAnim.toValue = (__bridge id)([self toPath3].CGPath);
        
        pathAnim.duration = 3;
        pathAnim.delegate = self;
        [pathAnim setValue:@"toPath3" forKey:@"id"];
        
        [_maskLayer addAnimation:pathAnim forKey:nil];
        
        _maskLayer.path = [self toPath3].CGPath;
        
    } else if ([animKey isEqualToString:@"toPath2"]) {
        
    }
}


-(UIBezierPath *)fromPath {
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(65.5, 573.5)];
    [bezierPath addCurveToPoint: CGPointMake(91.5, 677.5) controlPoint1: CGPointMake(57.5, 675.5) controlPoint2: CGPointMake(67.5, 654.5)];
    [bezierPath addCurveToPoint: CGPointMake(870.5, 677.5) controlPoint1: CGPointMake(115.5, 700.5) controlPoint2: CGPointMake(870.5, 677.5)];
    [bezierPath addLineToPoint: CGPointMake(956.5, 573.5)];
    [bezierPath addLineToPoint: CGPointMake(956.5, 470.5)];
    [bezierPath addLineToPoint: CGPointMake(826.5, 368.5)];
    [bezierPath addLineToPoint: CGPointMake(334.5, 368.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 368.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 288.5)];
    [bezierPath addLineToPoint: CGPointMake(268.5, 224.5)];
    [bezierPath addLineToPoint: CGPointMake(870.5, 224.5)];
    [bezierPath addLineToPoint: CGPointMake(870.5, 62.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 62.5)];
    [bezierPath addLineToPoint: CGPointMake(44.5, 203.5)];
    [bezierPath addLineToPoint: CGPointMake(44.5, 420.5)];
    [bezierPath addLineToPoint: CGPointMake(150.5, 470.5)];
    [bezierPath addLineToPoint: CGPointMake(826.5, 470.5)];
    [bezierPath addLineToPoint: CGPointMake(870.5, 514.5)];
    [bezierPath addLineToPoint: CGPointMake(870.5, 573.5)];
    [bezierPath addLineToPoint: CGPointMake(826.5, 604.5)];
    [bezierPath addLineToPoint: CGPointMake(150.5, 604.5)];
    [bezierPath addCurveToPoint: CGPointMake(65.5, 573.5) controlPoint1: CGPointMake(150.5, 604.5) controlPoint2: CGPointMake(73.5, 471.5)];
    [bezierPath closePath];

    
    return bezierPath;
}

-(UIBezierPath *)toPath2 {
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(826.5, 644.5)];
    [bezierPath addLineToPoint: CGPointMake(826.5, 677.5)];
    [bezierPath addLineToPoint: CGPointMake(870.5, 677.5)];
    [bezierPath addLineToPoint: CGPointMake(956.5, 573.5)];
    [bezierPath addLineToPoint: CGPointMake(956.5, 470.5)];
    [bezierPath addLineToPoint: CGPointMake(826.5, 368.5)];
    [bezierPath addLineToPoint: CGPointMake(334.5, 368.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 368.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 288.5)];
    [bezierPath addLineToPoint: CGPointMake(268.5, 224.5)];
    [bezierPath addLineToPoint: CGPointMake(870.5, 224.5)];
    [bezierPath addLineToPoint: CGPointMake(870.5, 62.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 62.5)];
    [bezierPath addLineToPoint: CGPointMake(44.5, 203.5)];
    [bezierPath addLineToPoint: CGPointMake(44.5, 420.5)];
    [bezierPath addLineToPoint: CGPointMake(150.5, 470.5)];
    [bezierPath addLineToPoint: CGPointMake(826.5, 470.5)];
    [bezierPath addLineToPoint: CGPointMake(870.5, 514.5)];
    [bezierPath addLineToPoint: CGPointMake(870.5, 573.5)];
    [bezierPath addLineToPoint: CGPointMake(826.5, 573.5)];
    [bezierPath addLineToPoint: CGPointMake(826.5, 607.5)];
    [bezierPath addLineToPoint: CGPointMake(826.5, 644.5)];
    [bezierPath closePath];
    
    return bezierPath;
}

-(UIBezierPath *)toPath3 {
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(214.5, 471.5)];
    [bezierPath addLineToPoint: CGPointMake(214.5, 471.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 447.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 447.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 425.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 390.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 365.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 333.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 288.5)];
    [bezierPath addLineToPoint: CGPointMake(268.5, 224.5)];
    [bezierPath addLineToPoint: CGPointMake(870.5, 224.5)];
    [bezierPath addLineToPoint: CGPointMake(870.5, 62.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 62.5)];
    [bezierPath addLineToPoint: CGPointMake(44.5, 203.5)];
    [bezierPath addLineToPoint: CGPointMake(44.5, 425.5)];
    [bezierPath addLineToPoint: CGPointMake(65.5, 447.5)];
    [bezierPath addLineToPoint: CGPointMake(93.5, 471.5)];
    [bezierPath addLineToPoint: CGPointMake(120.5, 471.5)];
    [bezierPath addLineToPoint: CGPointMake(145.5, 471.5)];
    [bezierPath addLineToPoint: CGPointMake(170.5, 471.5)];
    [bezierPath addLineToPoint: CGPointMake(193.5, 471.5)];
    [bezierPath addLineToPoint: CGPointMake(214.5, 471.5)];
    [bezierPath closePath];
    
    return bezierPath;
}

@end
