//
//  AlertView.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AlertView : NSObject

/**
 屏幕中心提示(没有按钮)

 @param title 标题
 @param message 提示内容
 */
+ (void)showSystemCenterDisappearTitle:(NSString *)title message:(NSString *)message;

/**
 屏幕中心提示(一个按钮)

 @param title 标题
 @param message 提示内容
 @param selectTitle 按钮标题
 */
+ (void)showSystemCenterTitle:(NSString *)title message:(NSString *)message selectTitle:(NSString *)selectTitle;

/**
 屏幕中心提示(一个按钮, 按钮事件回调)

 @param title 标题
 @param message 提示内容
 @param selectTitle 按钮标题
 @param selectCompletion 按钮事件回调
 */
+ (void)showSystemCenterTitle:(NSString *)title message:(NSString *)message
                   selectTitle:(NSString *)selectTitle selectCompletion:(void (^)(void))selectCompletion;

/**
 屏幕中心提示(两个按钮, 按钮事件回调)

 @param title 标题
 @param message 提示内容
 @param leftSelectTitle 左侧按钮标题
 @param leftCompletion 左侧按钮事件回调
 @param rightSelectTitle 右侧按钮标题
 @param rightCompletion 右侧按钮事件回调
 */
+ (void)showSystemCenterTitle:(NSString *)title message:(NSString *)message
               leftSelectTitle:(NSString *)leftSelectTitle leftCompletion:(void (^)(void))leftCompletion
              rightSelectTitle:(NSString *)rightSelectTitle rightCompletion:(void (^)(void))rightCompletion;

/**
 屏幕下放下方提示(一个按钮)

 @param title 标题
 @param message 提示内容
 @param selectTitle 按钮标题
 */
+ (void)showSystemBottomTitle:(NSString *)title message:(NSString *)message selectTitle:(NSString *)selectTitle;


/**
 屏幕下放下方提示(一个按钮, 按钮事件回调)

 @param title 标题
 @param message 提示内容
 @param selectTitle 按钮标题
 @param selectCompletion 按钮事件回调
 */
+ (void)showSystemBottomTitle:(NSString *)title message:(NSString *)message
                   selectTitle:(NSString *)selectTitle selectCompletion:(void (^)(void))selectCompletion;

/**
 屏幕下放下方提示(一个事件按钮，一个取消按钮, 按钮事件回调)
 
 @param title 标题
 @param message 提示内容
 @param selectTitle 按钮标题
 @param selectCompletion 按钮事件回调
 @param cancelSelectTitle 取消按钮标题
 @param cancelCompletion 取消按钮事件回调
 */
+ (void)showSystemBottomTitle:(NSString *)title message:(NSString *)message
                   selectTitle:(NSString *)selectTitle selectCompletion:(void (^)(void))selectCompletion
             cancelSelectTitle:(NSString *)cancelSelectTitle cancelCompletion:(void(^)(void))cancelCompletion;

/**
 屏幕下放下方提示(两个事件按钮，一个取消按钮, 按钮事件回调)

 @param title 标题
 @param message 提示内容
 @param topSelectTitle 上方按钮标题
 @param topCompletion 上方按钮事件回调
 @param bottomSelectTitle 下方按钮标题
 @param bottomCompletion 下方按钮事件回调
 @param cancelSelectTitle 取消按钮标题
 @param cancelCompletion 取消按钮事件回调
 */
+ (void)showSystemBottomTitle:(NSString *)title message:(NSString *)message
               topSelectTitle:(NSString *)topSelectTitle topCompletion:(void(^)(void))topCompletion
              bottomSelectTitle:(NSString *)bottomSelectTitle bottomCompletion:(void(^)(void))bottomCompletion
             cancelSelectTitle:(NSString *)cancelSelectTitle cancelCompletion:(void(^)(void))cancelCompletion;

/**
 屏幕下放下方提示(三个事件按钮，一个取消按钮, 按钮事件回调)
 
 @param title 标题
 @param message 提示内容
 @param topSelectTitle 上方按钮标题
 @param topCompletion 上方按钮事件回调
 @param centerSelectTitle 中间按钮标题
 @param centerCompletion 中间按钮事件回调
 @param bottomSelectTitle 下方按钮标题
 @param bottomCompletion 下方按钮事件回调
 @param cancelSelectTitle 取消按钮标题
 @param cancelCompletion 取消按钮事件回调
 */
+ (void)showSystemBottomTitle:(NSString *)title message:(NSString *)message
                topSelectTitle:(NSString *)topSelectTitle topCompletion:(void (^)(void))topCompletion
             centerSelectTitle:(NSString *)centerSelectTitle centerCompletion:(void(^)(void))centerCompletion
             bottomSelectTitle:(NSString *)bottomSelectTitle bottomCompletion:(void(^)(void))bottomCompletion
             cancelSelectTitle:(NSString *)cancelSelectTitle cancelCompletion:(void(^)(void))cancelCompletion;

/**
 获取权限(两个按钮)

 @param name 权限名称
 */
+ (void)showSystemPermissionsName:(NSString *)name;


/**
 获取权限(两个按钮)

 @param name 权限名称
 @param controller 获取权限的界面
 */
+ (void)showSystemPermissionsName:(NSString *)name inController:(UIViewController *)controller;

///** 正常提示(屏幕中心) */
//+ (void)showCustomDisappear:(NSString *)message inController:(UIViewController *)controller;
//
///** 正常提示(自定义中心) */
//+ (void)showCustomDisappear:(NSString *)message inController:(UIViewController *)controller Center:(CGPoint)center;


/** SVProgressHUD (延迟一秒消失) 没有背景，可以交互 */
+ (void)showSVPErrorDisappear:(NSString *)message;

/** SVProgressHUD (延迟一秒消失) 没有背景，可以交互  */
+ (void)showSVPSuccessDisappear:(NSString *)message;

/** SVProgressHUD (白色背景提示框) */
+ (void)showSVPWhiteStatus:(NSString *)message;

/** SVProgressHUD (灰色背景提示框) */
+ (void)showSVPDarkStatus:(NSString *)message;

/** SVProgressHUD (白色背景提示框 延迟一秒消失) */
+ (void)showSVPWhiteDisappear:(NSString *)message;

/** SVProgressHUD (灰色背景提示框 延迟一秒消失) */
+ (void)showSVPDarkDisappear:(NSString *)message;

/** SVProgressHUD (显示图片和文字) */
+ (void)showSVPDisappearImage:(NSString *)imageName status:(NSString *)status;

@end
