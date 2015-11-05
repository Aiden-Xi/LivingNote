//
//  NSString+Tools.m
//  Shops-iPhone
//
//  Created by rujax on 14-9-26.
//  Copyright (c) 2014年 net.atyun. All rights reserved.
//

#import "NSString+Tools.h"

@implementation NSString (Tools)

- (CGRect)rectWithSize:(CGSize)size font:(UIFont *)font
{
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    
    return rect;
}

- (CGSize)sizeWithFont:(UIFont *)font size:(CGSize)size
{
    CGSize s = [self rectWithSize:size font:font].size;
    
    return s;
}

@end
