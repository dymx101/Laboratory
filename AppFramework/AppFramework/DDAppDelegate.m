//
//  DDAppDelegate.m
//  AppFramework
//
//  Created by Dong Yiming on 10/23/13.
//  Copyright (c) 2013 ToMaDon. All rights reserved.
//

#import "DDAppDelegate.h"

#import "DDViewController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"

@implementation DDAppDelegate

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.viewController = [[DDViewController alloc] initWithNibName:@"DDViewController" bundle:nil];
    
    
    UIViewController * leftDrawer = [[UINavigationController alloc] initWithRootViewController:[DDTestLeftVC new]];
    UIViewController * center = [[UINavigationController alloc] initWithRootViewController:[DDTestCenterVC new]];
    UIViewController * rightDrawer = [[UINavigationController alloc] initWithRootViewController:[DDTestRightVC new]];
    
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:center
                                             leftDrawerViewController:leftDrawer
                                             rightDrawerViewController:rightDrawer];
    
    [drawerController setRestorationIdentifier:@"MMDrawer"];
    [drawerController setMaximumRightDrawerWidth:100.0];
    drawerController.maximumLeftDrawerWidth = 150;
    drawerController.showsShadow = YES;
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         MMExampleDrawerVisualStateManager *sharedVisualManager = [MMExampleDrawerVisualStateManager sharedManager];
         sharedVisualManager.leftDrawerAnimationType = MMDrawerAnimationTypeSwingingDoor;
         sharedVisualManager.rightDrawerAnimationType = MMDrawerAnimationTypeParallax;
         
         block = [sharedVisualManager drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
         
        //
         UIViewController * sideDrawerViewController;
//         if(drawerSide == MMDrawerSideLeft){
//             sideDrawerViewController = drawerController.leftDrawerViewController;
//         }
//         else
         
             if(drawerSide == MMDrawerSideRight){
             sideDrawerViewController = drawerController.rightDrawerViewController;
         }
         [sideDrawerViewController.view setAlpha:percentVisible];
     
     }];
    
    
    
    self.window.rootViewController = drawerController;
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self.window makeKeyAndVisible];
    
    [self testCocoaLumberJack];
    
    return YES;
}

-(void)testCocoaLumberJack
{
    // init loggers and add them
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    
    [DDLog addLogger:fileLogger];
    
    //usage
    DDLogError(@"Broken sprocket detected!");
    NSString *filePath = @"Usr/Dong";
    NSUInteger fileSize = 19999;
    DDLogVerbose(@"User selected file:%@ withSize:%u", filePath, fileSize);
    
    
    // And then enable colors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    // Check out default colors:
    // Error : Red
    // Warn  : Orange
    
    DDLogError(@"Paper jam");                              // Red
    DDLogWarn(@"Toner is low");                            // Orange
    DDLogInfo(@"Warming up printer (pre-customization)");  // Default (black)
    DDLogVerbose(@"Intializing protcol x26");              // Default (black)
    
    // Now let's do some customization:
    // Info  : Pink
    
#if TARGET_OS_IPHONE
    UIColor *pink = [UIColor colorWithRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
#else
    NSColor *pink = [NSColor colorWithCalibratedRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
#endif
    
    [[DDTTYLogger sharedInstance] setForegroundColor:pink backgroundColor:nil forFlag:LOG_FLAG_INFO];
    
    DDLogInfo(@"Warming up printer (post-customization)"); // Pink !
}

- (void)applicationWillResignActive:(UIApplication *)application{}
- (void)applicationDidEnterBackground:(UIApplication *)application{}
- (void)applicationWillEnterForeground:(UIApplication *)application{}
- (void)applicationDidBecomeActive:(UIApplication *)application{}
- (void)applicationWillTerminate:(UIApplication *)application{}

@end
