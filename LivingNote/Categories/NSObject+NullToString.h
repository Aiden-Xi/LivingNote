//
//  NSObject+NullToString.h
//  Shops-iPhone
//
//  Created by rujax on 2013-12-20.
//  Copyright (c) 2013年 net.atyun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>

@interface NSObject (NullToString)

- (NSString *)toString;
- (NSArray *)toArray;
- (NSString *)toMD5;

@end
