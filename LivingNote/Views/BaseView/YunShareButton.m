//
//  YunShareButton.m
//  Shops-iPhone
//
//  Created by Tsao Jiaxin on 15/7/28.
//  Copyright (c) 2015年 net.atyun. All rights reserved.
//

#import "YunShareButton.h"


@implementation YunShareTransparentButton

@end

@implementation YunShareButton

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        CGFloat padding = frame.size.width *0.1;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - padding * 2, frame.size.width - padding * 2)];
        imageView.image = image;
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.center = CGPointMake(frame.size.width * 0.5, padding + imageView.frame.size.width * 0.5);
        [self addSubview:imageView];
        imageView.layer.cornerRadius = 10.0;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - padding - imageView.frame.size.height)];
        titleLabel.center = CGPointMake(frame.size.width * 0.5, frame.size.height - 0.60 * titleLabel.frame.size.height);
        titleLabel.text = title;
        [titleLabel setFont:[UIFont fontWithName:kFontFamily size:kFontSmallMoreSize]];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setTextColor:[UIColor grayColor]];
        [self addSubview:titleLabel];
        
        YunShareTransparentButton *button = [[YunShareTransparentButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:button];
        self.transparentButton = button;
        
    }
    return self;
}

- (void)setSection:(NSUInteger)section{
    _section = section;
    self.transparentButton.section = section;
}

- (void)setIndex:(NSUInteger)index{
    _index = index;
    self.transparentButton.index = index;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
