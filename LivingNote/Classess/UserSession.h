//
//  UserSession.h
//  GuduMorning
//
//  Created by Macbook on 15/9/2.
//  Copyright (c) 2015年 FinalFerrumbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kUserSessionNeedReloadNotificationName @"UserSessionIsNotUpToDateAndNeedToUpdate"
@interface UserSession : NSObject

/**
 *  获取application中全局共享的用户登录session
 *
 *  @return UserSession的实例
 */
+ (instancetype)sharedUserSession;

/**
 *  是否已经登录
 */
@property (nonatomic, assign) BOOL isLogin;

/**
 *  对应的user模型
 */
@property (nonatomic, strong) UserModel *user;

/**
 *
 *  返回登录时候中response的token
 */
@property (nonatomic, copy) NSString *sessionToken;

@end
