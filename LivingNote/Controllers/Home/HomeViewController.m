//
//  HomeViewController.m
//  LivingNote
//
//  Created by 席小雨 on 15/10/19.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "HomeViewController.h"

// Views
#import "YunSearchTextField.h"
#import "YunButtonView.h"


#define kYunButtonViewTag 10
#define kBgViewTag 100
#define kBottomButtonTag 1000

#define kBgViewHeight (kScreenWidth > 375 ? 232 * 1.293 : (kScreenWidth > 320 ? 232 * 1.17 : 232))
#define kRightSpace (kScreenWidth > 375 ? 232 * 1.293 : (kScreenWidth > 320 ? 232 * 1.17 : 232))

@interface HomeViewController () <SDCycleScrollViewDelegate, YunSearchTextFieldDelegate, UITextFieldDelegate, UIScrollViewDelegate, YunButtonViewDelegate>

/// 轮播图数组
@property (nonatomic, strong) NSMutableArray *bannerArray;

/// 导航栏搜索框
@property (nonatomic, strong) YunSearchTextField *searchTextField;

@property (nonatomic, strong) YunButton *photoButton;

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *tableView;

/// 计算中间布局最后的高度
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSMutableArray *testArray;

/// 键盘回收控件
@property (nonatomic, strong) IQKeyboardManager            *keyManager;
@property (nonatomic, strong) IQKeyboardReturnKeyHandler   *returnKeyHandler;

@end

@implementation HomeViewController

#pragma mark - System Function - 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kLightGaryColor;
    
    /// 键盘处理操作
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    self.returnKeyHandler.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    
    _keyManager = [IQKeyboardManager sharedManager];
    _keyManager.enable = YES;
    _keyManager.keyboardDistanceFromTextField = 40;
    _keyManager.enableAutoToolbar = YES;
    _keyManager.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    _keyManager.shouldToolbarUsesTextFieldTintColor = YES;
    _keyManager.canAdjustTextView = YES;
    
    _bannerArray = [NSMutableArray array];
    
    _testArray = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [dict setObject:@"MEDICAL" forKey:@"title"];
        [dict setObject:@"云店家出品" forKey:@"desc"];
        [dict setObject:@"http://7xnc62.com1.z0.glb.clouddn.com/uploads%2Frecommend%2Flarge_poster%2F3209%2F900b2f8769f9311a348efb77fb723257.jpg" forKey:@"image_url"];
        
        [_testArray addObject:dict];
    }
    
    [self getBannerData];
    
}

- (void)dealloc {
    [_hud removeFromSuperview];
    _hud = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Create UI - 

- (void)createTopUI {
    
//    _searchTextField = [[YunSearchTextField alloc] init];
//    _searchTextField.searchDelegate = self;
//    _searchTextField.delegate = self;
//    
//    [self.view addSubview:_searchTextField];
//    
//    [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset(20);
//        make.top.equalTo(self.view.mas_top).with.offset(27);
//        make.height.mas_equalTo(@30);
//        make.right.equalTo(self.view.mas_right).with.offset(-60);
//    }];
//    
//    _photoButton = [[YunButton alloc] init];
//    [_photoButton setImage:[UIImage imageNamed:@"sao_new"] forState:UIControlStateNormal];
//    _photoButton.backgroundColor = kClearColor;
//    [_photoButton addTarget:self action:@selector(photoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:_photoButton];
//    
//    [_photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-5);
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(44);
//        make.top.mas_equalTo(20);
//    }];
    
    // =====================================
    
    // 创建导航栏控制器
//    NSArray *tempItemsArray = @[@"share_camera"];
//    UIView *navigationView = [[YunNavigationBarView alloc] initWithTitle:NO title:@"主页" titleColor:kBlackColor titleFont:kBigFont leftItemImageArray:tempItemsArray rightItemsImageArray:tempItemsArray];
//    
//    [self.view addSubview:navigationView];
//    
//    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(0);
//        make.right.equalTo(self.view).offset(0);
//        make.height.mas_equalTo(kNavTabBarHeight);
//        make.top.equalTo(self.view).offset(0);
//    }];
//    
//    // 添加scrollView
//    _scrollView = [[UIScrollView alloc] init];
//    _scrollView.backgroundColor = COLOR(100, 100, 100, 0.5);
//    _scrollView.delegate = self;
//    //    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self.view addSubview:_scrollView];
//    
//    // 添加约束
//    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(navigationView).offset(0);
//        make.right.equalTo(self.view).offset(0);
//        make.left.equalTo(self.view).offset(0);
//        make.bottom.equalTo(self.view).offset(0);
//    }];
//    
//    
//    _sdCycleScrollView = [[SDCycleScrollView alloc] init];
//    _sdCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//    _sdCycleScrollView.delegate = self;
//    _sdCycleScrollView.placeholderImage = [UIImage imageNamed:@"default_history"];
//    _sdCycleScrollView.imageURLStringsGroup = self.bannerArray;
//    _sdCycleScrollView.dotColor = kOrangeColor;
//    _sdCycleScrollView.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [_scrollView addSubview:_sdCycleScrollView];
//    
//    [_sdCycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_scrollView).offset(0);
//        make.top.equalTo(_scrollView).offset(0);
//        make.right.equalTo(_scrollView).offset(0);
//        make.height.mas_equalTo((kScreenWidth / 640) * 200);
//    }];

    
    // ===================================
    
    
    // 创建导航栏控制器
    NSArray *tempItemsArray = @[@"share_camera"];
    UIView *navigationView = [[YunNavigationBarView alloc] initWithTitle:NO title:@"主页" titleColor:kBlackColor titleFont:kBigFont leftItemImageArray:tempItemsArray rightItemsImageArray:tempItemsArray];
    
    [self.view addSubview:navigationView];
    
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(kNavTabBarHeight);
        make.top.equalTo(self.view).offset(0);
    }];
    
    // 添加scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavTabBarHeight, kScreenWidth, kScreenHeight - kNavTabBarHeight - 48)];
    _scrollView.backgroundColor = kLightGaryColor;
    _scrollView.delegate = self;
//    _scrollView.bounces = NO;
    
    [self.view addSubview:_scrollView];
    
    _sdCycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenWidth / 640) * 200)];
    _sdCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _sdCycleScrollView.delegate = self;
    _sdCycleScrollView.placeholderImage = [UIImage imageNamed:@"default_history"];
    _sdCycleScrollView.imageURLStringsGroup = self.bannerArray;
    _sdCycleScrollView.dotColor = kOrangeColor;
    
    [_scrollView addSubview:_sdCycleScrollView];

    // 循环创建六个按钮
    NSArray *buttonTittle = @[@"我的预约",@"我的病历",@"我的治疗",@"我的医生",@"我的泵",@"医学文库"];
    
    NSArray *buttonImageName = @[@"commend_icon",@"activity_icon",@"shop_icon",@"collection_icon",@"order_icon",@"message_icon"];
    
    CGFloat width = kScreenWidth / 3;
    CGFloat height = width;

    for (NSInteger i = 0; i < buttonImageName.count; i++) {
        NSInteger col = i % 3;   // 列
        NSInteger row = i / 3;   // 行
        
        YunButtonView *yunButtonView = [[YunButtonView alloc] initWithFrame:CGSizeMake(width, height) imageName:buttonImageName[i] labelName:buttonTittle[i] index:(i + 1) * kYunButtonViewTag];
        yunButtonView.delegate = self;
        
        [_scrollView addSubview:yunButtonView];
        
        // 添加约束
        [yunButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_sdCycleScrollView).offset((kScreenWidth / 640) * 200 + row * height);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
            make.left.equalTo(_scrollView).offset(col * width);
        }];
    }
    
    // 添加后面的内容
    CGFloat bgViewHeight = kBgViewHeight;
    
    _height = CGRectGetMaxY(_sdCycleScrollView.frame) + 2 * height + kDoubleSpace;
    
    for (int i = 0; i < _testArray.count; i++) {
        NSDictionary *dict = _testArray[i];
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = kWhiteColor;
        
        [_scrollView addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollView).offset(_height + i * (bgViewHeight + 1.5 * kDoubleSpace));
            make.left.equalTo(_scrollView).offset(0);
            make.width.equalTo(_scrollView);
            make.height.mas_equalTo(bgViewHeight);
        }];
        
//        // 添加一个全部覆盖按钮
//        YunButton *allCovButton = [[YunButton alloc] init];
//        allCovButton.backgroundColor = kClearColor;
//        allCovButton.tag = i * kBgViewTag;
//        [allCovButton addTarget:self action:@selector(allCovButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [bgView addSubview:allCovButton];
//        
//        [allCovButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(bgView);
//            make.width.and.height.equalTo(bgView);
//        }];
        
        // 添加标题
        YunLabel *titleLabel = [[YunLabel alloc] init];
        titleLabel.text = [NSString stringWithFormat:@"医学文库文章: %@", dict[@"title"]];
        titleLabel.font = kNormalFont;
        titleLabel.textColor = kBlackColor;
        
        [bgView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).offset(1.5 * kDoubleSpace);
            make.right.equalTo(bgView).offset(0);
            make.top.equalTo(bgView).offset(kDoubleSpace);
            make.height.mas_equalTo(2 * kDoubleSpace);
        }];
        
        // 副标签
        YunLabel *descLabel = [[YunLabel alloc] init];
        descLabel.text = [NSString stringWithFormat:@"%@", dict[@"desc"]];
        descLabel.textColor = COLOR(127, 127, 127, 1);
        descLabel.font = kMidFont;
        
        [bgView addSubview:descLabel];
        
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).offset(1.5 * kDoubleSpace);
            make.right.equalTo(bgView).offset(0);
            make.top.equalTo(bgView).offset(3.5 * kDoubleSpace);
            make.height.mas_equalTo(2 * kDoubleSpace);
            
        }];
        
        // 分割线
        YunLineView *lineView = [[YunLineView alloc] init];
        
        [bgView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).offset(0);
            make.right.equalTo(bgView).offset(0);
            make.top.equalTo(bgView).offset(6 * kDoubleSpace);
            make.height.mas_equalTo(kLineHeight);
        }];
        
        // imageView
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = kClearColor;
        imageView.contentMode = UIViewContentModeCenter;
        		
        [bgView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).offset(0);
            make.right.equalTo(bgView).offset(0);
            make.top.equalTo(bgView).offset(6 * kDoubleSpace + kLineHeight);
            make.bottom.equalTo(bgView).offset( -5 * kDoubleSpace);
        }];
        
        __weak UIImageView *_imageView = imageView;
        
        [imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kNullToString([dict safeObjectForKey:@"image_url"])]]
                         placeholderImage:nil
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                      _imageView.contentMode = UIViewContentModeScaleToFill;
                                      _imageView.image = image;
                                  }
                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                      [_imageView setImageWithURL:[NSURL URLWithString:kNullToString([dict safeObjectForKey:@"image_url"])] placeholderImage:[UIImage imageNamed:@"default_history"]];
                                      _imageView.contentMode = UIViewContentModeScaleToFill;
                                  }];
        
        // 分割线
        YunLineView *bottomLineView = [[YunLineView alloc] init];
        
        [bgView addSubview:bottomLineView];
        
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).offset(0);
            make.right.equalTo(bgView).offset(0);
            make.bottom.equalTo(bgView).offset(-4.9 * kDoubleSpace);
            make.height.mas_equalTo(kLineHeight);
        }];
        
        // UIButton
        YunButton *button = [[YunButton alloc] init];
        button.backgroundColor = kClearColor;
        button.tag = ( i + 1) * kBottomButtonTag;
        [button addTarget:self action:@selector(enterDetail:) forControlEvents:UIControlEventTouchUpInside];
        
        [bgView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).offset(0);
            make.right.equalTo(bgView).offset(0);
            make.top.mas_equalTo(imageView.mas_bottom).offset(0);
            make.bottom.equalTo(bgView).offset(0);
        }];
    
        // 箭头
        UIImageView *arrowView = [[UIImageView alloc] init];
        arrowView.image = [UIImage imageNamed:@"back_button"];
        arrowView.transform = CGAffineTransformMakeRotation(M_PI);
        
        [bgView addSubview:arrowView];
        
        [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(button.mas_top).offset(1.3 * kDoubleSpace);
            make.width.and.height.mas_equalTo(25);
            make.right.equalTo(bgView).offset(-1 * kDoubleSpace);
        }];
        
        YunLabel *detailLabel = [[YunLabel alloc] init];
        detailLabel.text = @"查看详情";
        detailLabel.textColor = [UIColor lightGrayColor];
        detailLabel.font = kNormalFont;
        detailLabel.textAlignment = NSTextAlignmentRight;
        
        [bgView addSubview:detailLabel];
        
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).offset(0);
            make.right.mas_equalTo(arrowView.mas_left).offset(0);
            make.top.mas_equalTo(imageView.mas_bottom).offset(0);
            make.bottom.equalTo(bgView).offset(0);
        }];
    }
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth, (_height + (kBgViewHeight + 2 *kDoubleSpace) * _testArray.count));
}

#pragma mark - Get Data - 

- (void)getBannerData {
    NSString *bannerURL = [Tool buildRequestURLHost:kRequestHostWithPublic APIVersion:kAPIVersion1 requestURL:kHomeBannerURL params:nil];
    RACSignal *bannerSignal = [Tool GET:bannerURL parameters:nil progressInView:self.navigationController.view showNetworkError:YES];
    [bannerSignal subscribeNext:^(id responseObject) {
        if (kGetResponseCode(responseObject) == kSuccessCode) {
            NSArray *tempArray = [kGetResponseData(responseObject) objectForKey:@"banners"];
            
            for (NSDictionary *dict in tempArray) {
                
                NSString *imageURL = [dict safeObjectForKey:@"image_url"];
                
                [self.bannerArray addObject:imageURL];
            }
            
            if (self.bannerArray.count > 0) {
                [self createTopUI];
            }
        }
    }];
}

#pragma mark - Button Click - 

- (void)photoButtonClick:(YunButton *)sender {
    
}

- (void)allCovButtonClick:(YunButton *)sender {
    XXYLog(@"------allCovButton--%ld", sender.tag);
}

- (void)enterDetail:(YunButton *)sender {
    XXYLog(@"-----enterDetail--%ld", sender.tag);
}

#pragma markk - SearchView Delegate - 

- (void)YunSearchTextFieldClick:(YunSearchTextField *)searchTextField {
    YunButton *leftButton = (YunButton *)[searchTextField viewWithTag:1001];
    
    if ([[leftButton currentTitle] isEqualToString:@"商品"]) {
            _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            [_hud hide:YES afterDelay:0.5];
        
        [leftButton setTitle:@"商铺" forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"search_up"] forState:UIControlStateNormal];
    } else {
            _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            [_hud hide:YES afterDelay:0.5];

        [leftButton setTitle:@"商品" forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"search_down"] forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    XXYLog(@"输出了什么东西---%@", textField.text);
    
    return YES;
}

#pragma mark - SDCycleScrollView Delegate -

/**
 轮播图第三方库代理方法实现
 
 @param cycleScrollView 轮播图控件
 @param index 被点击的图片位置
 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    XXYLog(@"第%ld个轮播图被点击了", (long)index);
}

#pragma mark - YunButtonViewDelegate - 

- (void)yunButtonViewClick:(NSInteger)indexTag {
    
    NSInteger index = indexTag / kYunButtonViewTag;
    
    switch (index) {
        case 1:
        {
            XXYLog(@"-------1");
            break;
        }
        case 2:
        {
            XXYLog(@"-------2");
            break;
        }
        case 3:
        {
            XXYLog(@"-------3");
            break;
        }
        case 4:
        {
            XXYLog(@"-------4");
            break;
        }
        case 5:
        {
            XXYLog(@"-------5");
            break;
        }
        case 6:
        {
            XXYLog(@"-------6");
            break;
        }
        default:
            break;
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
