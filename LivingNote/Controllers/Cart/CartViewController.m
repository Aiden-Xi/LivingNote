//
//  CartViewController.m
//  LivingNote
//
//  Created by 席小雨 on 15/10/19.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "CartViewController.h"

#import "LoginViewController.h"
#import "YunTimeButton.h"

#define Bself(weakSelf)  __weak __typeof(&*self)weakSelf = self

@interface CartViewController () <YunTimeButtonDelegate>

@property (strong, nonatomic) IBOutlet YunTimeButton *timeButton;
- (IBAction)jumpButtonClick:(YunTimeButton *)sender;

@property (nonatomic, strong) UIView *testView;

@property (nonatomic, strong) YunTimeButton *timeBtn;

@property (nonatomic, assign) BOOL isMove;

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
    
    _timeBtn = [[YunTimeButton alloc] initWithFrame:CGRectMake(100, 100, 120, 30) titleString:@"验证码" timeCount:5];
    _timeBtn.delegate = self;
    
    [self.view addSubview:_timeBtn];
    
    _isMove = YES;
    
    Bself(bself);
    
    _testView = [[UIView alloc] init];
    _testView.backgroundColor = kOrangeColor;
    
    [self.view addSubview:_testView];
    
    [_testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bself.view).offset(100);
        make.left.equalTo(bself.view).offset(0);
        make.height.mas_equalTo(100);
        make.right.equalTo(bself.view).offset(0);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)yunTimeButtonClick:(YunTimeButton *)sender {
    XXYLog(@"验证码接收失败，请从新点击按钮获取");
}

- (IBAction)jumpButtonClick:(YunTimeButton *)sender {
    UIViewController *login = [kLoginRegisterStoryBoard instantiateViewControllerWithIdentifier:@"CalenderViewController"];
    
    [[self rdv_tabBarController] setTabBarHidden:!self.rdv_tabBarController.tabBarHidden animated:YES];
    
    //    [self.navigationController presentViewController:login animated:YES completion:^{
    //        self.navigationController.navigationBarHidden = YES;
    //    }];
    [self.navigationController pushViewController:login animated:YES];
    
    
    
//    Bself(bself);
//    
//    if (_isMove) {
//        _isMove = NO;
//        [UIView animateWithDuration:1.0 animations:^{
//            
//            [bself.testView mas_updateConstraints:^(MASConstraintMaker *make) {
//                
//                //更改距顶上的高度
//                make.top.equalTo(bself.view).offset(400);
//            }];
//            
//            [sender mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(bself.view).offset(0);
//            }];
//            
//            //必须调用此方法，才能出动画效果
//            [bself.view layoutIfNeeded];   // <这里是让该对象的父视图view进行重新布局>
//        }];
//    } else {
//        _isMove = YES;
//        
//        [UIView animateWithDuration:0.4 animations:^{
//            
//            [bself.testView mas_updateConstraints:^(MASConstraintMaker *make) {
//                
//                //更改距顶上的高度
//                make.top.equalTo(bself.view).with.offset(50);
//            }];
//            //必须调用此方法，才能出动画效果
//            [bself.view layoutIfNeeded];   // <这里是让该对象的父视图view进行重新布局>
//        }];
//    }
}
@end
