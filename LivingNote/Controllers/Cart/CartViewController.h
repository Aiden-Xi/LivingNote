//
//  CartViewController.h
//  LivingNote
//
//  Created by 席小雨 on 15/10/19.
//  Copyright © 2015年 AtYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartViewController : BaseViewController <PNChartDelegate>

@property (nonatomic) PNLineChart * lineChart;
@property (nonatomic) PNBarChart * barChart;
@property (nonatomic) PNCircleChart * circleChart;
@property (nonatomic) PNPieChart *pieChart;
@property (nonatomic) PNScatterChart *scatterChart;
@property (nonatomic) PNRadarChart *radarChart;



@end
