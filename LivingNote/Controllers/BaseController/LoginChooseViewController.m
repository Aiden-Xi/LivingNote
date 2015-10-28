//
//  LoginChooseViewController.m
//  LivingNote
//
//  Created by 席小雨 on 15/10/27.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "LoginChooseViewController.h"

@interface LoginChooseViewController ()
@property (weak, nonatomic) IBOutlet YunButton *sickButton;
- (IBAction)sickButtonClick:(YunButton *)sender;
@property (weak, nonatomic) IBOutlet YunButton *doctor;
- (IBAction)doctorButtonClick:(YunButton *)sender;
@property (weak, nonatomic) IBOutlet YunButton *enterButton;
- (IBAction)enterButtonClick:(YunButton *)sender;

@end

@implementation LoginChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sickButton.layer.borderColor = COLOR(204, 49, 72, 1).CGColor;
    _sickButton.layer.borderWidth = kLineHeight;
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

- (IBAction)sickButtonClick:(YunButton *)sender {
}
- (IBAction)doctorButtonClick:(YunButton *)sender {
}
- (IBAction)enterButtonClick:(YunButton *)sender {
}
@end
