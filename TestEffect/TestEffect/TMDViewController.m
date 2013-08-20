//
//  TMDViewController.m
//  TestEffect
//
//  Created by Dong Yiming on 8/20/13.
//  Copyright (c) 2013 Dong Yiming. All rights reserved.
//

#import "TMDViewController.h"
#import "DRNRealTimeBlurView.h"

@interface TMDViewController ()

@end

@implementation TMDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    DRNRealTimeBlurView *blurView = [[DRNRealTimeBlurView alloc] initWithFrame:CGRectMake(60, 110, 200, 200)];
    [self.view addSubview:blurView];
    
    UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [blurView addGestureRecognizer:panGest];
}

-(void)pan:(UIPanGestureRecognizer *)gest
{
    CGPoint pt = [gest translationInView:gest.view];
    UIView *view = gest.view;
    view.frame = CGRectMake(pt.x, pt.y, view.frame.size.width, view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
