//
//  CalenderViewController.m
//  LivingNote
//
//  Created by xxy on 15/11/4.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "CalenderViewController.h"
#import "YunClenderView.h"

@interface CalenderViewController () <YunClenderViewDelegate>

@property (nonatomic,  strong) YunClenderView *clenderView;

@end

@implementation CalenderViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _clenderView = [[YunClenderView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 300)];
    _clenderView.backGroudColor = kDefaultRedColor;
    _clenderView.titleFont = kNormalFont;
    _clenderView.titleColor = kWhiteColor;
    _clenderView.delegate = self;
   
    [self.view addSubview:_clenderView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - YunClenderViewDelegate - 

- (void)updateMonth:(NSString *)timeString {

}

- (void)dayButtonClick:(YunButton *)sender {
    
}
@end
