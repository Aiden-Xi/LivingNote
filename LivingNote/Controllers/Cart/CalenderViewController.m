//
//  CalenderViewController.m
//  LivingNote
//
//  Created by xxy on 15/11/4.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import "CalenderViewController.h"
#import "YunClenderView.h"

#import "JTCalendar.h"
#import "NSString+Tools.h"
#import "SWTableViewCell.h"
#import "UIButton+TJButtom.h"

@interface CalenderViewController () </*YunClenderViewDelegate,*/ JTCalendarDataSource, UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>

//@property (nonatomic,  strong) YunClenderView *clenderView;
@property (strong, nonatomic) IBOutlet YunButton *backButton;
@property (strong, nonatomic) IBOutlet YunButton *addBespeak;
- (IBAction)addBespeakClick:(YunButton *)sender;
- (IBAction)backPre:(YunButton *)sender;

/// 月份
@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;

/// 日期内容
@property (strong, nonatomic) JTCalendarContentView *calendarContentView;

/// 日历对象
@property (strong, nonatomic) JTCalendar *calendar;

/// 切换日历显示样式按钮
@property (nonatomic, strong) UIButton *changeCalendarStyle;

/// 预约的病人列表
@property (nonatomic, strong) UITableView *tableView;

/// 数据源数组
@property (nonatomic, strong) NSMutableArray *dataSouce;

@end

@implementation CalenderViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.calendar reloadData]; // Must be call in viewDidAppear
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 扩大可点击范围
    [_backButton setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [_addBespeak setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    
//    _clenderView = [[YunClenderView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 300)];
//    _clenderView.backGroudColor = kDefaultRedColor;
//    _clenderView.titleFont = kNormalFont;
//    _clenderView.titleColor = kWhiteColor;
//    _clenderView.delegate = self;
//    
//    [self.view addSubview:_clenderView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataSouce = [NSMutableArray arrayWithObjects:@{@"name" : @"病人A", @"time" : @"8-10pm"}, @{@"name" : @"病人B", @"time" : @"8-10pm"}, @{@"name" : @"病人C", @"time" : @"8-10pm"}, @{@"name" : @"病人D", @"time" : @"8-10pm"}, @{@"name" : @"病人E", @"time" : @"8-10pm"}, @{@"name" : @"病人F", @"time" : @"8-10pm"}, @{@"name" : @"病人G", @"time" : @"8-10pm"}, @{@"name" : @"病人H", @"time" : @"8-10pm"}, @{@"name" : @"病人I", @"time" : @"8-10pm"}, @{@"name" : @"病人J", @"time" : @"8-10pm"}, @{@"name" : @"病人K", @"time" : @"8-10pm"}, @{@"name" : @"病人L", @"time" : @"8-10pm"}, nil];
    
    [self createCalendar];
    
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Functions -

- (void)createCalendar
{
    
    _calendar = [[JTCalendar alloc] init];
    
    _calendarMenuView = [[JTCalendarMenuView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _calendarMenuView.backgroundColor = [UIColor clearColor];
    _calendarMenuView.userInteractionEnabled = NO;
    
    _calendarContentView = [[JTCalendarContentView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 115 * KProportionForWidth)];
    _calendarContentView.backgroundColor = ColorFromRGB(0xd94858);
    
    [self.view addSubview:_calendarContentView];
    [self.view addSubview:_calendarMenuView];
    
    _calendar.calendarAppearance.isWeekMode = YES;
    _calendar.calendarAppearance.calendar.firstWeekday = 1; // Sunday == 1, Saturday == 7
    _calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
    _calendar.calendarAppearance.ratioContentMenu = 1.;
    _calendar.calendarAppearance.menuMonthTextColor = kNaviTitleColor;
    _calendar.calendarAppearance.menuMonthTextFont = kSizeFont;
    _calendar.calendarAppearance.weekDayTextColor = [UIColor whiteColor];
    _calendar.calendarAppearance.weekDayTextFont = kSmallFont;
    _calendar.calendarAppearance.dayCircleColorToday = [UIColor whiteColor];
    _calendar.calendarAppearance.dayCircleColorSelected = [UIColor whiteColor];
    _calendar.calendarAppearance.dayTextColor = [UIColor whiteColor];
    _calendar.calendarAppearance.dayTextColorSelected = kNaviTitleColor;
    _calendar.calendarAppearance.dayTextColorToday = kNaviTitleColor;
    _calendar.calendarAppearance.dayDotColor = [UIColor whiteColor];
    _calendar.calendarAppearance.dayDotColorSelected = ColorFromRGB(0xd94858);
    _calendar.calendarAppearance.dayDotColorToday = ColorFromRGB(0xd94858);
    
    [_calendar setMenuMonthsView:_calendarMenuView];
    [_calendar setContentView:_calendarContentView];
    [_calendar setDataSource:self];
    
    _changeCalendarStyle = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _changeCalendarStyle.frame = CGRectMake(0, CGRectGetMaxY(_calendarContentView.frame) + 1, kScreenWidth, 25 * KProportionForWidth);
    _changeCalendarStyle.backgroundColor = ColorFromRGB(0xd94858);
    [_changeCalendarStyle addTarget:self action:@selector(didChangeModeTouch) forControlEvents:UIControlEventTouchUpInside];
    _changeCalendarStyle.imageEdgeInsets = UIEdgeInsetsMake(2.5 * KProportionForWidth, (kScreenWidth - 25 * KProportionForWidth) / 2, 2.5 * KProportionForWidth, (kScreenWidth - 25 * KProportionForWidth) / 2);
    [_changeCalendarStyle setImage:[UIImage imageNamed:@"calendar_down"] forState:UIControlStateNormal];
    
    [self.view addSubview:_changeCalendarStyle];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_changeCalendarStyle.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(_changeCalendarStyle.frame) - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:_tableView];
}

#pragma mark - Buttons callback

- (void)didGoTodayTouch
{
    [_calendar setCurrentDate:[NSDate date]];
}

- (void)didChangeModeTouch
{
    _calendar.calendarAppearance.isWeekMode = !_calendar.calendarAppearance.isWeekMode;
    
    [self transitionExample];
}

#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    return (rand() % 10) == 1;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    [_dataSouce removeAllObjects];
    [_dataSouce addObject:@{@"name" : @"病人随机", @"time" : [NSString stringWithFormat:@"时间%@",date]}];
    
    [_tableView reloadData];
}

#pragma mark - SWTableViewCell Utility -
/**
 *  返回UITableViewCell左滑后出现的按钮组
 *
 *  @return 按钮组
 */
- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray array];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:ColorFromRGB(0xd94858) title:@"删除"];
    
    return rightUtilityButtons;
}

/**
 *  prevent multiple cells from showing utilty buttons simultaneously
 *
 *  @param cell 所在的cell
 *
 *  @return 如果返回YES,则不能同时处理多个左滑
 */
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}

#pragma mark - SWTableViewCellDelegate -
/**
 *  左滑按钮组中的按钮点击事件处理方法
 *
 *  @param cell  <#cell description#>
 *  @param index <#index description#>
 */
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index indexPath:(NSIndexPath *)indexPath
{
    [_dataSouce removeObjectAtIndex:indexPath.row];
    
    [_tableView reloadData];
}

#pragma mark - Transition examples

- (void)transitionExample
{
    CGFloat newHeight = 300 * KProportionForWidth;
    if(_calendar.calendarAppearance.isWeekMode){
        newHeight = 115 * KProportionForWidth;
    }
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         _calendarContentView.frame = CGRectMake(0, 64, kScreenWidth, newHeight);
                         
                         _changeCalendarStyle.frame = CGRectMake(0, CGRectGetMaxY(_calendarContentView.frame) + 1, kScreenWidth, 25 * KProportionForWidth);
                         
                         _tableView.frame = CGRectMake(0, CGRectGetMaxY(_changeCalendarStyle.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(_changeCalendarStyle.frame) - 64) ;
                         [self.view layoutIfNeeded];
                     }];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         _calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [_calendar reloadAppearance];
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              _calendarContentView.layer.opacity = 1;
                                          }];
                     }];
    
}

#pragma mark - UITableViewDataSourc and UITableViewDelegate -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSouce.count;
}

-  (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95 * KProportionForWidth;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25 * KProportionForWidth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *colorArr = @[ColorFromRGB(0x4fd3c1), ColorFromRGB(0xd94858), ColorFromRGB(0x8b89ff), ColorFromRGB(0xfcab52)];
    
    static NSString *ID = @"cell";
    
    SWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
//        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID tableView:tableView];
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
    } else {
        // 解决重用cell的重影问题
        if (cell.contentView.subviews.count > 0)
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    cell.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 0, 4 * KProportionForWidth, 95 * KProportionForWidth);
    line.backgroundColor = colorArr[indexPath.row % 4];
    
    [cell.contentView addSubview:line];
    
    //    [line mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.top.equalTo(cell);
    //        make.width.mas_equalTo(4 * KProportionForWidth);
    //        make.height.equalTo(cell);
    //    }];
    
    NSString *nameStr = [_dataSouce[indexPath.row] objectForKey:@"name"];
    
    CGSize nameStrSize = [nameStr sizeWithFont:[UIFont fontWithName:kFontFamily size:15 * KProportionForWidth] size:CGSizeMake(9999, 9999)];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(30 * KProportionForWidth, 20 * KProportionForWidth, nameStrSize.width + 1, nameStrSize.height + 0.1);
    //    nameLabel.backgroundColor = [UIColor redColor];
    nameLabel.text = nameStr;
    nameLabel.font = [UIFont fontWithName:kFontFamily size:15 * KProportionForWidth];
    nameLabel.textColor = kNaviTitleColor;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    [cell.contentView addSubview:nameLabel];
    
    //    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(cell.mas_top).with.offset(20 * KProportionForWidth);
    //        make.left.equalTo(cell.mas_left).with.offset(30 * KProportionForWidth);
    //        make.height.mas_equalTo(nameStrSize.height + 0.1);
    //        make.width.mas_equalTo(nameStrSize.width + 1);
    //    }];
    
    UIImageView *subjectImageView = [[UIImageView alloc] init];
    subjectImageView.frame = CGRectMake(nameLabel.frame.origin.x, CGRectGetMaxY(nameLabel.frame) + 20 * KProportionForWidth, 15 * KProportionForWidth, 15 * KProportionForWidth);
    subjectImageView.image = [UIImage imageNamed:@"time_icon"];
    
    [cell.contentView addSubview:subjectImageView];
    
    //    [subjectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(nameLabel);
    //        make.bottom.equalTo(cell.mas_bottom).with.offset(-20 * KProportionForWidth);
    //        make.size.mas_equalTo(CGSizeMake(15 * KProportionForWidth, 15 * KProportionForWidth));
    //    }];
    
    NSString *subjectStr = [_dataSouce[indexPath.row] objectForKey:@"time"];
    
    CGSize subjectStrSize = [subjectStr sizeWithFont:kSmallFont size:CGSizeMake(9999, 9999)];
    
    UILabel *subjectLabel = [[UILabel alloc] init];
    subjectLabel.frame = CGRectMake(CGRectGetMaxX(subjectImageView.frame) + 10 * KProportionForWidth, subjectImageView.frame.origin.y, subjectStrSize.width + 1, subjectStrSize.height + 0.1);
    //    subjectLabel.backgroundColor = [UIColor redColor];
    subjectLabel.text = subjectStr;
    subjectLabel.font = kSmallFont;
    subjectLabel.textColor = kGrayFontColor;
    subjectLabel.textAlignment = NSTextAlignmentLeft;
    
    [cell.contentView addSubview:subjectLabel];
    
    //    [subjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.equalTo(subjectImageView);
    //        make.left.equalTo(subjectImageView.mas_right).with.offset(10 * KProportionForWidth);
    //        make.height.mas_equalTo(subjectStrSize.height + 0.1);
    //        make.width.mas_equalTo(subjectStrSize.height + 0.1);
    //    }];
    
    UIImageView *patientIcon = [[UIImageView alloc] init];
    patientIcon.frame = CGRectMake(kScreenWidth - (25 + 30) * KProportionForWidth, (95 * KProportionForWidth - 30 * KProportionForWidth) / 2, 30 * KProportionForWidth, 30 * KProportionForWidth);
    patientIcon.backgroundColor = [UIColor redColor];
    patientIcon.layer.masksToBounds = YES;
    patientIcon.layer.cornerRadius = 15 * KProportionForWidth;
    
    [cell.contentView addSubview:patientIcon];
    
    //    [patientIcon mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerY.equalTo(cell);
    //        make.right.equalTo(cell.mas_right).with.offset(-25 * KProportionForWidth);
    //        make.width.height.mas_equalTo(30 * KProportionForWidth);
    //    }];
    
    return cell;
}
- (IBAction)addBespeakClick:(YunButton *)sender {
    XXYLog(@"添加什么东西");
}

- (IBAction)backPre:(YunButton *)sender {
    XXYLog(@"测试  返回");
    [self.navigationController popViewControllerAnimated:YES];
}
@end
