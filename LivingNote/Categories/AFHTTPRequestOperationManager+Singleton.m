//
//  AFHTTPRequestOperationManager+Singleton.m
//  GuduMorning
//
//  Created by Tsao on 15/8/1.
//  Copyright (c) 2015年 FinalFerrumbox. All rights reserved.
//

#import "AFHTTPRequestOperationManager+Singleton.h"

#import "UserSession.h"

@implementation AFHTTPRequestOperationManager (Singleton)

static AFHTTPRequestOperationManager *instance;

+ (instancetype)singleton{
    if (!instance){
        instance = [AFHTTPRequestOperationManager manager];
        instance.requestSerializer.timeoutInterval = 30;
        AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        instance.requestSerializer = serializer;
        UserSession *session = [UserSession sharedUserSession];
        [RACObserve(session, sessionToken) subscribeNext:^(NSString *token) {
            if (token != nil) {
                [serializer setValue:token forHTTPHeaderField:@"x-access-token"];
            }
        }];
    }
    return instance;
}

@end
