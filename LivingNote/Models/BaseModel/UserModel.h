//
//  UserModel.h
//  GuduMorning
//
//  Created by Macbook on 15/9/2.
//  Copyright (c) 2015年 FinalFerrumbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

/**
 *  手机号
 */
@property (nonatomic, copy) NSString *phone;

/// 用户地址
@property (nonatomic, strong) NSMutableArray *addresses;

/// 用户识别身份
@property (nonatomic, assign) int userType;

@end
