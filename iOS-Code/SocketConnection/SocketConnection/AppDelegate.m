//
//  AppDelegate.m
//  SocketConnection
//
//  Created by Gaurav on 29/04/16.
//  Copyright © 2016 Softex Lab. All rights reserved.
//

#import "AppDelegate.h"
#import "GestureManager.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [GestureManager sharedInstance];
    return YES;
}

@end
