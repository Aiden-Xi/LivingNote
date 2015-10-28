//
//  YunNavigationBarView.m
//  LivingNote
//
//  Created by xxy on 15/10/20.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "YunNavigationBarView.h"

#define kNavigationBarHeight 64

#define kItemWidth 30
#define kItemHeight 30
#define kBackTag 100
#define kLeftItemTag 1000
#define kRightItemTag 10000


@implementation YunNavigationBarView

/**
 *  初始化一个导航栏视图
 *
 *  @param isBack               是否添加返回按钮
 *  @param title                导航栏标题
 *  @param titleColor           标题颜色
 *  @param font                 字体
 *  @param leftItemsImageArray  添加左边按钮的图片数组
 *  @param rightItemsImageArray 添加右边按钮的图片数组
 *
 *  @return 返回一个导航栏视图
 */
- (instancetype)initWithTitle:(BOOL)isBack title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)font leftItemImageArray:(NSArray *)leftItemsImageArray rightItemsImageArray:(NSArray *)rightItemsImageArray {
    if (self = [super init]) {
        // 创建一个视图（导航栏视图）
        // 默认背景是白色的
        self.backgroundColor = kWhiteColor;
        
        // 添加标题
        YunLabel *titleLabel = [[YunLabel alloc] init];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        titleLabel.backgroundColor = kClearColor;
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = kBlackColor;  // 默认黑色字体
        
        if (titleColor) {
            titleLabel.textColor = titleColor;
        }
        
        titleLabel.font = kSizeBoldFont;  // 默认十八号字体
        if (font) {
            titleLabel.font = font;
        }
        
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(7);
//            make.width.mas_equalTo(@160);
            make.height.mas_equalTo(@30);
            make.left.equalTo(self).offset((kScreenWidth - 160) / 2);
            make.centerX.equalTo(self);
        }];
        
        // 判断是否添加返回按钮
        if (isBack == YES) {
            // 添加默认的返回按钮
            YunButton *backButton = [[YunButton alloc] init];
            [backButton setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
            [backButton addTarget:self action:@selector(navigationBarButtonClick:) forControlEvents:UIControlEventTouchDown];
            backButton.tag = kBackTag;
            
            [self addSubview:backButton];
            
            [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.and.height.mas_equalTo(@24);
                make.left.equalTo(self).offset(20);
                make.top.mas_equalTo(@30);
            }];
        }

        CGFloat itemY = 20 + (44 - kItemHeight) / 2;
        
        if (rightItemsImageArray.count > 0) {  // 添加按钮
            for (int i = 0; i < rightItemsImageArray.count; i++) {
                CGFloat itemX = 10 + (kItemWidth + kSpace) * i;
                YunButton *itemButton = [[YunButton alloc] init];
                itemButton.tag = (i + 1) * kRightItemTag;
                itemButton.backgroundColor = kClearColor;
                [itemButton setImage:[UIImage imageNamed:rightItemsImageArray[i]] forState:UIControlStateNormal];
                [itemButton addTarget:self action:@selector(navigationBarButtonClick:) forControlEvents:UIControlEventTouchDown];

                [self addSubview:itemButton];
                
                [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.and.height.mas_equalTo(kItemWidth);
                    make.right.equalTo(self).offset(-itemX);
                    make.top.equalTo(self).offset(itemY);
                }];
            }
        }
        
        if (leftItemsImageArray.count > 0) {
            for (int i = 0; i < leftItemsImageArray.count; i++) {
                CGFloat itemX = kDoubleSpace + i * (kItemWidth + kSpace);
                YunButton *leftItemButton = [[YunButton alloc] init];
                leftItemButton.tag = (i + 1) * kLeftItemTag;
                leftItemButton.backgroundColor = kClearColor;
                [leftItemButton setImage:[UIImage imageNamed:leftItemsImageArray[i]] forState:UIControlStateNormal];
                [leftItemButton addTarget:self action:@selector(navigationBarButtonClick:) forControlEvents:UIControlEventTouchDown];
                
                [self addSubview:leftItemButton];
                
                [leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.and.height.mas_equalTo(kItemWidth);
                    make.left.equalTo(self).offset(itemX);
                    make.top.equalTo(self).offset(itemY);
                }];
            }
        }
        
        // 添加分割线
        YunLineView *lineView = [[YunLineView alloc] init];
        
        [self addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.width.mas_equalTo(self.mas_width);
            make.bottom.equalTo(self).offset(-kLineHeight);
            make.height.mas_equalTo(kLineHeight);
        }];
    }
    
    return self;
}

- (void)navigationBarButtonClick:(YunButton *)sender {
    if ([self.delegate respondsToSelector:@selector(YunNavigationBarViewClickButton:index:)]) {
        [self.delegate YunNavigationBarViewClickButton:sender index:(int)(sender.tag / kBackTag)];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
