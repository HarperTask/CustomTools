//
//  XKeyboardInputView.h
//  XKeyboardInputViewExample
//
//  Created by zhuxiaohui on 2017/10/20.
//  Copyright © 2017年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHInputView

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,InputViewStyle) {
    /** 单行输入框，自动适配高度 */
    InputViewStyleDefault,
    /** 固定输入框高度， */
    InputViewStyleLarge,
};

@class XKeyboardInputView;

@protocol XKeyboardInputViewDelagete <NSObject>
@optional

/**
//如果你工程中有配置IQKeyboardManager,并对XKeyboardInputView造成影响,
 请在XKeyboardInputView将要显示代理方法里 将IQKeyboardManager的enableAutoToolbar及enable属性 关闭
 请在XKeyboardInputView将要消失代理方法里 将IQKeyboardManager的enableAutoToolbar及enable属性 打开
 如下:
 
//XKeyboardInputView 将要显示
-(void)xKeyboardInputViewWillShow:(XKeyboardInputView *)inputView{
 [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
 [IQKeyboardManager sharedManager].enable = NO;
}

//XKeyboardInputView 将要影藏
-(void)xKeyboardInputViewWillHide:(XKeyboardInputView *)inputView{
     [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
     [IQKeyboardManager sharedManager].enable = YES;
}
*/

/**
 XKeyboardInputView 将要显示
 
 @param inputView inputView
 */
-(void)xKeyboardInputViewWillShow:(XKeyboardInputView *)inputView;

/**
 XKeyboardInputView 将要影藏

 @param inputView inputView
 */
-(void)xKeyboardInputViewWillHide:(XKeyboardInputView *)inputView;

@end

@interface XKeyboardInputView : UIView

@property (nonatomic, assign) id<XKeyboardInputViewDelagete> delegate;

/** 最大输入字数 */
@property (nonatomic, assign) NSInteger maxCount;
/** 输入框字体 */
@property (nonatomic, strong) UIFont *font;
/** 输入框占位符 */
@property (nonatomic, copy) NSString *placeholder;
/** 输入框占位符颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
/** 输入框背景颜色 */
@property (nonatomic, strong) UIColor *textViewBackgroundColor;

/** 发送按钮字体 */
@property (nonatomic, strong) UIFont *sendButtonFont;
/** 发送按钮标题 */
@property (nonatomic, copy) NSString *sendButtonTitle;
/** 发送按钮字体颜色 */
@property (nonatomic, strong) UIColor *sendButtonTitleColor;
/** 发送按钮背景色 */
@property (nonatomic, strong) UIColor *sendButtonBackgroundColor;
/** 发送按钮圆角大小 */
@property (nonatomic, assign) CGFloat sendButtonCornerRadius;



/**
 显示输入框

 @param style 类型
 @param configurationBlock 请在此block中设置XKeyboardInputView属性
 @param sendBlock 发送按钮点击回调
 */
+(void)showWithStyle:(InputViewStyle)style configurationBlock:(void(^)(XKeyboardInputView *inputView))configurationBlock sendBlock:(BOOL(^)(NSString *text))sendBlock;

@end
