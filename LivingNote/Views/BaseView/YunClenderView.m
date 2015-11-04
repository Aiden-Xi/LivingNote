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

/// 星期七天数组
@property (nonatomic, strong) NSArray *weekArray;
/// 本地时间日期
@property (nonatomic, copy) NSString *timeString;
/// 当前年
@property (nonatomic, copy) NSString *year;
/// 当前月
@property (nonatomic, copy) NSString *month;
/// 当前星期几
@property (nonatomic, copy) NSString *weekDay;

/// 本月一号对应星期几（前面需要的天数）
@property (nonatomic, assign) NSInteger formDayCount;
/// 本月最后一天对应的星期几（后面需要填补的天数）
@property (nonatomic, assign) NSInteger houDayCount;




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
    
    _year = [[_timeString componentsSeparatedByString:@"-"] firstObject];
    _month = [_timeString componentsSeparatedByString:@"-"][1];
    _weekDay =  [self weekDayChinaChangeEnglish:[[_timeString componentsSeparatedByString:@"/"] lastObject]];
    
    
    
    
}

- (NSString *)weekDayChinaChangeEnglish:(NSString *)weekDay {
    NSString *engWeekDay;
    
    if ([weekDay isEqualToString:@"星期一"]) {
        engWeekDay = _weekArray[1];
    } else if ([weekDay isEqualToString:@"星期二"]) {
        engWeekDay = _weekArray[2];
    }else if ([weekDay isEqualToString:@"星期三"]) {
        engWeekDay = _weekArray[3];
    }else if ([weekDay isEqualToString:@"星期四"]) {
        engWeekDay = _weekArray[4];
    }else if ([weekDay isEqualToString:@"星期五"]) {
        engWeekDay = _weekArray[5];
    }else if ([weekDay isEqualToString:@"星期六"]) {
        engWeekDay = _weekArray[6];
    } else {
        engWeekDay = _weekArray[0];
    }
    
    return engWeekDay;
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
