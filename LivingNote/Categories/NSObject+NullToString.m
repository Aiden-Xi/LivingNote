//
//  NSObject+NullToString.m
//  Shops-iPhone
//
//  Created by rujax on 2013-12-20.
//  Copyright (c) 2013年 net.atyun. All rights reserved.
//

#import "NSObject+NullToString.h"

@implementation NSObject (NullToString)

- (NSString *)toString
{
//    YunLog(@"self = %@", self);
    
    NSString *str;
    
    if ([self isEqual:[NSNull null]] || !self) {
        str = @"";
    } else {
        str = [NSString stringWithFormat:@"%@", self];
    }
    
//    YunLog(@"str = %@", str);
    
    return str;
}

- (NSArray *)toArray
{
    NSArray *arr;
    
    if ([self isEqual:[NSNull null]] || !self) {
        arr = [[NSArray alloc] init];
    } else {
        arr = (NSArray *)self;
    }
    
    return arr;
}

- (NSString *)toMD5
{    
    if (self == nil)
        return nil;
    
    NSString *str = [self toString];
    const char *value = [str UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }
    
    return outputString;
}

@end
