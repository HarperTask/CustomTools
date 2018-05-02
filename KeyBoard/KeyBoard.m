//
//  KeyBoard.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "KeyBoard.h"


@implementation KeyBoard

// 添加键盘监听
- (void)addMonitoringKeyboard {
    
    // 增加监听，当键盘出现时或改变时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    // 增加监听，当键盘退出时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

// 当键盘出现时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [userInfo [UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 键盘大小
    CGSize keyboardSize = [aValue CGRectValue].size;
    if ([self.delegate respondsToSelector:@selector(keyboardWillShow:)]) {
        [self.delegate keyboardWillShow:keyboardSize];
    }
    
    // 键盘大小 动画时间
    if ([self.delegate respondsToSelector:@selector(keyboardWillShow:animationDuration:)]) {
        [self.delegate keyboardWillShow:keyboardSize animationDuration:animationDuration];
    }
    
    // 键盘通知
    if ([self.delegate respondsToSelector:@selector(keyboardWillShowNotification:)]) {
        [self.delegate keyboardWillShowNotification:aNotification];
    }
}

// 当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [userInfo [UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 键盘大小
    CGSize keyboardSize = [aValue CGRectValue].size;
    if ([self.delegate respondsToSelector:@selector(keyboardWillHide:)]) {
        [self.delegate keyboardWillHide:keyboardSize];
    }
    
    // 键盘大小 动画时间
    if ([self.delegate respondsToSelector:@selector(keyboardWillHide:animationDuration:)]) {
        [self.delegate keyboardWillHide:keyboardSize animationDuration:animationDuration];
    }
    
    // 键盘通知
    if ([self.delegate respondsToSelector:@selector(keyboardWillHideNotification:)]) {
        [self.delegate keyboardWillHideNotification:aNotification];
    }
}

// 移除键盘监听
- (void)removeMonitoringKeyboard {
    
    // 增加监听，当键盘出现时或改变时
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    // 增加监听，当键盘退出时UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

@end
