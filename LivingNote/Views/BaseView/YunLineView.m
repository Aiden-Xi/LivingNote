//
//  YunLineView.m
//  LivingNote
//
//  Created by xxy on 15/10/20.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "YunLineView.h"

@implementation YunLineView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kLineHeight);
        self.backgroundColor = kGaryColor;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
