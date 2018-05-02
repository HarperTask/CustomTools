//
//  SinglePickerView.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SinglePickerView;
@protocol SinglePickerViewDelegate <NSObject>

@optional
/** 改变选择 */
- (void)changeSinglePickerView:(SinglePickerView *)singlePickerView selectStr:(NSString *)selectStr;

/** 确定选择 */
- (void)determinSinglePickerView:(SinglePickerView *)singlePickerView selectStr:(NSString *)selectStr;

/** 取消选择 */
- (void)cancelSinglePickerView:(SinglePickerView *)singlePickerView;

@end

@interface SinglePickerView : UIView

@property (nonatomic, weak) id <SinglePickerViewDelegate> delegate;

@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) UIPickerView *picker;

/** 初始化选择器 */
- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate;

/** 显示选择器 */
- (void)showSinglePickerView;

/** 隐藏选择器 */
- (void)hiddenSinglePickerView;


@end
