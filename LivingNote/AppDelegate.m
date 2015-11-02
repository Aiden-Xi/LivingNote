//
//  AppDelegate.m
//  LivingNote
//
//  Created by xxy on 15/10/16.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "AppDelegate.h"

#import "System.h"

#import "GuideViewController.h"

#import "KKNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/// 创建程序视图
- (void)CreateControllers {
    UIViewController *homeVC =  [kLivingNoteStoryBoard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    KKNavigationController *homeNC = [[KKNavigationController alloc] initWithRootViewController:homeVC];
    
    UIViewController *cartVC = [kLivingNoteStoryBoard instantiateViewControllerWithIdentifier:@"CartViewController"];
    KKNavigationController *cartNC = [[KKNavigationController alloc] initWithRootViewController:cartVC];
    
    UIViewController *docterVC = [kLivingNoteStoryBoard instantiateViewControllerWithIdentifier:@"DocterMineViewController"];
    KKNavigationController *docterNc = [[KKNavigationController alloc] initWithRootViewController:docterVC];
    
    UIViewController *sickVC = [kLivingNoteStoryBoard instantiateViewControllerWithIdentifier:@"SickMineViewController"];
    KKNavigationController *sickNc = [[KKNavigationController alloc] initWithRootViewController:sickVC];
    
    UIViewController *aboutVC = [kLivingNoteStoryBoard instantiateViewControllerWithIdentifier:@"AboutViewController"];
    KKNavigationController *aboutNC = [[KKNavigationController alloc] initWithRootViewController:aboutVC];
    
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    
    NSArray *tabBarItemImages = @[@"tab_home_selected", @"tab_my_group_selected", @"tab_personal_center_selected", @"tab_contactUs_selected"];
    NSArray *tabBarItemUnImages = @[@"tab_home_unselected", @"tab_my_group_unselected", @"tab_personal_center_unselected", @"tab_contactUs_unselected"];
    
    NSArray *tabBarItemTitles = @[@"主页", @"我的圈子", @"个人中心", @"联系我们"];
    
    RDVTabBarController *rdv_TabBarController = [[RDVTabBarController alloc] init];
    
    _user = [[UserModel alloc] init];
    self.user.userType = 2;
    
    if (self.user.userType == 1) {  // 游客  病人
        [rdv_TabBarController setViewControllers:@[homeNC, cartNC, sickNc, aboutNC]];
    }
    
    if(self.user.userType == 2) {
        [rdv_TabBarController setViewControllers:@[homeNC, cartNC, docterNc, aboutNC]];
    }

    RDVTabBar *tabBar = [rdv_TabBarController tabBar];
    
    [tabBar setFrame:CGRectMake(CGRectGetMinX(tabBar.frame), CGRectGetMinY(tabBar.frame), CGRectGetWidth(tabBar.frame), 50)];
    
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[rdv_TabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        
        UIImage *selectedimage = [UIImage imageNamed:[tabBarItemImages objectAtIndex:index]];
        UIImage *unselectedimage = [UIImage imageNamed:[tabBarItemUnImages objectAtIndex:index]];
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        [item setTitle:[NSString stringWithFormat:@"%@", tabBarItemTitles[index]]];
        
        [item setSelectedTitleAttributes:@{
                                          NSFontAttributeName: kSmallFont,
                                          NSForegroundColorAttributeName:COLOR(214, 110, 126, 1)
                                          }];
        
        [item setUnselectedTitleAttributes:@{
                                            NSFontAttributeName: kSmallFont,
                                            NSForegroundColorAttributeName:COLOR(115, 115, 115, 1)
                                            }];
        [item setTitlePositionAdjustment:UIOffsetMake(0, 1)];
        
        index++;
    }
    
    self.window = [[UIWindow alloc] initWithFrame:kScreenBounds];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = rdv_TabBarController;
    self.window.backgroundColor = COLOR(232, 228, 223, 1);
    
    [self.window makeKeyAndVisible];
}

/// 如果用户没有登陆，则用户进入引导页
- (void)CreateGuideControllers {
    self.window = [[UIWindow alloc] initWithFrame:kScreenBounds];
    
    GuideViewController *guide = [[GuideViewController alloc] init];
    KKNavigationController *popNC = [[KKNavigationController alloc] initWithRootViewController:guide];
    
    self.window.rootViewController = popNC;
    self.window.backgroundColor = COLOR(232, 228, 223, 1);
    
    [self.window makeKeyAndVisible];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    // 键盘处理库 创建单例
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.keyboardDistanceFromTextField = 40;
    manager.enableAutoToolbar = YES;
    manager.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.canAdjustTextView = YES;
    
    // 设置所有的导航栏都隐藏， 项目中使用自己创建的导航栏
    [kApplication setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    // 频闪2秒
     [NSThread sleepForTimeInterval:0.5];
    
    // 测试
    self.isLogin = YES;
    
    NSString *isFirstLogin = kNullToString([kUserDefaults objectForKey:@"firstLogin"]);
    
    // 判断用户是否登录
    if (self.isLogin) {
        [self CreateControllers];
    } else {
        if ([isFirstLogin isEqualToString:@""]) {
            [self CreateGuideControllers];
        }
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "atyun.LivingNote" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LivingNote" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LivingNote.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
