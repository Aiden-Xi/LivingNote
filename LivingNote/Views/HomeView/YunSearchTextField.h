//
//  YunSearchTextField.h
//  LivingNote
//
//  Created by xxy on 15/10/21.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YunSearchTextField;

@protocol YunSearchTextFieldDelegate <NSObject>

- (void)YunSearchTextFieldClick:(YunSearchTextField *)searchTextField;

@end

@interface YunSearchTextField : UITextField

@property (nonatomic, assign) id <YunSearchTextFieldDelegate> searchDelegate;

@end
