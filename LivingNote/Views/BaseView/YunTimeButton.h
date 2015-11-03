//
//  YunTimeButton.h
//  LivingNote
//
//  Created by xxy on 15/11/3.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YunTimeButton;

@protocol YunTimeButtonDelegate <NSObject>

- (void)yunTimeButtonClick:(YunTimeButton *)sender;

@end

@interface YunTimeButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame titleString:(NSString *)titleString timeCount:(NSInteger)timeCount;
/// 计时器
@property (nonatomic, strong) NSTimer *time;

/// 按钮标题
@property (nonatomic, copy) NSString *titleString;

/// 计时器启动时间
@property (nonatomic, assign) NSInteger timeCount;

@property (nonatomic, assign) id <YunTimeButtonDelegate> delegate;


@end
