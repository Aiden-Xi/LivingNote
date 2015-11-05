//
//  Tool.m
//  GuduMorning
//
//  Created by Tsao on 15/8/1.
//  Copyright (c) 2015年 FinalFerrumbox. All rights reserved.
//

#import "Tool.h"

#import <MDSnackbar.h>

@implementation Tool

#pragma mark - URL Builder

#pragma mark 计算UILabel的高度
+(CGFloat)calculateContentLabelHeight:(NSString *)text withFont:(UIFont *)font withWidth:(CGFloat)width{
    CGSize commentSize;
    commentSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:        NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    return commentSize.height;
}

#pragma mark - Detail Label -

+ (int)detailLabelHeight:(NSString *)str wordLength:(int)length linePadding:(int)padding fontSize:(int)size
{
    int detailLabelHeight;
    
    int detailLines = [self getToInt:str];
    
    if (detailLines % length == 0) {
        detailLabelHeight = (int)(detailLines / length) * (size + padding);
    } else {
        detailLabelHeight = (detailLines / length + 1) * (size + padding);
    }
    
    XXYLog(@"str = %@\nword length = %d\nline padding = %d\nfont size = %d\ndetailLabelHeight = %d\n", str, length, padding, size, detailLabelHeight);
    
    return detailLabelHeight;
}

+ (int)textLines:(NSString *)str lineWidth:(int)width fontSize:(int)size;
{
    XXYLog(@"str = %@", str);
    
    int wordLength = width / size;
    
    int lines = [self getToInt:str] / wordLength;
    
    if ([self getToInt:str] % wordLength != 0) {
        lines += 1;
    }
    
    return lines;
}

#pragma mark - String Length -

+ (int)getToInt:(NSString*)strtemp
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [strtemp dataUsingEncoding:enc];
    
    int length = (int)[da length];
    
    if (length % 2 == 0) {
        length /= 2;
    } else {
        length = length / 2 + 1;
    }
    
    return length;
}


+ (NSString *)buildRequestURLHost:(NSString *)host
                       APIVersion:(NSString *)APIVersion
                       requestURL:(NSString *)requestURL
                           params:(NSDictionary *)params
{
    if (APIVersion == nil) {
        APIVersion = @"";
    }
    XXYLog(@"host = %@, APIVersion = %@, requestURL = %@, params = %@", host, APIVersion, requestURL, params);
    
    NSString *string = [NSString stringWithFormat:@"%@%@%@?", host, APIVersion, requestURL];
    
    NSEnumerator *keyEnumerator = [params keyEnumerator];
    
    NSEnumerator *objectEnumerator = [params objectEnumerator];
    
    id key;
    
    while (key = [keyEnumerator nextObject]) {
        NSString *obj = [NSString stringWithFormat:@"%@", [objectEnumerator nextObject]];
        //        obj = [obj stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)obj, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8));
        
        string = [string stringByAppendingFormat:@"%@=%@&", key, obj];
    }
    
    string = [string stringByAppendingFormat:@"platform=iphone&intf_revision=%@&app_revision=%@", kIntfRevision, kAppVersion];
    
    return string;
}

#pragma mark - UserDefault -

+ (void)setUserDefault:(NSDictionary *)dict{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key isKindOfClass:[NSString class]]) {
            [userDefault setObject:obj forKey:key];
        }
    }];
    [userDefault synchronize];
}

+ (void)resetUserDefautsForKeys:(NSArray *)keys{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            [userDefault setObject:obj forKey:obj];
        }
    }];
    [userDefault synchronize];
}

+ (id)getUserDefaultByKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

#pragma mark - HTTP -

+ (RACSignal *)GET:(NSString *)url parameters:(NSDictionary *)parameters showNetworkError:(BOOL)showNetWorkError{
    
    return [self GET:url parameters:parameters progressInView:nil showNetworkError:showNetWorkError];
}

+ (RACSignal *)GET:(NSString *)url parameters:(NSDictionary *)parameters progressInView:(__weak UIView *)view showNetworkError:(BOOL)showNetWorkError{
    
    return [RACSignal createSignal:^RACDisposable *(id subscriber){
        // 显示progressView
        if (view) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
            [hud show:YES];
        }
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager singleton];
        [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
            if (view) {
                [MBProgressHUD hideAllHUDsForView:view animated:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (view) {
                [MBProgressHUD hideAllHUDsForView:view animated:YES];
            }
            if (showNetWorkError) {
                MDSnackbar *snackBar = [[MDSnackbar alloc] initWithText:@"oops,网线被拔掉啦～😢" actionTitle:@"异常" duration:2.0f];
                snackBar.actionTitleColor = kGreenColor;
                snackBar.multiline = YES;
                [snackBar show];
            }
            [subscriber sendError:error];
        }];
        return nil;
    }];
}

+ (RACSignal *)POST:(NSString *)url parameters:(NSDictionary *)parameters showNetworkError:(BOOL)showNetWorkError{
    
    return [self POST:url parameters:parameters progressInView:nil showNetworkError:showNetWorkError];
    
}

+ (RACSignal *)POST:(NSString *)url parameters:(NSDictionary *)parameters progressInView:(__weak UIView *)view showNetworkError:(BOOL)showNetWorkError{
    
    return [RACSignal createSignal:^RACDisposable *(id subscriber){
        // 显示progressView
        if (view) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
            [hud show:YES];
        }
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager singleton];
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
            if (view) {
                [MBProgressHUD hideAllHUDsForView:view animated:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (view) {
                [MBProgressHUD hideAllHUDsForView:view animated:YES];
            }
            if (showNetWorkError) {
                MDSnackbar *snackBar = [[MDSnackbar alloc] initWithText:@"oops,网线被拔掉啦～😢" actionTitle:@"异常" duration:2.0f];
                snackBar.actionTitleColor = kGreenColor;
                snackBar.multiline = YES;
                [snackBar show];
            }
            [subscriber sendError:error];
        }];
        return nil;
    }];
}

+ (RACSignal *)DELETE:(NSString *)url parameters:(NSDictionary *)parameters showNetworkError:(BOOL)showNetWorkError{
    
    return [self DELETE:url parameters:parameters progressInView:nil showNetworkError:showNetWorkError];
    
}

+ (RACSignal *)DELETE:(NSString *)url parameters:(NSDictionary *)parameters progressInView:(__weak UIView *)view showNetworkError:(BOOL)showNetWorkError{
    
    return [RACSignal createSignal:^RACDisposable *(id subscriber){
        // 显示progressView
        if (view) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
            [hud show:YES];
        }
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager singleton];
        [manager DELETE:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
            if (view) {
                [MBProgressHUD hideAllHUDsForView:view animated:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (view) {
                [MBProgressHUD hideAllHUDsForView:view animated:YES];
            }
            if (showNetWorkError) {
                MDSnackbar *snackBar = [[MDSnackbar alloc] initWithText:@"oops,网线被拔掉啦～😢" actionTitle:@"异常" duration:2.0f];
                snackBar.actionTitleColor = kGreenColor;
                snackBar.multiline = YES;
                [snackBar show];
            }
            [subscriber sendError:error];
        }];
        return nil;
    }];
}

+ (RACSignal *)PUT:(NSString *)url parameters:(NSDictionary *)parameters showNetworkError:(BOOL)showNetWorkError{
    
    return [self PUT:url parameters:parameters progressInView:nil showNetworkError:showNetWorkError];
    
}

+ (RACSignal *)PUT:(NSString *)url parameters:(NSDictionary *)parameters progressInView:(__weak UIView *)view showNetworkError:(BOOL)showNetWorkError{
    
    return [RACSignal createSignal:^RACDisposable *(id subscriber){
        // 显示progressView
        if (view) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
            [hud show:YES];
        }
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager singleton];
        [manager PUT:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
            if (view) {
                [MBProgressHUD hideAllHUDsForView:view animated:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (view) {
                [MBProgressHUD hideAllHUDsForView:view animated:YES];
            }
            if (showNetWorkError) {
                MDSnackbar *snackBar = [[MDSnackbar alloc] initWithText:@"oops,网线被拔掉啦～😢" actionTitle:@"异常" duration:2.0f];
                snackBar.actionTitleColor = kGreenColor;
                snackBar.multiline = YES;
                [snackBar show];
            }
            [subscriber sendError:error];
        }];
        return nil;
    }];
}

#pragma mark - SnackBar -

+ (void)showSnackBarWithText:(NSString *)text title:(NSString *)title duration:(CGFloat)duration {
    MDSnackbar *snackBar = [[MDSnackbar alloc] initWithText:text actionTitle:title duration:duration];
    snackBar.actionTitleColor = kGreenColor;
    snackBar.multiline = YES;
    [snackBar show];
}
@end
