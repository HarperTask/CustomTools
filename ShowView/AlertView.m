//
//  Show.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "AlertView.h"
#import "AppDelegate.h"

@implementation AlertView


#pragma mark - 系统提示框

/**
 屏幕中心提示(没有按钮)
 
 @param title 标题
 @param message 提示内容
 */
+ (void)showSystemCenterDisappearTitle:(NSString *)title message:(NSString *)message {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [delegate.window.rootViewController presentViewController:alert animated:YES completion:^{
        [UIView animateWithDuration:5.0 animations:^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}

/**
 屏幕中心提示(一个按钮)
 
 @param title 标题
 @param message 提示内容
 @param selectTitle 按钮标题
 */
+ (void)showSystemCenterTitle:(NSString *)title message:(NSString *)message selectTitle:(NSString *)selectTitle {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *selectAction = [UIAlertAction actionWithTitle:selectTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:selectAction];
    
    
    [delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

/**
 屏幕中心提示(一个按钮, 按钮事件回调)
 
 @param title 标题
 @param message 提示内容
 @param selectTitle 按钮标题
 @param selectCompletion 按钮事件回调
 */
+ (void)showSystemCenterTitle:(NSString *)title message:(NSString *)message
                   selectTitle:(NSString *)selectTitle selectCompletion:(void (^)(void))selectCompletion {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *selectAction = [UIAlertAction actionWithTitle:selectTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            selectCompletion();
        });
    }];
    
    [alert addAction:selectAction];
    
    
    [delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

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
              rightSelectTitle:(NSString *)rightSelectTitle rightCompletion:(void (^)(void))rightCompletion {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:leftSelectTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            leftCompletion();
        });
    }];
    
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rightSelectTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            rightCompletion();
        });
    }];
    
    [alert addAction:leftAction];
    [alert addAction:rightAction];
    
    
    [delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

/**
 屏幕下放下方提示(一个按钮)
 
 @param title 标题
 @param message 提示内容
 @param selectTitle 按钮标题
 */
+ (void)showSystemBottomTitle:(NSString *)title message:(NSString *)message selectTitle:(NSString *)selectTitle {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:selectTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    
    [delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

/**
 屏幕下放下方提示(一个按钮, 按钮事件回调)
 
 @param title 标题
 @param message 提示内容
 @param selectTitle 按钮标题
 @param selectCompletion 按钮事件回调
 */
+ (void)showSystemBottomTitle:(NSString *)title message:(NSString *)message
                   selectTitle:(NSString *)selectTitle selectCompletion:(void (^)(void))selectCompletion {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:selectTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            selectCompletion();
        });
    }]];
    
    
    [delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

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
             cancelSelectTitle:(NSString *)cancelSelectTitle cancelCompletion:(void(^)(void))cancelCompletion {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *selectAction = [UIAlertAction actionWithTitle:selectTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            selectCompletion();
        });
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelSelectTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cancelCompletion();
        });
    }];
    
    [alert addAction:selectAction];
    [alert addAction:cancelAction];
    
    [delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

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
             cancelSelectTitle:(NSString *)cancelSelectTitle cancelCompletion:(void(^)(void))cancelCompletion {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *topAction = [UIAlertAction actionWithTitle:topSelectTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            topCompletion();
        });
    }];
    
    UIAlertAction *bottomAction = [UIAlertAction actionWithTitle:bottomSelectTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            bottomCompletion();
        });
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelSelectTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cancelCompletion();
        });
    }];
    
    [alert addAction:topAction];
    [alert addAction:bottomAction];
    [alert addAction:cancelAction];
    
    [delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

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
             cancelSelectTitle:(NSString *)cancelSelectTitle cancelCompletion:(void(^)(void))cancelCompletion {
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIAlertController *AlertSelect = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *topAction = [UIAlertAction actionWithTitle:topSelectTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            topCompletion();
        });
    }];
    
    UIAlertAction *centerAction = [UIAlertAction actionWithTitle:centerSelectTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            centerCompletion();
        });
    }];
    
    UIAlertAction *bottomAction = [UIAlertAction actionWithTitle:bottomSelectTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            bottomCompletion();
        });
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelSelectTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cancelCompletion();
        });
    }];
    
    [AlertSelect addAction:topAction];
    [AlertSelect addAction:centerAction];
    [AlertSelect addAction:bottomAction];
    [AlertSelect addAction:cancelAction];
    
    [delegate.window.rootViewController presentViewController:AlertSelect animated:YES completion:nil];
    
}

#pragma mark - 获取权限
/**
 获取权限(两个按钮)
 
 @param name 权限名称
 */
+ (void)showSystemPermissionsName:(NSString *)name {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *titleStr = [NSString stringWithFormat:@"您还没有授权访问您的%@", name];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleStr message:@"是否去设置?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}



//  获取权限(两个按钮)
+ (void)showSystemPermissionsName:(NSString *)name inController:(UIViewController *)controller {
    NSString *titleStr = [NSString stringWithFormat:@"您还没有授权访问您的%@", name];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleStr message:@"是否去设置?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [controller presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark - 自定义提示框

//  正常提示(屏幕中心)
+ (void)showCustomDisappear:(NSString *)message inController:(UIViewController *)controller {
    [self showCustomDisappear:message inController:controller Center:controller.view.center];
}

//  正常提示(自定义中心)
+ (void)showCustomDisappear:(NSString *)message inController:(UIViewController *)controller Center:(CGPoint)center {
    
    CGSize size = [message getStringSize:CGSizeMake(SCREEN_WIDTH-30, 30) font:15.0];
    
    UIView *tishiView = [[UIView alloc]init];
    [Controls viewWith:tishiView frame:CGRectMake(0, 0, size.width+20, AUTO_SCALE_H(54)) backColor:k32_COLOR alpha:0.8 cornerRadius:AUTO_SCALE_H(5.0)];
    tishiView.center = center;
    
    UILabel *tishiLabel = [[UILabel alloc]init];
    [Controls labelWith:tishiLabel frame:CGRectMake(0, 0, FUNC_W(tishiView), FUNC_H(tishiView)) title:message titleColor:kWHITE_COLOR backColor:nil font:15.0 bold:NO cornerRadius:AUTO_SCALE_H(5.0)];
    
    tishiLabel.numberOfLines = 0;
    tishiLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:AUTO_SCALE_F(15.0)];
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    
    [tishiView addSubview:tishiLabel];
    
    
    [controller.navigationController.view addSubview:tishiView];
    
    [UIView animateWithDuration:2.0f animations:^{
        tishiView.alpha = 0;
    } completion:^(BOOL finished) {
        [tishiView removeFromSuperview];
    }];
    
}

#pragma mark - SVP提示框

/** SVProgressHUD (延迟一秒消失) 没有背景，可以交互 */
+ (void)showSVPErrorDisappear:(NSString *)message {
    
    [SVProgressHUD showErrorWithStatus:message];
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone]; // 没有背景，可以交互
    
    
    // 延时消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

}


/** SVProgressHUD (延迟一秒消失) */
+ (void)showSVPSuccessDisappear:(NSString *)message {
    
    [SVProgressHUD showSuccessWithStatus:message];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone]; // 没有背景，可以交互
    
    // 延时消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}


/** SVProgressHUD (白色背景提示框) */
+ (void)showSVPWhiteStatus:(NSString *)message {
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack]; // 有背景,不能交互
}


/** SVProgressHUD (灰色背景提示框) */
+ (void)showSVPDarkStatus:(NSString *)message {
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack]; // 有背景,不能交互
    
}

/** SVProgressHUD (白色背景提示框 延迟一秒消失) */
+ (void)showSVPWhiteDisappear:(NSString *)message {
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack]; // 有背景,不能交互
    
    // 延时消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

}

/** SVProgressHUD (灰色背景提示框 延迟一秒消失) */
+ (void)showSVPDarkDisappear:(NSString *)message {
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack]; // 有背景,不能交互
    
    // 延时消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

/** SVProgressHUD (显示图片和文字) */
+ (void)showSVPDisappearImage:(NSString *)imageName status:(NSString *)status {
    [SVProgressHUD showImage:[UIImage imageNamed:imageName] status:status];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    // 延时消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });


}

/** SVProgressHUD (没有灰色背景提示框 延迟一秒消失) */
+ (void)showSVPDisappear:(NSString *)message {
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack]; // 有背景,不能交互
    
    // 延时消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}



@end
