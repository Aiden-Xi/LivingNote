//
//  UserModel.m
//  GuduMorning
//
//  Created by Macbook on 15/9/2.
//  Copyright (c) 2015年 FinalFerrumbox. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+ (void)initialize{
    [self setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"addresses" : @"AddressModel"
                 };
    }];
}
@end
