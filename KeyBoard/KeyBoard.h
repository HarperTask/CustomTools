//
//  KeyBoard.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol KeyBoardDelegate <NSObject>

@optional
/** 当键盘出现时调用 键盘大小  */
- (void)keyboardWillShow:(CGSize)keyboardSize;

/** 当键盘出现时调用 键盘大小 键盘出现动画的时间 */
- (void)keyboardWillShow:(CGSize)keyboardSize animationDuration:(NSTimeInterval)animationDuration;

/** 当键盘出现时调用 键盘事件的通知 */
- (void)keyboardWillShowNotification:(NSNotification *)notification;

/** 当键盘退出时调用 键盘大小 */
- (void)keyboardWillHide:(CGSize)keyboardSize;

/** 当键盘出现时调用 键盘大小 键盘消失动画的时间 */
- (void)keyboardWillHide:(CGSize)keyboardSize animationDuration:(NSTimeInterval)animationDuration;

/** 当键盘退出时调用 键盘事件的通知 */
- (void)keyboardWillHideNotification:(NSNotification *)notification;



@end

@interface KeyBoard : NSObject

/** 添加键盘监听 */
- (void)addMonitoringKeyboard;

/** 移除键盘监听 */
- (void)removeMonitoringKeyboard;

@property (nonatomic, weak) id <KeyBoardDelegate> delegate;

@end
