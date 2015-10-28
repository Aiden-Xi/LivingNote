//
//  YunShareView.h
//  Shops-iPhone
//
//  Created by Tsao Jiaxin on 15/7/28.
//  Copyright (c) 2015年 net.atyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YunShareView;

@protocol YunShareViewDelegate <NSObject>

/**
 当用户点击按钮之后,触发此方法
 
 @param section 按钮所在的section
 @param index   按钮所在的index
 */
- (void)shareViewDidSelectView:(YunShareView *)shareView inSection:(NSUInteger)section index:(NSUInteger)index;

@end

@interface YunShareView : UIView

/// 代表左上角的提示语，默认为:"分享到"
@property (nonatomic, copy) NSString *tip;

/// YunShareView的代理,用于获取按钮点击事件
@property (nonatomic, assign) id<YunShareViewDelegate> delegate;

- (instancetype)initWithTopBar:(NSArray *)topBarItems bottomBar:(NSArray *)bottomBarItems;

@end
