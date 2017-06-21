//
//  MeowAppDelegate.m
//  Meow
//
//  Created by Parkin on 17/4/25.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "MeowAppDelegate.h"
#import "IQKeyboardManager.h"


@interface MeowAppDelegate ()

@end

@implementation MeowAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
     self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
     [self.window makeKeyAndVisible];
    
    
    MeowTabBarController *meowTab = [[MeowTabBarController alloc] init];
    self.window.rootViewController = meowTab;
    
//    [[IQKeyboardManager sharedManager] setEnable:YES];
//    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:15];
//    //Enabling autoToolbar behaviour. If It is set to NO. You have to manually create UIToolbar for keyboard.
//    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
//    
//    //Setting toolbar behavious to IQAutoToolbarBySubviews. Set it to IQAutoToolbarByTag to manage previous/next according to UITextField's tag property in increasing order.
//    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
//    
//    //Resign textField if touched outside of UITextField/UITextView.
//    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
