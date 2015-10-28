//
//  Tool.h
//  GuduMorning
//
//  Created by Tsao on 15/8/1.
//  Copyright (c) 2015年 FinalFerrumbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

#define kCampusUsedKey @"I_store_the_campus_id_used"

@interface Tool : NSObject

/**
 *  组件url工具方法
 *
 *  @param host       请求基地址
 *  @param APIVersion api版本号
 *  @param requestURL 请求操作url
 *  @param params     url附属参数
 *
 *  @return 完整的url
 */
+ (NSString *)buildRequestURLHost:(NSString *)host
                       APIVersion:(NSString *)APIVersion
                       requestURL:(NSString *)requestURL
                           params:(NSDictionary *)params;

/**
 *  设置UserDefault standardUserDefault
 *
 *  @param dict 要设置的键值对
 */
+ (void)setUserDefault:(NSDictionary *)dict;

/**
 *  重置所指定的key为nil
 *
 *  @param keys 要重置为nil的key数组,key的类型为字符串
 */
+ (void)resetUserDefautsForKeys:(NSArray *)keys;

/**
 *  获取指定key的value
 *
 *  @param key 指定的user default键
 *
 *  @return 键对应的值
 */
+ (id)getUserDefaultByKey:(NSString *)key;

/**
 *  异步信号订阅机制完成GET请求
 *
 *  @param url              请求的url
 *  @param parameters       url参数
 *  @param showNetworkError 是否显示网络错误
 *
 *  @return 对应的信号
 */
+ (RACSignal *)GET:(NSString *)url parameters:(NSDictionary *)parameters showNetworkError:(BOOL)showNetWorkError;
/**
 *  异步信号订阅机制完成GET请求,并且在对应view上添加progressView
 *
 *  @param url                  请求的url
 *  @param parameters           url参数
 *  @param progressInView       要显示progressView的view
 *  @param showNetworkError     是否显示网络错误
 ＊
 *  @return 对应的信号
 */
+ (RACSignal *)GET:(NSString *)url parameters:(NSDictionary *)parameters progressInView:(UIView *)view showNetworkError:(BOOL)showNetWorkError;

/**
 *  异步信号订阅机制完成POST请求
 *
 *  @param url              请求的url
 *  @param parameters       url参数
 *  @param showNetworkError 是否显示网络错误
 *
 *  @return 对应的信号
 */
+ (RACSignal *)POST:(NSString *)url parameters:(NSDictionary *)parameters showNetworkError:(BOOL)showNetWorkError;

/**
 *  异步信号订阅机制完成POST请求,并且在对应view上添加progressView
 *
 *  @param url                  请求的url
 *  @param parameters           url参数
 *  @param progressInView       要显示progressView的view
 *  @param showNetworkError     是否显示网络错误
 ＊
 *  @return 对应的信号
 */
+ (RACSignal *)POST:(NSString *)url parameters:(NSDictionary *)parameters progressInView:(UIView *)view showNetworkError:(BOOL)showNetWorkError;

/**
 *  异步信号订阅机制完成delete请求
 *
 *  @param url              请求的url
 *  @param parameters       url参数
 *  @param showNetworkError 是否显示网络错误
 *
 *  @return 对应的信号
 */
+ (RACSignal *)DELETE:(NSString *)url parameters:(NSDictionary *)parameters showNetworkError:(BOOL)showNetWorkError;

/**
 *  异步信号订阅机制完成delete请求,并且在对应view上添加progressView
 *
 *  @param url                  请求的url
 *  @param parameters           url参数
 *  @param progressInView       要显示progressView的view
 *  @param showNetworkError     是否显示网络错误
 ＊
 *  @return 对应的信号
 */
+ (RACSignal *)DELETE:(NSString *)url parameters:(NSDictionary *)parameters progressInView:(__weak UIView *)view showNetworkError:(BOOL)showNetWorkError;

/**
 *  异步信号订阅机制完成PUT请求
 *
 *  @param url              请求的url
 *  @param parameters       url参数
 *  @param showNetworkError 是否显示网络错误
 *
 *  @return 对应的信号
 */
+ (RACSignal *)PUT:(NSString *)url parameters:(NSDictionary *)parameters showNetworkError:(BOOL)showNetWorkError;

/**
 *  异步信号订阅机制完成PUT请求,并且在对应view上添加progressView
 *
 *  @param url                  请求的url
 *  @param parameters           url参数
 *  @param progressInView       要显示progressView的view
 *  @param showNetworkError     是否显示网络错误
 ＊
 *  @return 对应的信号
 */
+ (RACSignal *)PUT:(NSString *)url parameters:(NSDictionary *)parameters progressInView:(__weak UIView *)view showNetworkError:(BOOL)showNetWorkError;
#pragma mark - SnackBar -

/**
 *  显示snackbar
 *
 *  @param text     显示内容
 *  @param title    标题
 *  @param duration 显示时间
 */
+ (void)showSnackBarWithText:(NSString *)text title:(NSString *)title duration:(CGFloat)duration;

@end
