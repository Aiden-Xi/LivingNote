//
//  YunNavigationBarView.h
//  LivingNote
//
//  Created by xxy on 15/10/20.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YunButton.h"

@protocol YunNavigationBarViewDelegate <NSObject>

- (void)YunNavigationBarViewClickButton:(YunButton *)sender index:(int)index;

@end

@interface YunNavigationBarView : UIView

- (instancetype)initWithTitle:(BOOL)isBack title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font leftItemImageArray:(NSArray *)leftItemsImageArray rightItemsImageArray:(NSArray *)rightItemsImageArray;

@property (nonatomic, assign) id <YunNavigationBarViewDelegate> delegate;

@end
