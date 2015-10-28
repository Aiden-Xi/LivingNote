//
//  UserSession.m
//  GuduMorning
//
//  Created by Macbook on 15/9/2.
//  Copyright (c) 2015年 FinalFerrumbox. All rights reserved.
//

#import "UserSession.h"
#define kSessionUserDefaultKey @"user_session_key"
@implementation UserSession

+ (instancetype)sharedUserSession{
    static UserSession *session;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        session = [[UserSession alloc] init];
    });
    return session;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setUpTrigger];
    }
    return self;
}

- (void)fetchUserInfo{
    RACChannelTerminal *sessionChangeTerminal = [[NSUserDefaults standardUserDefaults] rac_channelTerminalForKey:kSessionUserDefaultKey];
    dispatch_async(dispatch_get_main_queue(), ^{
        [sessionChangeTerminal subscribeNext:^(NSString *value) {
            if (value != nil) {
                // 请求用户信息
                XXYLog(@"token:%@",value);
                NSString *url = [Tool buildRequestURLHost:nil APIVersion:nil requestURL:nil params:nil];
                [[Tool GET:url parameters:nil showNetworkError:NO] subscribeNext:^(id responseObject) {
                    if (kGetResponseCode(responseObject) == kSuccessCode) {
                         self.user = [UserModel objectWithKeyValues:kGetResponseData(responseObject)];
                    }
                    else {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            [self fetchUserInfo];
                        });
                    }
                   
                }
                 error:^(NSError *error) {
                     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                         [self fetchUserInfo];
                     });
                 }
                 ];
                
            }
        }];
    });
    
    // 如果有需要重新加载用户信息的通知则去加载
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:kUserSessionNeedReloadNotificationName object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        [self fetchUserInfo];
    }];

}

- (void)setUpTrigger{
    RACChannelTerminal *sessionChangeTerminal = [[NSUserDefaults standardUserDefaults] rac_channelTerminalForKey:kSessionUserDefaultKey];
    [self fetchUserInfo];
    // 双向绑定user default
    [RACObserve(self, sessionToken) subscribeNext:^(id x) {
        if (x != nil) {
            [Tool setUserDefault:@{kSessionUserDefaultKey : x}];
        }
    }];
   
    RAC(self, sessionToken) = [sessionChangeTerminal map:^id(NSString *token) {
        return token;
    }];

    RAC(self, isLogin) = [sessionChangeTerminal map:^id(NSString *token) {
        XXYLog(@"登录成功：%d", token != nil);
        return [NSNumber numberWithBool:token != nil];
    }];
}



@end
