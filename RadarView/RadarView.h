//
//  RadarView.h
//  LQRadarChart
//
//  Created by OS X on 2018/2/8.
//  Copyright © 2018年 LiQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadarView : UIView

- (instancetype)initWithFrame:(CGRect)frame
NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;

//@property (nonatomic, weak)id<LQRadarChartDataSource>dataSource;
//@property (nonatomic, weak)id<LQRadarChartDelegate>delegate;

/**  */
@property(nonatomic,assign) CGFloat radius;
/** 顶点最大值 默认 100 */
@property(nonatomic,assign) CGFloat minValue;
/** 中心点最小值 默认 0 */
@property(nonatomic,assign) CGFloat maxValue;
/** 多边形圈数 默认 2 */
@property (nonatomic, assign) NSInteger numOfSetp;
/** 顶点个数 默认 3 */
@property (nonatomic, assign) NSInteger numOfRow;
/** 选定区域数 默认 1 */
@property (nonatomic, assign) NSInteger numOfSection;
/** 顶点标题 */
@property (nonatomic, strong) NSArray *titleArray;
/** 选定区域顶点的值 */
@property (nonatomic, strong) NSArray *valueArray;

/** 多边形圈颜色 */
@property (nonatomic, strong) UIColor *borderColor;
/** 最大顶点标题颜色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 最大顶点字体大小 */
@property (nonatomic, assign) CGFloat titleFont;
/** 多边形填充颜色 */
@property (nonatomic, strong) UIColor *fillStepColor;
/** 选定区域顶点，边框颜色 */
@property (nonatomic, strong) UIColor *fillBorderColor;
/** 选定区域填充颜色 */
@property (nonatomic, strong) UIColor *fillColor;


/**  */
/**  */
/**  */

@property(nonatomic,assign) BOOL showPoint;
@property(nonatomic,assign) BOOL showBorder;
@property(nonatomic,assign) BOOL fillArea;
@property(nonatomic,assign) BOOL clockwise;
@property(nonatomic,assign) BOOL autoCenterPoint;

@property(nonatomic,assign) CGPoint centerPoint;

- (void)reloadData;

@end
