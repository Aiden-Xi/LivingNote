//
//  UIImage+LoadImageFromWeb.h
//  QiuYiGua
//
//  Created by rujax on 2013-05-23.
//  Copyright (c) 2013年 net.atyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LoadImageFromWeb)

+ (UIImage *)loadImageFromWeb:(NSString *)imageURL;
+ (void)loadAndSaveImageFromWeb:(NSString *)imageURL;
+ (UIImage *)loadWebImageFromDocument:(NSString *)imageURL;

@end
