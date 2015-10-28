//
//  YunSearchTextField.m
//  LivingNote
//
//  Created by xxy on 15/10/21.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "YunSearchTextField.h"

@implementation YunSearchTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        YunButton *leftButton = [[YunButton alloc] init];
        leftButton.backgroundColor = kOrangeColor;
        [leftButton setTitle:@"商品" forState:UIControlStateNormal];
        leftButton.titleLabel.font = kNormalFont;
        [leftButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        leftButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [leftButton addTarget:self action:@selector(pressLeft) forControlEvents:UIControlEventTouchDown];
        leftButton.tag = 1001;

        [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        
        [leftButton setImage:[UIImage imageNamed:@"search_down"] forState:UIControlStateNormal];
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -70)];
        
        [self addSubview:leftButton];
        
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(60);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = kOrangeColor.CGColor;
        self.layer.borderWidth = 1.0;
        
        self.backgroundColor = [UIColor whiteColor];
        self.font = [UIFont fontWithName:kLetterFamily size:14];
        //self.borderStyle = UITextBorderStyleBezel;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.returnKeyType = UIReturnKeySearch;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.textColor = [UIColor orangeColor];
        self.placeholder = @"请输入搜索内容";
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

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    if (kDeviceOSVersion < 7.0) {
        return CGRectMake(bounds.origin.x + 65, bounds.origin.y + (bounds.size.height - 30) / 2, bounds.size.width, bounds.size.height);
    } else {
        return CGRectMake(bounds.origin.x + 65, bounds.origin.y + (bounds.size.height - 20) / 2, bounds.size.width, bounds.size.height);
    }
    
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    [self.placeholder drawInRect:rect withAttributes:@{NSFontAttributeName:kNormalBoldFont,NSForegroundColorAttributeName:[UIColor orangeColor]}];
    
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + 65, bounds.origin.y, bounds.size.width - 80, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + 65, bounds.origin.y, bounds.size.width - 80, bounds.size.height);
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 0, 60, bounds.size.height);
}

- (UITextFieldViewMode)leftViewMode
{
    return UITextFieldViewModeAlways;
}

- (void)pressLeft
{
    if ([self.searchDelegate respondsToSelector:@selector(YunSearchTextFieldClick:)]) {
        [self.searchDelegate YunSearchTextFieldClick:self];
    }
}

@end
