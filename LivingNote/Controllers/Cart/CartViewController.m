//
//  CartViewController.m
//  LivingNote
//
//  Created by 席小雨 on 15/10/19.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "CartViewController.h"

#import "LoginViewController.h"

@interface CartViewController ()
@property (strong, nonatomic) IBOutlet YunButton *jumpButton;
- (IBAction)jumpButtonClick:(YunButton *)sender;

@end

@implementation CartViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)jumpButtonClick:(YunButton *)sender {
    UIViewController *login = [kLoginRegisterStoryBoard instantiateViewControllerWithIdentifier:@"DoctorCertifyViewController"];
    
    [[self rdv_tabBarController] setTabBarHidden:!self.rdv_tabBarController.tabBarHidden animated:YES];
    
//    [self.navigationController presentViewController:login animated:YES completion:^{
//        self.navigationController.navigationBarHidden = YES;
//    }];
    [self.navigationController pushViewController:login animated:YES];
    
    
}
@end
