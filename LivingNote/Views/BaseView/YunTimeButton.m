//
//  YunTimeButton.m
//  LivingNote
//
//  Created by xxy on 15/11/3.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "YunTimeButton.h"

@implementation YunTimeButton
{
    NSString *buttonString;
    NSInteger timeStartCount;
}

@synthesize titleString = _titleString;
@synthesize timeCount = _timeCount;

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titleString:(NSString *)titleString timeCount:(NSInteger)timeCount {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR(167, 167, 167, 1);
        self.timeCount = timeCount>0 ? timeCount : 60;
        timeStartCount = timeCount ? timeCount : 60;
        _titleString = [NSString stringWithFormat:@"%@", titleString ? titleString : @"验证码"];
        self.alpha = 0.6;
        
        [[RACObserve(self, timeCount) filter:^BOOL(NSNumber *value) {
            NSLog(@"condition: %ld",value.integerValue);
            return value.integerValue == 0;
        }] subscribeNext:^(id x) {
            [self reactiveCocoaTest];
        }];
        
        [self autoCreateUI];
    }
    
    return self;
}

- (void)autoCreateUI {
    buttonString = [NSString stringWithFormat:@"%@: (%ld)", _titleString, _timeCount];
    [self setTitle:buttonString forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    
//    self.layer.borderColor = COLOR(223, 38, 67, 1).CGColor;
//    self.layer.borderWidth = 1.5;
//    
//    self.layer.cornerRadius = 2.5;
//    self.layer.masksToBounds = YES;
    
    [self addTarget:self action:@selector(timeStart) forControlEvents:UIControlEventTouchUpInside];
}

- (void)timeStart {
    [self removeTarget:self action:@selector(timeStart) forControlEvents:UIControlEventTouchUpInside];
    _timeCount = timeStartCount;
    
    _time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeCount) userInfo:nil repeats:YES];
}

- (void)updateTimeCount {
    XXYLog(@"090-9-90-9-090-9-");
    if (_timeCount > 0) {
        self.timeCount--;
        buttonString = [NSString stringWithFormat:@"%@: (%ld)", _titleString, _timeCount];
        [self setTitle:buttonString forState:UIControlStateNormal];
    }
}

- (void)reactiveCocoaTest {
    buttonString = [NSString stringWithFormat:@"%@: (%ld)", _titleString, _timeCount];
    [self setTitle:buttonString forState:UIControlStateNormal];
    [self addTarget:self action:@selector(timeStart) forControlEvents:UIControlEventTouchUpInside];
    
    [_time invalidate];
    
    if ([self respondsToSelector:@selector(yunTimeButtonClick:)]) {
        [self.delegate yunTimeButtonClick:self];
    }
}

@end
