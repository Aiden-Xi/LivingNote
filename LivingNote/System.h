//
//  System.h
//  LivingNote
//
//  Created by xxy on 15/10/16.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#ifndef System_h
#define System_h

/// Libraries
#import "AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Extend.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import <Masonry.h>
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "BaseViewController.h"
#import "Tool.h"
#import <ReactiveCocoa.h>
#import <MJExtension.h>
#import "AFHTTPRequestOperationManager+Singleton.h"
#import <PNChart.h>
#import "UICountingLabel.h"
#import "SDCycleScrollView.h"
#import "KKNavigationController.h"

/// Categories
#import "NSDictionary+safeObjectForKey.h"

/// Classess
#import "YunButton.h"
#import "YunLabel.h"

/// Models
#import "UserModel.h"

/// Views
#import "YunNavigationBarView.h"
#import "YunLineView.h"

#import "AppDelegate.h"

#pragma mark - Debug -

#ifdef DEBUG

#define XXYLog(fmt, ...)   NSLog((@"\n%s [Line %u]:\n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#define XXYLog(fmt, ...)

#endif


#pragma mark - Base Setting -

#pragma mark - Device -

#define kIntfRevision                       @"2.2"

#define kAppVersion                         [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]
#define kAppBuild                           [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]

#define kDeviceOSVersion                    [[[UIDevice currentDevice] systemVersion] floatValue]

#define kIsiPhone                           [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#pragma mark - Space -

#define kSpace                              5
#define kDoubleSpace                        10

#pragma mark - Error Code -

#define kSuccessCode                        20000
#define kSignatureInvalidCode               40300
#define kTerminalSessionKeyInvalidCode      40301
#define kUserSessionKeyInvalidCode          40302
#define kOtherErrorCode                     50000

#define kGetResponseCode(responseObject)    [[[responseObject objectForKey:@"status"] objectForKey:@"code"] integerValue]
#define kGetResponseMessage(responseObject) [[responseObject objectForKey:@"status"] objectForKey:@"message"]
#define kGetResponseData(responseObject)    [responseObject objectForKey:@"data"]

#define kCustomNaviHeight                   (kDeviceOSVersion >= 7.0 ? 64 : 0)
#define kNavTabBarHeight                    64

#define kNullToString(str)                  ([str isEqual:[NSNull null]] || str == nil) ? @"" : str
#define kNullToArray(arr)                   ([arr isEqual:[NSNull null]] || arr == nil) ? @[] : arr
#define kNullToDictionary(dic)              ([dic isEqual:[NSNull null]] || dic == nil) ? @{} : dic

#define kScreenBounds                       ([[UIScreen mainScreen] bounds])
#define kScreenWidth                        ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight                       ([[UIScreen mainScreen] bounds].size.height)
#define kScreenSize                         CGSizeMake(kScreenWidth, kScreenHeight)
#define kLineHeight                         (1 / [UIScreen mainScreen].scale)
#define KProportionForWidth                  kScreenWidth/375
#define KProportionForHeight                 kScreenHeight/667

#define kLetterFamily                       @"HelveticaNeue"
#define kFontFamily                         @"HelveticaNeue"
#define kFontBold                           @"HelveticaNeue-Bold"

#define kFontLangeBigSize                   30
#define kFontLargeSize                      24
#define kFontBigSize                        20
#define kFontSize                           18
#define kFontNormalSize                     16
#define kFontMidSize                        14
#define kFontSmallSize                      12
#define kFontSmallMoreSize                  10

#define kLargeFont                          [UIFont fontWithName:kFontFamily size:kFontLargeSize]
#define kBigFont                            [UIFont fontWithName:kFontFamily size:kFontBigSize]
#define kFont                               [UIFont fontWithName:kFontFamily size:kFontSize]
#define kNormalFont                         [UIFont fontWithName:kFontFamily size:kFontNormalSize]
#define kMidFont                            [UIFont fontWithName:kFontFamily size:kFontMidSize]
#define kSmallFont                          [UIFont fontWithName:kFontFamily size:kFontSmallSize]
#define kSizeFont                           [UIFont fontWithName:kFontFamily size:kFontSize]
#define kMidSizeFont                        [UIFont fontWithName:kFontFamily size:kFontMidSize]
#define kSmallMoreSizeFont                  [UIFont fontWithName:kFontFamily size:kFontSmallMoreSize]

#define kLargeBoldFont                      [UIFont fontWithName:kFontBold size:kFontLargeSize]
#define kBigBoldFont                        [UIFont fontWithName:kFontBold size:kFontBigSize]
#define kNormalBoldFont                     [UIFont fontWithName:kFontBold size:kFontNormalSize]
#define kMidBoldFont                        [UIFont fontWithName:kFontBold size:kFontMidSize]
#define kSmallBoldFont                      [UIFont fontWithName:kFontBold size:kFontSmallSize]
#define kSizeBoldFont                       [UIFont fontWithName:kFontBold size:kFontSize]

#define COLOR(r, g, b, a)                   [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:(a * 1.0)]

#define ColorFromRGB(rgbValue)              [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ColorWithAlphaFromRGB(rgbValue,a)              [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a];

#pragma mark - Color -

#define kRedColor                           [UIColor redColor]
#define kLightGaryColor                     COLOR(243, 244, 245, 1)
#define kGaryColor                          [UIColor grayColor]
#define kGreenColor                         [UIColor greenColor]
#define kOrangeColor                        [UIColor orangeColor]
#define kWhiteColor                         [UIColor whiteColor]
#define kBlackColor                         [UIColor blackColor]
#define kBlueColor                          [UIColor blueColor]
#define kClearColor                         [UIColor clearColor]
#define kLightWhiteColor                    COLOR(250, 250, 250, 0.5)
#define kDefaultRedColor                    COLOR(216, 72, 89, 1)
#define kNaviTitleColor                     ColorWithAlphaFromRGB(0x1d1d26, 0.85)
#define kGrayFontColor                      ColorWithAlphaFromRGB(0x282828,0.5)

#pragma mark - API URL -Oshoplis

// base url
#define kRequestHost                        @"http://api.shop.yundianjia.com"
//#define kRequestHost                      @"http://api.shop.sit.yundianjia.net"

#define kPublic                             @"/public"

#define kRequestHostWithPublic              [NSString stringWithFormat:@"%@%@", kRequestHost, kPublic]

#define kAPIVersion1                        @"/api/v1"
#define kAPIVersion1WithShops               @"/api/shops/v1"
#define kAPIVersion2                        @"/api/v2"
#define kAPIVersion2WithShops               @"/api/shops/v2"


#define kHomeBannerURL                      @"/home/top_banner.json"


#pragma mark - 系统原生单例 -

#define kApplication                        [UIApplication sharedApplication]
#define kAppDelegate                        (AppDelegate *)[UIApplication sharedApplication].delegate
#define kUserDefaults                       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter                 [NSNotificationCenter defaultCenter]
#define kLivingNoteStoryBoard               (UIStoryboard *)[UIStoryboard storyboardWithName:@"LivingNote" bundle:nil]
#define kLoginRegisterStoryBoard            (UIStoryboard *)[UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil]

#endif
