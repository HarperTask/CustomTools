//
//  DatePickerView.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger,DatePickerMode) {
    
    /** HH:mm 5 */
    DatePickerModeHHMM,
    /** HH:mm:ss 8 */
    DatePickerModeHHMMSS,
    /** yyyy-MM-dd 10 */
    DatePickerModeYYMMDD,
    /** yyyyMMdd 8 */
    DatePickerModeYYMMDDs,
    /** yyyy-MM-dd HH 13 */
    DatePickerModeYYMMDDHH,
    /** yyyyMMddHH 10 */
    DatePickerModeYYMMDDHHs,
    /** yyyy-MM-dd HH:mm 16 */
    DatePickerModeYYMMDDHHMM,
    /** yyyyMMddHHmm 12 */
    DatePickerModeYYMMDDHHMMs,
    /** yyyy-MM-dd HH:mm:ss 19 */
    DatePickerModeYYMMDDHHMMSS,
    /** yyyyMMddHHmmss 14 */
    DatePickerModeYYMMDDHHMMSSs,
    
    
};

@protocol DatePickerViewDelegate <NSObject>

@optional
/** 改变选择 - 返回 NSDate */
- (void)changeSelectedDate:(NSDate *)date;

/** 改变选择 - 返回 dateString */
- (void)changeSelectedDateString:(NSString *)dateString;

/** 确定选择 - 返回 NSDate  */
- (void)determinSelectedDate:(NSDate *)date;

/** 确定选择 - 返回 dateString  */
- (void)determinSelectedDateString:(NSString *)dateString;

/** 取消选择 */
- (void)cancelSelectedDate;


@end

@interface DatePickerView : UIView

@property (nonatomic, weak)id<DatePickerViewDelegate> delegate;

/** 类方法创建日期选择器 */
+ (instancetype)datePickerViewWithPickerMode:(UIDatePickerMode)mode minimumDate:(NSDate *)minimumDate delegate:(id)delegate;
/** 类方法创建日期选择器 - 有默认日期  */
+ (instancetype)datePickerViewWithPickerMode:(UIDatePickerMode)mode currentDate:(NSDate *)currentDate minimumDate:(NSDate *)minimumDate delegate:(id)delegate;

/** 实例方法创建日期选择器 */
- (instancetype)initWithFrame:(CGRect)frame pickerMode:(UIDatePickerMode)mode minimumDate:(NSDate *)minimumDate delegate:(id)delegate;
/** 实例方法创建日期选择器 - 有默认日期  */
- (instancetype)initWithFrame:(CGRect)frame pickerMode:(UIDatePickerMode)mode currentDate:(NSDate *)currentDate minimumDate:(NSDate *)minimumDate delegate:(id)delegate;

- (void)showDatePicker;

//// NSDate <-- NSString
//- (NSDate *)dateFromString:(NSString*)dateString;
//
//// NSDate --> NSString
//- (NSString *)stringFromDate:(NSDate*)date;

@end
