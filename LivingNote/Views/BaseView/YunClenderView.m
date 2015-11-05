//
//  YunClenderView.m
//  LivingNote
//
//  Created by xxy on 15/11/4.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "YunClenderView.h"

#define kButtonWidth (kScreenWidth / 7)

#define kButtonHeight (kButtonWidth * 6 / 7)

#define isRunNian(year)  (year%400 == 0 || ( year%4 == 0 && year%100 !=0 ))

@interface YunClenderView()

/// 星期七天数组
@property (nonatomic, strong) NSArray *weekArray;
/// 本地时间日期
@property (nonatomic, copy) NSString *timeString;
/// 当前年
@property (nonatomic, assign) NSInteger year;
/// 当前月
@property (nonatomic, assign) NSInteger month;
/// 当前星期几
@property (nonatomic, copy) NSString *weekDay;

/// 本月一号对应星期几（前面需要的天数）
@property (nonatomic, assign) NSInteger formDayCount;
/// 本月最后一天对应的星期几（后面需要填补的天数）
@property (nonatomic, assign) NSInteger houDayCount;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSArray *runNianArray;

@property (nonatomic, strong) NSArray *unRunNianArray;

@property (nonatomic, strong) NSArray *runNianMonthDayArray;

@property (nonatomic, strong) NSArray *unRunNianMonthDayArray;

@end

@implementation YunClenderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _weekArray = @[@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sta"];
        
        _runNianArray = @[@1, @32, @61, @92, @122, @153, @183, @214, @245, @275, @306, @336];
        _unRunNianArray = @[@1, @32, @60, @91, @121, @152, @182, @213, @244, @274, @305, @335];
        _runNianMonthDayArray = @[@31, @29, @31, @30, @31, @30, @31, @31, @30, @31, @30, @31];
        _unRunNianMonthDayArray = @[@31, @28, @31, @30, @31, @30, @31, @31, @30, @31, @30, @31];
        
        _dataSource = [NSMutableArray arrayWithCapacity:0];
        
        [_dataSource addObject:_weekArray];
        
        //获得系统时间
        NSDate *senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        dateformatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss MMMM/dd/EEEE"];
        _timeString = [dateformatter stringFromDate:senddate];
        NSLog(@"now time string : %@", _timeString);
        
        _year = [[[_timeString componentsSeparatedByString:@"-"] firstObject] integerValue];
        _month = [[_timeString componentsSeparatedByString:@"-"][1] integerValue];
        /// 构造数据源
        [self clumWeekDay:_year month:_month];
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    // 根据日期的字符串判断日期的摆布
    self.backgroundColor = _backGroudColor ? _backGroudColor : kDefaultRedColor;
    
    // 根据本月1号对应的星期几 构建数据
    int weekDayCount = 0;
    
    for (int i = 0; i < _weekArray.count; i++) {
        if ([_weekDay isEqualToString:_weekArray[i]]) {
            weekDayCount = i;
        }
    }
    
    switch (weekDayCount) {
        case 0:
        {
            
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            break;
        }
        case 4:
        {
            break;
        }
        case 5:
        {
            break;
        }
        case 6:
        {
            break;
        }

        default:
            break;
    }
    
    
    
    
    
    
    
    
}

/**
 *  根据传入的字符串星期  转换成对应的英文星期
 *
 *  @param weekDay 传入的参数
 */
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

/**
 *  根据传入的年份和月份，计算出该月的一号是星期几
 *
 *  @param year  传入的年份
 *  @param month 传入的月份
 *
 *  @return 输出对应的该月一号是星期几
 */
- (void)clumWeekDay:(NSInteger)year month:(NSInteger)month {
    NSString *weekDay;
    //    算式：  S=X-1+[(X-1)/4] -[(X-1)/100] +[(X-1)/400]+C
    //    其中 x是公元的年数，C是从这一年的元旦算起到这一天为止（包括这一天是内）的天数。
    //    方括号表示其中算式的整数部分，即在计算S的值时，三个方括号中只要算出商数的整数部分，
    //    把余数略去不计。求出S的值之后，除以7，余几就是星期几；除尽了就是星期日。
    
    //    1.计算西安事变发生在星期几。
    //    解 西安事变发生在1936年12月12日，所以x=1936 C=347于是可得:
    //    S=1936-1+[(1936-1)/4] -[(1936-1)/100] +[(1936-1)/400]+347 =1935+483-19+4+347=2750  2750÷7=392………6，
    //    所以西安事变发生在星期六
    
    _year = year;
    _month = month;
    /// 该月的第一天在该年中第几天
    NSInteger dayCount;
    
    NSArray *runNianArray = @[@1, @32, @61, @92, @122, @153, @183, @214, @245, @275, @306, @336];
    NSArray *unRunNianArray = @[@1, @32, @60, @91, @121, @152, @182, @213, @244, @274, @305, @335];
    
    // 判断是否是闰年
    BOOL isRunNian = isRunNian(year);
    
    if (isRunNian) {
        dayCount = [runNianArray[month - 1] integerValue];
    } else {
        dayCount = [unRunNianArray[month - 1] integerValue];
    }
    
    int S = (year - 1 + (year - 1) / 4 - (year - 1) / 100 + (year - 1) / 400 + dayCount) % 7;
    
    weekDay = _weekArray[S];
    
    _weekDay = weekDay;
    
    /// 根据计算结果构造数据源
    /// 获取本月天数
    int monthDays = isRunNian(year) ? [_runNianMonthDayArray[month - 1] intValue] : [_unRunNianMonthDayArray[month - 1] intValue];
    switch (S) {
        case 0: // 星期日
        {
            for (int i = 0; i <= monthDays; i++) {
                
            }
            break;
        }
        case 1: // 星期一
        {
            break;
        }
        case 2: // 星期二
        {
            break;
        }
        case 3: // 星期三
        {
            break;
        }
        case 4: // 星期四
        {
            break;
        }
        case 5: // 星期五
        {
            break;
        }
        case 6: // 星期六
        {
            break;
        }
        default:
            break;
    }

}

- (void)makeDataSource {
    
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
