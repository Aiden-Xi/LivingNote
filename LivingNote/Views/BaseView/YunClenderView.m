//
//  YunClenderView.m
//  LivingNote
//
//  Created by xxy on 15/11/4.
//  Copyright © 2015年 AtYun. All rights reserved.
//

//NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
//
//inputFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//
//[inputFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
//
//
//NSDate *formatterDate = [inputFormatter dateFromString:@"1999-07-11 at 10:30"];
//
//NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//
//[outputFormatter setDateFormat:@"HH:mm 'on' EEEE MMMM d"];
//
//NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
//
//NSLog(@"newDateString %@", newDateString);

#import "YunClenderView.h"

#define kButtonWidth (kScreenWidth / 7)

#define kButtonHeight (kButtonWidth * 6 / 7)

@interface YunClenderView()

@property (nonatomic, strong) NSArray *weekArray;

@property (nonatomic, copy) NSString *timeString;

@end

@implementation YunClenderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _weekArray = @[@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sta"];
        
        //获得系统时间
        NSDate *senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        dateformatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss MMMM/dd/EEEE"];
        _timeString = [dateformatter stringFromDate:senddate];
        NSLog(@"now time string : %@", _timeString);
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    // 根据日期的字符串判断日期的摆布
    self.backgroundColor = _backGroudColor ? _backGroudColor : kDefaultRedColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
}

- (void)setBackGroudColor:(UIColor *)backGroudColor {
    _backGroudColor = backGroudColor;
}

- (void)setSelectedButtonGroudColor:(UIColor *)selectedButtonGroudColor {
    _selectedButtonGroudColor = selectedButtonGroudColor;
}



@end
