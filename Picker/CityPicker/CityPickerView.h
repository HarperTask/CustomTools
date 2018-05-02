//
//  CityPickerView.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STPickerView.h"
NS_ASSUME_NONNULL_BEGIN
@class CityPickerView;
@protocol  CityPickerViewDelegate <NSObject>

/** 确定选择 */
- (void)cityPickerView:(CityPickerView *)cityPickerView province:(NSString *)province city:(NSString *)city area:(NSString *)area;

@end
@interface CityPickerView : STPickerView
/** 1.中间选择框的高度，default is 32*/
@property(nonatomic, assign) CGFloat heightPickerComponent;
/** 2.保存之前的选择地址，default is NO */
@property(nonatomic, assign, getter=isSaveHistory)BOOL saveHistory;

@property(nonatomic, weak)id <CityPickerViewDelegate>delegate;

@end
NS_ASSUME_NONNULL_END
