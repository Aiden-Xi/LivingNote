//
//  AboutViewController.m
//  LivingNote
//
//  Created by 席小雨 on 15/10/19.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

#pragma mark - System Function -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建导航栏控制器
    NSArray *tempItemsArray = @[@"share_camera", @"share_telephone", @"share_phone"];
    UIView *navigationView = [[YunNavigationBarView alloc] initWithTitle:NO title:@"关于" titleColor:kOrangeColor titleFont:kBigBoldFont leftItemImageArray:nil rightItemsImageArray:tempItemsArray];
    
    [self.view addSubview:navigationView];
    
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(kNavTabBarHeight);
        make.top.mas_equalTo(0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Segue Action -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UIViewController * viewController = [segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"lineChart"]) {
        
        //Add line chart
        
        viewController.title = @"Line Chart";
        
    } else if ([segue.identifier isEqualToString:@"barChart"])
    {
        //Add bar chart
        
        viewController.title = @"Bar Chart";
    } else if ([segue.identifier isEqualToString:@"circleChart"])
    {
        //Add circle chart
        
        viewController.title = @"Circle Chart";
        
    } else if ([segue.identifier isEqualToString:@"pieChart"])
    {
        //Add pie chart
        
        viewController.title = @"Pie Chart";
    } else if ([segue.identifier isEqualToString:@"scatterChart"])
    {
        //Add scatter chart
        
        viewController.title = @"Scatter Chart";
    }else if ([segue.identifier isEqualToString:@"radarChart"])
    {
        //Add radar chart
        
        viewController.title = @"Radar Chart";
    } else if ([segue.identifier isEqualToString:@"ceshi"])
    {
        //Add radar chart
        
        viewController.title = @"Navi Ceshi";
    }
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
