//
//  GuideViewController.m
//  Shops-iPhone
//
//  Created by rujax on 14-2-14.
//  Copyright (c) 2014年 net.atyun. All rights reserved.
//

#import "GuideViewController.h"

// Classes
#import "AppDelegate.h"

#import "TAPageRealControl.h"

#define kIconWidthHeight 40
#define kTag 100

@interface GuideViewController () <UIScrollViewDelegate/*, UIScrollViewDelegate, UIGestureRecognizerDelegate*/>

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, strong) NSArray *imageNameArray;

@property (nonatomic, strong) TAPageRealControl *pageControl;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) YunButton *enterBtn;

@end

@implementation GuideViewController

#pragma mark - Initialization -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

#pragma mark - UIView Functions -

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 设置透明导航栏
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        NSArray *list = self.navigationController.navigationBar.subviews;
        
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)obj;
                imageView.alpha = 0.0;
            }
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        
        imageView.image = [UIImage imageNamed:@"navigation_bar_background"];
        
        [self.navigationController.navigationBar addSubview:imageView];
        
        [self.navigationController.navigationBar sendSubviewToBack:imageView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    //    [TalkingData trackPageEnd:@"离开注册页面"];
    
    [super viewWillDisappear:animated];
    
    NSArray *list=self.navigationController.navigationBar.subviews;
    
    for (id obj in list) {
        
        if ([obj isKindOfClass:[UIImageView class]]) {
            
            UIImageView *imageView=(UIImageView *)obj;
            [UIView animateWithDuration:0.01 animations:^{
                imageView.alpha = 1.0;
            }];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.view.backgroundColor = kWhiteColor;
    
    //    UIImage *imageOne;
    //
    //    if (kIsiPhone) {
    //        if (kScreenHeight > 480) {
    //            imageOne = [UIImage imageNamed:@"guide_one_iphone6"];
    //        } else {
    //            imageOne = [UIImage imageNamed:@"guide_one_iphone4"];
    //        }
    //
    //    } else {
    //        imageOne = [UIImage imageNamed:@"guide_one_ipad"];
    //    }
    //
    ////    MYIntroductionPanel *panelOne = [[MYIntroductionPanel alloc] initWithFrame:kScreenBounds
    ////                                                                         title:@"买家/卖家 随心切换"
    ////                                                                   description:@"功能界面全新升级 给您心地管理体验"
    ////                                                                         image:imageOne];
    //    MYIntroductionPanel *panelOne = [[MYIntroductionPanel alloc] initWithFrame:kScreenBounds
    //                                                                         title:@""
    //                                                                   description:@""
    //                                                                         image:imageOne];
    //
    //    UIImage *imageTwo;
    //
    //    if (kIsiPhone) {
    //        if (kScreenHeight > 480) {
    //            imageTwo = [UIImage imageNamed:@"guide_two_iphone6"];
    //        } else {
    //            imageTwo = [UIImage imageNamed:@"guide_one_iphone4"];
    //        }
    //    } else {
    //        imageTwo = [UIImage imageNamed:@"guide_two_ipad"];
    //    }
    //
    //    MYIntroductionPanel *panelTwo = [[MYIntroductionPanel alloc] initWithFrame:kScreenBounds
    //                                                                         title:@""
    //                                                                   description:@""
    //                                                                         image:imageTwo];
    //    UIImage *imageThree;
    //
    //    if (kIsiPhone) {
    //        if (kScreenHeight > 480) {
    //            imageThree = [UIImage imageNamed:@"guide_three_iphone6"];
    //        } else {
    //            imageThree = [UIImage imageNamed:@"guide_one_iphone4"];
    //        }
    //    } else {
    //        imageThree = [UIImage imageNamed:@"guide_three_ipad"];
    //    }
    //
    //    MYIntroductionPanel *panelThree = [[MYIntroductionPanel alloc] initWithFrame:kScreenBounds
    //                                                                           title:@""
    //                                                                     description:@""
    //                                                                           image:imageThree];
    //    UIImage *imageFour;
    //
    //    if (kIsiPhone) {
    //        if (kScreenHeight > 480) {
    //            imageFour = [UIImage imageNamed:@"guide_four_iphone6"];
    //        } else {
    //            imageFour = [UIImage imageNamed:@"guide_one_iphone4"];
    //        }
    //    } else {
    //        imageFour = [UIImage imageNamed:@"guide_four_ipad"];
    //    }
    //
    //    MYIntroductionPanel *panelFour = [[MYIntroductionPanel alloc] initWithFrame:kScreenBounds
    //                                                                          title:@""
    //                                                                    description:@""
    //                                                                          image:imageFour];
    //
    //    UIImage *imageFive;
    //
    //    if (kIsiPhone) {
    //        if (kScreenHeight > 480) {
    //            imageFive = [UIImage imageNamed:@"guide_five_iphone6"];
    //        } else {
    //            imageFive = [UIImage imageNamed:@"guide_one_iphone4"];
    //        }
    //    } else {
    //        imageFive = [UIImage imageNamed:@"guide_five_ipad"];
    //    }
    //
    //    MYIntroductionPanel *panelFive = [[MYIntroductionPanel alloc] initWithFrame:kScreenBounds
    //                                                                          title:@""
    //                                                                    description:@""
    //                                                                          image:imageFive];
    //
    //    NSArray *panels = @[panelOne, panelTwo, panelThree, panelFour, panelFive];
    //
    //    MYBlurIntroductionView *introView = [[MYBlurIntroductionView alloc] initWithFrame:kScreenBounds];
    //    introView.delegate = self;
    //   [introView setBackgroundColor:kWhiteColor];
    //
    //    [introView buildIntroductionWithPanels:panels];
    //
    //    [self.view addSubview:introView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationBarHidden = YES;
    
    [self createPageView];
}

// ------------------------------------------------------------------------------------------
- (void)createPageView
{
    NSArray *imageNameArray = [NSArray array];
    
    if (kIsiPhone) {
        if (kScreenHeight > 480) {
            imageNameArray = @[@"guide_one_iphone6", @"guide_two_iphone6", @"guide_three_iphone6", @"guide_four_iphone6", @"guide_five_iphone6"];
        } else {
            imageNameArray = @[@"guide_one_iphone4", @"guide_two_iphone4", @"guide_three_iphone4", @"guide_four_iphone4", @"guide_five_iphone4"];
        }
    } else {
        imageNameArray = @[@"guide_one_ipad", @"guide_two_ipad", @"guide_three_ipad", @"guide_four_ipad", @"guide_five_ipad"];
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];

    _scrollView.contentSize = CGSizeMake(imageNameArray.count * kScreenWidth, kScreenHeight);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < imageNameArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight)];
        imageView.image = [UIImage imageNamed:imageNameArray[i]];
        
        [_scrollView addSubview:imageView];
    }
    
    _pageControl = [[TAPageRealControl alloc] initWithFrame:CGRectMake((kScreenWidth - 120) / 2, kScreenHeight - 44, 120, 44)];
    
    _pageControl.numberOfPages = imageNameArray.count;
    _pageControl.dotColor = [UIColor whiteColor];
    [_pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:_pageControl];

    // 进入首页
    _enterBtn = [[YunButton alloc] initWithFrame:CGRectMake(kScreenWidth - 80, kScreenHeight - 40, 80, 40)];
    
    _enterBtn.backgroundColor = [UIColor clearColor];
    [_enterBtn setTitle:@"进入首页" forState:UIControlStateNormal];
    _enterBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_enterBtn addTarget:self action:@selector(enterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_enterBtn];
}

- (void)enterBtnClick
{
    static dispatch_once_t enterHome;
    
    dispatch_once(&enterHome, ^{
        NSLog(@"enter homeView");
        
        AppDelegate *appDelegate = kAppDelegate;
        
        
        if (appDelegate.isLogin)
        {
            
        }
    });
}

//然后是点击UIPageControl时的响应函数pageTurn

- (void)pageTurn:(UIPageControl*)sender
{
    XXYLog(@"sender.currentPage = %ld", (long)sender.currentPage);
    
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = _scrollView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    
    [_scrollView scrollRectToVisible:rect animated:YES];
    
    if (sender.currentPage == 4) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self enterBtnClick];
        });
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [_pageControl setCurrentPage:offset.x / bounds.size.width];
    [_pageControl sizeForNumberOfPages:offset.x / bounds.size.width];
    
    if ((offset.x / bounds.size.width) == 4) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self enterBtnClick];
        });
    }
    NSLog(@"%f",offset.x / bounds.size.width);
}

// ------------------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_scrollView endEditing:YES];
}

#pragma mark - Touch -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_scrollView endEditing:YES];
}

@end
