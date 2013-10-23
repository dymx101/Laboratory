//
//  DDViewController.m
//  AppFramework
//
//  Created by Dong Yiming on 10/23/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "DDViewController.h"

@interface DDViewController ()

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //self.view.backgroundColor = [UIColor colorWithCrayola:@""];
}

@end

@implementation DDTestLeftVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithCrayola:@"Caribbean Green"];
    
    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeInfoDark]];
}

@end

@implementation DDTestCenterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //self.view.backgroundColor = [UIColor colorWithCrayola:@"Mango Tango"];
    //self.view.backgroundColor = [UIColor colorWithHex:0x6099EF];
    //self.view.backgroundColor = [UIColor colorWithHex:0x6099EF andAlpha:.2f];
    //self.view.backgroundColor = [UIColor colorWithHexString:@"#ABCDEF"];
    
    UIColor *red     = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f];
    //UIColor *blue    = [red offsetWithHue:-0.26f saturation:0.5f brightness:0.0f alpha:0.0f];
    //UIColor *pink    = [red offsetWithHue:0.2f saturation:0.5f lightness:0.0f alpha:0.0f];
    UIColor *brighterRed    = [red offsetWithLightness:15.0f a:0.0f b:0.0f alpha:0.0f];
    self.view.backgroundColor = brighterRed;
}

@end

@implementation DDTestRightVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithCrayola:@"Midnight Blue"];
    
    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeInfoLight]];
}

@end
