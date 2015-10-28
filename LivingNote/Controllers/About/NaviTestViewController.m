//
//  NaviTestViewController.m
//  LivingNote
//
//  Created by xxy on 15/10/26.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "NaviTestViewController.h"

@interface NaviTestViewController ()

@end

@implementation NaviTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建导航栏控制器
    NSArray *tempItemsArray = @[@"share_camera", @"share_telephone", @"share_phone"];
    YunNavigationBarView *navigationView = [[YunNavigationBarView alloc] initWithTitle:YES title:@"关于" titleColor:kOrangeColor titleFont:kBigBoldFont leftItemImageArray:nil rightItemsImageArray:tempItemsArray];
    navigationView.delegate = self;
    
    [self.view addSubview:navigationView];
    
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(kNavTabBarHeight);
        make.top.mas_equalTo(0);
    }];
}

- (void)YunNavigationBarViewClickButton:(YunButton *)sender index:(int)index {
    switch (index) {   // index 从1 开始 最多到4  指右边的按钮不能超过三个  右边的按钮式从右到左进行排序的
        case 1:
        {
            [self.navigationController popViewControllerAnimated:YES];
            XXYLog(@"---1");
            break;
        }
        case 2:
        {
            [self.navigationController popViewControllerAnimated:YES];
            XXYLog(@"---2");
            break;
        }
        case 3:
        {
            [self.navigationController popViewControllerAnimated:YES];
            XXYLog(@"---3");
            break;
        }
        case 4:
        {
            [self.navigationController popViewControllerAnimated:YES];
            XXYLog(@"---4");
            
            break;
        }
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
