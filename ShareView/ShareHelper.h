//
//  ShareHelper.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//
//  用于实现系统分享


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ShareHelperShareType)
{
    ShareHelperShareTypeOthers,//其他
    ShareHelperShareTypeWeChat,//微信
    ShareHelperShareTypeQQ,//腾讯QQ
    ShareHelperShareTypeSina,//新浪微博
    
};
@interface ShareHelper : NSObject

/**
 单例

 @return 返回单例的 ShareHelper
 */
+ (instancetype)shareHelper;


+ (BOOL)shareWithType:(ShareHelperShareType)type andController:(UIViewController *)controller andFilePath:(NSString *)path;
+ (BOOL)shareWithType:(ShareHelperShareType)type andController:(UIViewController *)controller andFileURL:(NSURL *)url;

/**
 分享方法

 @param type 分享类型
 @param controller 展示的控制器
 @param items 所有的分享对象 可以包括的类型是<UIimage NSURL>两种类型
 @return 返回分享结果 如果是No表示没有安装,请自行处理.
 */
+ (BOOL)shareWithType:(ShareHelperShareType)type andController:(UIViewController *)controller andItems:(NSArray *)items;

- (BOOL)shareWithType:(ShareHelperShareType)type andController:(UIViewController *)controller andItems:(NSArray *)items;


@end
