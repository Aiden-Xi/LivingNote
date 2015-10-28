//
//  UIView+AddBadge.m
//  Shops-iPhone
//
//  Created by rujax on 14-3-6.
//  Copyright (c) 2014年 net.atyun. All rights reserved.
//

#import "UIView+AddBadge.h"

@implementation UIView (AddBadge)

- (void)addBadge:(NSString *)value
{
    UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"" image:nil tag:0];
    item.badgeValue = value;
    
    NSArray *array = [[NSArray alloc] initWithObjects:item, nil];
    
    tabBar.items = array;
    
    // 寻找
    for (UIView *viewTab in tabBar.subviews) {
        for (UIView *subview in viewTab.subviews) {
            NSString *strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
            if ([strClassName isEqualToString:@"UITabBarButtonBadge"] || [strClassName isEqualToString:@"_UIBadgeView"]) {
                // 从原视图上移除
                [subview removeFromSuperview];
                
                // 添加到需要的视图
                subview.center = CGPointMake(self.frame.size.width, subview.frame.size.height / 2);
                
                [self addSubview:subview];
                
                return;
            }
        }
    }
}

- (void)removeBadge
{
    for (UIView *subview in self.subviews) {
        NSString *strClassName = [NSString stringWithUTF8String:object_getClassName(subview)];
        if ([strClassName isEqualToString:@"UITabBarButtonBadge"] || [strClassName isEqualToString:@"_UIBadgeView"]) {
            [subview removeFromSuperview];
            
            break;
        }
    }
}

@end
