//
//  YunButtonView.h
//  LivingNote
//
//  Created by 席小雨 on 15/10/26.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YunButtonView;

@protocol YunButtonViewDelegate <NSObject>

- (void)yunButtonViewClick:(NSInteger)indexTag;

@end

@interface YunButtonView : UIView

- (instancetype)initWithFrame:(CGSize)size imageName:(NSString *)imageName labelName:(NSString *)labelName index:(NSInteger)index;

@property (nonatomic, assign) id <YunButtonViewDelegate> delegate;

@end
