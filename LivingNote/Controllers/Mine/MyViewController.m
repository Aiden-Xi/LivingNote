//
//  MyViewController.m
//  LivingNote
//
//  Created by 席小雨 on 15/10/19.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController () <UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *testArray;
@property (strong, nonatomic) IBOutlet UITextField *testTextField;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _testArray = [NSMutableArray array];
    
    RACSignal *changeSignal = [self rac_valuesAndChangesForKeyPath:@keypath(self, testArray) options: NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld observer:nil];
    [changeSignal subscribeNext:^(RACTuple *x){
        XXYLog(@"888999988889989898--%@", _testArray);
    }];
    
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addValue)];
    [oneTap setNumberOfTapsRequired:1];
    oneTap.delegate = self;
    
    [self.view addGestureRecognizer:oneTap];
    
}

- (void)addValue {
    [[self mutableArrayValueForKey:@"testArray"] addObject:@"你好"];
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
