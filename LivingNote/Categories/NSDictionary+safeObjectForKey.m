//
//  NSDictionary+safeObjectForKey.m
//  Shops-iPhone
//
//  Created by xxy on 15/9/10.
//  Copyright (c) 2015年 net.atyun. All rights reserved.
//

#import "NSDictionary+safeObjectForKey.h"

#define checkNull(__X__)        (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]


@implementation NSDictionary (safeObjectForKey)

- (NSString *)safeObjectForKey:(id)key
{
    return checkNull([self objectForKey:key]);
}

@end
