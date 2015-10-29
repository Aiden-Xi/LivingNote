//
//  DocterMineViewController.m
//  LivingNote
//
//  Created by 席小雨 on 15/10/29.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "DocterMineViewController.h"

#import "UIView+MGBadgeView.h"

@interface DocterMineViewController ()
@property (weak, nonatomic) IBOutlet YunButton *rightButton;
@property (weak, nonatomic) IBOutlet YunButton *leftButton;
- (IBAction)rightButtonClick:(YunButton *)sender;
- (IBAction)leftButtonClick:(YunButton *)sender;

@end

@implementation DocterMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_leftButton.badgeView setBadgeValue:1];
    [_leftButton.badgeView setOutlineWidth:0.0];
    [_leftButton.badgeView setPosition:MGBadgePositionTopLeft];
    [_leftButton.badgeView setBadgeColor:[UIColor redColor]];
    [_leftButton.badgeView setTextColor:kWhiteColor];
    
    [_rightButton.badgeView setBadgeValue:2];
    [_rightButton.badgeView setOutlineWidth:1.0];
    [_rightButton.badgeView setPosition:MGBadgePositionTopRight];
    [_rightButton.badgeView setOutlineColor:[UIColor blueColor]];
    [_rightButton.badgeView setBadgeColor:[UIColor yellowColor]];
    [_rightButton.badgeView setTextColor:[UIColor blueColor]];
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

- (IBAction)rightButtonClick:(YunButton *)sender {
}

- (IBAction)leftButtonClick:(YunButton *)sender {
}
@end
