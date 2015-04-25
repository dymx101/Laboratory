//
//  AppDelegate.m
//  popAnimation
//
//  Created by Michael Wilson on 8/11/14.
//
//

#import "AppDelegate.h"
#import "ExamplesController.h"

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ExamplesController *viewController = [[ExamplesController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    window.backgroundColor = [UIColor colorWithRed:0/255.0 green:47/255.0 blue:123/255.0 alpha:1];
    window.rootViewController = navigationController;

    [window makeKeyAndVisible];

    return YES;
}
							
@end
