//
//  MBProgressHUD+Extend.h
//  Shops-iPhone
//
//  Created by rujax on 14/11/12.
//  Copyright (c) 2014年 net.atyun. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extend)

- (void)addSuccessString:(NSString *)str delay:(NSTimeInterval)delay;
- (void)addErrorString:(NSString *)str delay:(NSTimeInterval)delay;

@end
