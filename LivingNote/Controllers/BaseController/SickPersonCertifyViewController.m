//
//  SickPersonCertifyViewController.m
//  LivingNote
//
//  Created by 席小雨 on 15/10/27.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "SickPersonCertifyViewController.h"

@interface SickPersonCertifyViewController ()
@property (weak, nonatomic) IBOutlet YunButton *manButton;
@property (weak, nonatomic) IBOutlet YunButton *womanButton;

@end

@implementation SickPersonCertifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _manButton.selected = YES;
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
