//
//  DatePickerView.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "DatePickerView.h"

@interface DatePickerView ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) UIDatePickerMode  mode;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, strong) NSDate *currentDate;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *btnView;
@property (nonatomic, strong) UILabel *selectLabel;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *determineButton;

@end

@implementation DatePickerView

/** 类方法创建日期选择器 */
+ (instancetype)datePickerViewWithPickerMode:(UIDatePickerMode)mode minimumDate:(NSDate *)minimumDate delegate:(id)delegate {
    DatePickerView *pickerView = [[DatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds pickerMode:mode minimumDate:minimumDate delegate:delegate];
    
    return pickerView;
}

/** 类方法创建日期选择器 - 有默认日期 */
+ (instancetype)datePickerViewWithPickerMode:(UIDatePickerMode)mode currentDate:(NSDate *)currentDate minimumDate:(NSDate *)minimumDate delegate:(id)delegate {
    DatePickerView *pickerView = [[DatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds pickerMode:mode currentDate:currentDate minimumDate:minimumDate delegate:delegate];
    
    return pickerView;
}

/** 实例方法创建日期选择器*/
- (instancetype)initWithFrame:(CGRect)frame pickerMode:(UIDatePickerMode)mode minimumDate:(NSDate *)minimumDate delegate:(id)delegate {
    if (frame.size.width>frame.size.height) {
        float a = frame.size.height;
        frame.size.height = frame.size.width;
        frame.size.height = a;
    }
    self = [super initWithFrame:frame];
    if (self) {
        self.mode = mode;
        self.minDate = minimumDate;
        self.delegate = delegate;
        
        self.bounds = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
        self.layer.opacity = 0.0;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        //
        [self createTap];
        [self createView];
        [self creaeButton];
    }
    
    return self;
}

/** 实例方法创建日期选择器 - 有默认日期   */
- (instancetype)initWithFrame:(CGRect)frame pickerMode:(UIDatePickerMode)mode currentDate:(NSDate *)currentDate minimumDate:(NSDate *)minimumDate delegate:(id)delegate {
    if (frame.size.width>frame.size.height) {
        float a = frame.size.height;
        frame.size.height = frame.size.width;
        frame.size.height = a;
    }
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.mode = mode;
        self.minDate = minimumDate;
        self.maxDate = [NSDate new];
        self.currentDate = currentDate ?: [NSDate new];
        self.delegate = delegate;
        
        self.bounds = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
        self.layer.opacity = 0.0;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        //
        [self createTap];
        [self createView];
        [self creaeButton];
    }
    
    return self;
}

//view
- (void)createView {

    // 内容背景
    self.contentView = [[UIView alloc] init]; // CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, AUTO_SCALE_H(240))
    [Controls viewWith:self.contentView frame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, AUTO_SCALE_H(240)) backColor:kWHITE_COLOR alpha:1 cornerRadius:0];
    [self addSubview:self.contentView];
    
    
    // 按钮背景
    self.btnView = [[UIView alloc] init];
    [Controls viewWith:self.btnView frame:CGRectMake(0, 0, SCREEN_WIDTH, AUTO_SCALE_H(46)) backColor:kWHITE_COLOR alpha:1.0 cornerRadius:0];
    [self.contentView addSubview:self.btnView];
    
    // 标题
    self.selectLabel = [[UILabel alloc]init];
    NSDate *tempDate = self.currentDate ?: [NSDate new];
    NSString *selectStr = [NSString stringWithFormat:@"%@ 岁", [NSDate getAgeWithDate:tempDate]];
    [Controls labelWith:self.selectLabel frame:CGRectMake(0, 0, SCREEN_WIDTH-AUTO_SCALE_W(200), FUNC_H(self.btnView)) title:[NSString stringWithFormat:@"%@", selectStr] titleColor:k1D_COLOR backColor:nil font:17 bold:NO cornerRadius:0];
    self.selectLabel.textAlignment = NSTextAlignmentCenter;
    self.selectLabel.center = self.btnView.center;
    [self.btnView addSubview:self.selectLabel];
    

    // 选择器
    self.datePicker = [UIDatePicker new];
    self.datePicker.datePickerMode = self.mode;
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.minimumDate = self.minDate;
    self.datePicker.maximumDate = self.maxDate ?: [NSDate new];
    self.datePicker.date = self.currentDate ?: [NSDate new]; // 默认显示当前时间
    self.datePicker.frame = CGRectMake(0, FUNC_Y(self.btnView)+FUNC_H(self.btnView), SCREEN_WIDTH, AUTO_SCALE_H(180));
    [self.datePicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.datePicker];
    

}

// button
- (void)creaeButton {
    UIColor *color = [UIColor colorWithRed:205.0/255 green:205.0/255 blue:205.0/255 alpha:1];
    
    UIButton *cancleButton = [[UIButton alloc]init];// CGRectMake(16, 0, AUTO_SCALE_H(64), AUTO_SCALE_H(36))
    [Controls buttonWith:cancleButton frame:KFRAME backImageName:nil title:@"取消" titleColor:[UIColor lightGrayColor] backColor:nil font:15.0 target:self action:@selector(cancleButtonClick:) cornerRadius:4];
    [cancleButton.layer setBorderColor:color.CGColor];
    [cancleButton.layer setBorderWidth:0.5];
    [self.btnView addSubview:cancleButton];
    
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnView).offset(AUTO_SCALE_H(5));
        make.left.equalTo(self.btnView).offset(MARGIN_W_15);
        make.width.mas_equalTo(AUTO_SCALE_W(64));
        make.height.mas_equalTo(AUTO_SCALE_H(36));
    }];
    
    UIButton *determineButton = [[UIButton alloc]init];// CGRectMake(SCREEN_WIDTH/2.0, 0, AUTO_SCALE_H(64), AUTO_SCALE_H(36))
    [Controls buttonWith:determineButton frame:KFRAME backImageName:nil title:@"确定" titleColor:k1D_COLOR backColor:nil font:15.0 target:self action:@selector(determineButtonClick:) cornerRadius:4];
    [determineButton.layer setBorderColor:color.CGColor];
    [determineButton.layer setBorderWidth:0.5];
    [self.btnView addSubview:determineButton];
    
    [determineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnView).offset(AUTO_SCALE_H(5));
        make.right.equalTo(self.btnView).offset(-MARGIN_W_15);
        make.width.mas_equalTo(AUTO_SCALE_W(64));
        make.height.mas_equalTo(AUTO_SCALE_H(36));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = color;
    [self.btnView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnView);
        make.bottom.equalTo(self.btnView);
        make.right.equalTo(self.btnView);
        make.height.mas_equalTo(0.5);
    }];
}

//tap
- (void)createTap {
    UITapGestureRecognizer *blackTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenDatePicker)];
    
    [self addGestureRecognizer:blackTap];
}

// 显示选择器
- (void)showDatePicker {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    CGRect frameContent =  self.contentView.frame;
    frameContent.origin.y -= self.contentView.frame.size.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.layer setOpacity:1.0];
        self.contentView.frame = frameContent;
    } completion:^(BOOL finished) {
        
    }];

}

// 隐藏选择器
- (void)hidenDatePicker {

    CGRect frameContent =  self.contentView.frame;
    frameContent.origin.y += self.contentView.frame.size.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.layer setOpacity:0.0];
        self.contentView.frame = frameContent;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - DatePicker Method

// 改变选择
- (void)datePickerChange:(UIDatePicker *)datePicker {
//    判断delegate 指向的类是否实现协议方法
    // 返回 NSDate
    if ([self.delegate respondsToSelector:@selector(changeSelectedDate:)]) {
        [self.delegate changeSelectedDate:datePicker.date];
    }
    
    // 返回 NSString
    if ([self.delegate respondsToSelector:@selector(changeSelectedDateString:)]) {
        [self.delegate changeSelectedDateString:[self stringFromDate:datePicker.date]];
    }
   
    
    self.selectLabel.text = [NSString stringWithFormat:@"%@ 岁", [NSDate getAgeWithDate:datePicker.date]];
}


#pragma mark - buttonMethod

// 取消选择
- (void)cancleButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cancelSelectedDate)]) {
        [self.delegate cancelSelectedDate];
    }
    [self hidenDatePicker];
}

// 确定选择
- (void)determineButtonClick:(UIButton *)sender {
    // 返回 NSDate
    if ([self.delegate respondsToSelector:@selector(determinSelectedDate:)]) {
        [self.delegate determinSelectedDate:self.datePicker.date];
    }
    
    // 返回 NSString
    if ([self.delegate respondsToSelector:@selector(determinSelectedDateString:)]) {
        [self.delegate determinSelectedDateString:[self stringFromDate:self.datePicker.date]];
    }
    
    [self hidenDatePicker];
}

//*
- (NSDate *)dateFromString:(NSString*)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (self.mode) {
        case UIDatePickerModeTime:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case UIDatePickerModeDate:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case UIDatePickerModeDateAndTime:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case UIDatePickerModeCountDownTimer:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        default:
            break;
    }
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
}

- (NSString *)stringFromDate:(NSDate*)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (self.mode) {
        case UIDatePickerModeTime:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case UIDatePickerModeDate:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case UIDatePickerModeDateAndTime:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case UIDatePickerModeCountDownTimer:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        default:
            break;
    }
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}
//*/


@end
