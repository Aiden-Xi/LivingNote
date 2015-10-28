//
//  YunShareButton.h
//  Shops-iPhone
//
//  Created by Tsao Jiaxin on 15/7/28.
//  Copyright (c) 2015年 net.atyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YunShareTransparentButton : UIButton

/// 按钮所在行中的索引号，如从左到右第一个按钮则为0，第二个为1
@property (nonatomic, assign) NSUInteger index;

/// 按钮所在的滑动条的索引号，最上面的滑动条section为0,下面的为1
@property (nonatomic, assign) NSUInteger section;

@end

@interface YunShareButton : UIView

/// 按钮所在行中的索引号，如从左到右第一个按钮则为0，第二个为1
@property (nonatomic, assign) NSUInteger index;

/// 按钮所在的滑动条的索引号，最上面的滑动条section为0,下面的为1
@property (nonatomic, assign) NSUInteger section;

/// 透明的覆盖在图标上的按钮用于获取点击事件
@property (nonatomic, weak) YunShareTransparentButton *transparentButton;

/**
 初始化一个新的分享按钮
 
 @param frame 控件尺寸及坐标
 @param image 按钮图标(80x80,@2x)
 @param title 按钮文字说明
 
 @return 初始化后的按钮
 */
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title;
@end
