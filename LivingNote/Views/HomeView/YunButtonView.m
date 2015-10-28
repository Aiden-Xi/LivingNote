//
//  YunButtonView.m
//  LivingNote
//
//  Created by 席小雨 on 15/10/26.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "YunButtonView.h"

#import "UIButton+TJButtom.h"

@implementation YunButtonView

- (instancetype)initWithFrame:(CGSize)size imageName:(NSString *)imageName labelName:(NSString *)labelName index:(NSInteger)index {
    
    if (self = [super init]) {
        self.layer.borderColor = kLightGaryColor.CGColor;
        self.layer.borderWidth = kLineHeight / 1.5;
        
        self.backgroundColor = kWhiteColor;
        
        // 添加按钮
        CGFloat buttonWidth = size.width  / 2;
        CGFloat buttonHeight = size.height / 2;
        CGFloat labelWidth = size.width;
        CGFloat labelHeight = 20;
        
        CGFloat topSpace = (size.height - (buttonHeight + labelHeight)) / 2;
        CGFloat leftSpace = (size.width - buttonWidth) / 2;
        
        YunButton *centerButton = [[YunButton alloc] init];
        centerButton.backgroundColor = kClearColor;
        [centerButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [centerButton addTarget:self action:@selector(centerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 扩大点击范围
        [centerButton setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
        centerButton.tag = index;
        
        [self addSubview:centerButton];
        
        // 添加约束
        [centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(topSpace);
            make.width.mas_equalTo(buttonWidth);
            make.height.mas_equalTo(buttonHeight);
            make.left.equalTo(self).offset(leftSpace);
        }];
        
        // 添加标题
        YunLabel *titleLabel = [[YunLabel alloc] init];
        titleLabel.text = labelName;
        titleLabel.font = kSmallFont;
        titleLabel.textColor = kBlackColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:titleLabel];
        
        // 添加约束
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.width.mas_equalTo(labelWidth);
            make.height.mas_equalTo(labelHeight);
            make.bottom.equalTo(centerButton).offset((size.height - buttonHeight - labelHeight) / 2 + kSpace);
        }];
    }
    
    return self;
}

- (void)centerButtonClick:(YunButton *)sender {
    if ([self.delegate respondsToSelector:@selector(yunButtonViewClick:)]) {
        
        NSInteger index = sender.tag;
        
        [self.delegate yunButtonViewClick:index];
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
