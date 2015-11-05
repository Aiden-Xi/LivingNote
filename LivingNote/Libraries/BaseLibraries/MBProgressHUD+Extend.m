//
//  MBProgressHUD+Extend.m
//  Shops-iPhone
//
//  Created by rujax on 14/11/12.
//  Copyright (c) 2014年 net.atyun. All rights reserved.
//

#import "MBProgressHUD+Extend.h"

@implementation MBProgressHUD (Extend)

- (void)addSuccessString:(NSString *)str delay:(NSTimeInterval)delay
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mbprogress_checkmark"]];
    self.customView = imageView;
    self.mode = MBProgressHUDModeCustomView;
    self.labelText = str;
    
    [self hide:YES afterDelay:delay];
}

- (void)addErrorString:(NSString *)str delay:(NSTimeInterval)delay
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mbprogress_error"]];
    self.customView = imageView;
    self.mode = MBProgressHUDModeCustomView;
    self.labelText = str;
    
    [self hide:YES afterDelay:delay];
}

@end