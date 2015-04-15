//
//  AppDelegate.h
//  WeatherForcastingDemo
//
//  Created by Shailendra on 09/04/15.
//  Copyright (c) 2015 Redbytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationVC;

@property (strong, nonatomic) MBProgressHUD * hudActivityIndicator;


- (void) showHUDActivityIndicator:(NSString *)message;
- (void) hideHUDActivityIndicator;
@end

