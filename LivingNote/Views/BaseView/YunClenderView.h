//
//  YunClenderView.h
//  LivingNote
//
//  Created by xxy on 15/11/4.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YunButton.h"

@class YunClenderView;

@protocol YunClenderViewDelegate <NSObject>

/**
 *  替换月份， 更改视图的布局
 *
 *  @param timeString 传入的年月时间字符串
 */
- (void)updateMonth:(NSString *)timeString;


- (void)dayButtonClick:(YunButton *)sender;

@end

@interface YunClenderView : UIView

@property (nonatomic, strong) UIColor *backGroudColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *selectedButtonGroudColor;

/**
 *  视图初始化
 *
 *  @param frame      传入的farme
 *  @param timeString 传入的时间字符串（如果不穿入，则默认是当前时间）
 */
- (instancetype)initWithFrame:(CGRect)frame;

- (void)clumWeekDay:(NSInteger)year month:(NSInteger)month;

@property (nonatomic, assign) id <YunClenderViewDelegate> delegate;

@end
