//
//  YunShareView.m
//  Shops-iPhone
//
//  Created by Tsao Jiaxin on 15/7/28.
//  Copyright (c) 2015年 net.atyun. All rights reserved.
//

#import "YunShareView.h"
#import "YunShareButton.h"
#import "KLCPopup.h"

#define kcancelButtonHeight 44

@interface YunShareView ()

@property (nonatomic, strong) NSArray *topBarItems;

@property (nonatomic, strong) NSArray *bottomBarItems;

/// 顶部滑动条
@property (nonatomic, weak) UIScrollView *topBar;
/// 底部滑动条
@property (nonatomic, weak) UIScrollView *bottomBar;

/// 取消按钮
@property (nonatomic, weak) UIButton *cancelButton;

/// 左上角的提示label
@property (nonatomic, weak) UILabel *tipLabel;

@end

@implementation YunShareView

/**
 初始化一个分享控件
 
 @param topBarItems    第一行按钮数据(包含图标和标题，如@[@{@"icon" : @"weixinicon",@"title" : @"微信"}])
 @param bottomBarItems 同topBarItems,为第二排按钮,此参数可为nil,则只显示一排按钮
 
 @return 分享控件的实例
 */
- (instancetype)initWithTopBar:(NSArray *)topBarItems bottomBar:(NSArray *)bottomBarItems
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.99];
        
        /// 最外部View的高度
        CGFloat height = (kScreenHeight - kcancelButtonHeight) * 0.5 + kcancelButtonHeight;
        
        /// 两排按钮的高度
        CGFloat buttonBarHeight = (height - kcancelButtonHeight - 1 - 50) * 0.5;
        
        self.frame = CGRectMake(0, 0, kScreenWidth, height);
        
        UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
        shareView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
        [self addSubview:shareView];

        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, kScreenWidth, 40)];
        title.text = @"分享到";
        title.font = [UIFont fontWithName:kFontFamily size:kFontSmallSize];
        self.tipLabel = title;
        [shareView addSubview:title];

        /// 第一排按钮bar
        UIScrollView *firstBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, buttonBarHeight)];
        //firstBar.backgroundColor = [UIColor redColor];
        self.topBar = firstBar;
        
        [shareView addSubview:firstBar];
        
        /// 第二排按钮bar
        UIScrollView *secondBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(firstBar.frame), kScreenWidth, buttonBarHeight)];
        //secondBar.backgroundColor = [UIColor greenColor];
        self.bottomBar = secondBar;
        
        [shareView addSubview:secondBar];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, height - kcancelButtonHeight, kScreenWidth, kcancelButtonHeight)];
        cancelButton.backgroundColor = [UIColor whiteColor];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [[cancelButton titleLabel] setFont:[UIFont fontWithName:kFontFamily size:kFontNormalSize]];
        [cancelButton addTarget:self action:@selector(dismissKCL) forControlEvents:UIControlEventTouchUpInside];
        
        self.cancelButton = cancelButton;
        
        [shareView addSubview:cancelButton];
        
        self.topBarItems = topBarItems;
        self.bottomBarItems = bottomBarItems;
    }
    return self;
}

- (void)setTopBarItems:(NSArray *)topBarItems
{
    _topBarItems = topBarItems;
    
    CGFloat itemWidth = self.topBar.frame.size.width * 0.22;
    
    __block CGFloat currentOffsetX = 0;
    __weak typeof(self) weakSelf = self;
    [topBarItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        YunShareButton *shareButton = [[YunShareButton alloc] initWithFrame:CGRectMake(currentOffsetX, 0, itemWidth, self.topBar.frame.size.height) image:[UIImage imageNamed:[obj objectForKey:@"icon"]] title:[obj objectForKey:@"title"]];
        
        shareButton.section = 0;
        shareButton.index = idx;
        
        [self.topBar addSubview:shareButton];
        
        currentOffsetX += itemWidth;
        
        [weakSelf.topBar setContentSize:CGSizeMake(currentOffsetX, self.topBar.frame.size.height)];
        
        [shareButton.transparentButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [self.topBar setContentInset:UIEdgeInsetsMake(0, 10, 0, 10)];
}

- (void)setBottomBarItems:(NSArray *)bottomBarItems
{
    _bottomBarItems = bottomBarItems;
    
    CGFloat height = (kScreenHeight - kcancelButtonHeight) * 0.5 + kcancelButtonHeight;
    /// 两排按钮的高度
    CGFloat buttonBarHeight = (height - kcancelButtonHeight - 1 - 50) * 0.5;

    if (bottomBarItems == nil || bottomBarItems.count < 1) {
        self.frame = CGRectMake(0, 0, kScreenWidth, height - buttonBarHeight);
        self.cancelButton.frame = CGRectMake(0, height - buttonBarHeight - kcancelButtonHeight, kScreenWidth, kcancelButtonHeight);
    }
    else {
        CGFloat itemWidth = self.bottomBar.frame.size.width * 0.22;
        __block CGFloat currentOffsetX = 0;
        __weak typeof(self) weakSelf = self;

        [bottomBarItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            YunShareButton *shareButton = [[YunShareButton alloc] initWithFrame:CGRectMake(currentOffsetX, 0, itemWidth, self.topBar.frame.size.height) image:[UIImage imageNamed:[obj objectForKey:@"icon"]] title:[obj objectForKey:@"title"]];
            
            shareButton.section = 1;
            shareButton.index = idx;
            
            [self.bottomBar addSubview:shareButton];
            
            currentOffsetX += itemWidth;
            
            [weakSelf.bottomBar setContentSize:CGSizeMake(currentOffsetX, self.bottomBar.frame.size.height)];
            
            [shareButton.transparentButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];

        }];
        [self.bottomBar setContentInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
}

- (void)setTip:(NSString *)tip
{
    _tip = tip;
    [self.tipLabel setText:tip];
}

- (void)clickButton:(YunShareTransparentButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(shareViewDidSelectView:inSection:index:)]) {
        [self.delegate shareViewDidSelectView:self inSection:sender.section index:sender.index];
    }
    [self dismissKCL];
}

/**
 解除PopUpView
 */
- (void)dismissKCL
{
    [self dismissPresentingPopup];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
