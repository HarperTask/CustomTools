//
//  ShareHelper.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "ShareHelper.h"
#import <Social/Social.h>

@interface ShareHelper()


@end
@implementation ShareHelper

static ShareHelper * shareHelper;


#pragma mark - 单例

+ (instancetype)shareHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareHelper = [[ShareHelper alloc]init];
    });
    return shareHelper;
}


#pragma mark - Public

/** 分享单个文件 */
+ (BOOL)shareWithType:(ShareHelperShareType)type andController:(UIViewController *)controller andFilePath:(NSString *)path{
    return [ShareHelper shareWithType:type andController:controller andFileURL:[NSURL fileURLWithPath:path]];
}

/** 分享单个文件 */
+ (BOOL)shareWithType:(ShareHelperShareType)type andController:(UIViewController *)controller andFileURL:(NSURL *)url{
   return [ShareHelper shareWithType:type andController:controller andItems:@[url]];
}

/** 多图 多文件 */
+ (BOOL)shareWithType:(ShareHelperShareType)type andController:(UIViewController *)controller andItems:(NSArray *)items{
    return [[ShareHelper shareHelper]shareWithType:type andController:controller andItems:items];
}

- (BOOL)shareWithType:(ShareHelperShareType)type andController:(UIViewController *)controller andItems:(NSArray *)items{

    //判断分享类型
    if(type==0){
        UIActivityViewController * activityCtl = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
        [controller presentViewController:activityCtl animated:YES completion:nil];
        return YES;
    }
    
    NSString * serviceType = [self serviceTypeWithType:type];
    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:serviceType];
    // 添加要分享的图片
    
    for ( id obj in items){
        if ([obj isKindOfClass:[UIImage class]]){
            [composeVC addImage:(UIImage *)obj];
        }else if ([obj isKindOfClass:[NSURL class]]){
            [composeVC addURL:(NSURL *)obj];
        }
    }

    // 添加要分享的文字
    [composeVC setInitialText:@"分享"];

    // 弹出分享控制器
    composeVC.completionHandler = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultDone) {
            XHBLOG(@"点击了发送");
        }
        else if (result == SLComposeViewControllerResultCancelled)
        {
            XHBLOG(@"点击了取消");
        }
    };
    
    @try{
        [controller presentViewController:composeVC animated:YES completion:nil];
        return YES;
    } @catch (NSException *exception){
        XHBLOG(@"没有安装");
        return NO;
    } @finally {
        
    }
    
    return YES;
}


#pragma mark - Private

- (NSString *)serviceTypeWithType:(ShareHelperShareType)type{
    // 选择系统分享时 这个方法不再进行校验,传入就不等于0.这里做一个转换
    NSString * serviceType;
    if ( type!= 0){
        switch (type){
            case ShareHelperShareTypeWeChat:
                serviceType = @"com.tencent.xin.sharetimeline";
                break;
            case ShareHelperShareTypeQQ:
                serviceType = @"com.tencent.mqq.ShareExtension";
                break;
            case ShareHelperShareTypeSina:
                serviceType = @"com.apple.share.SinaWeibo.post";
                break;
            default:
                break;
        }
    }
    return serviceType;
}

/*
 <NSExtension: 0x1741735c0> {id = com.apple.share.Flickr.post}",
 "<NSExtension: 0x174173740> {id = com.taobao.taobao4iphone.ShareExtension}",
 "<NSExtension: 0x174173a40> {id = com.apple.reminders.RemindersEditorExtension}",
 "<NSExtension: 0x174173bc0> {id = com.apple.share.Vimeo.post}",
 "<NSExtension: 0x174173ec0> {id = com.apple.share.Twitter.post}",
 "<NSExtension: 0x174174040> {id = com.apple.mobileslideshow.StreamShareService}",
 "<NSExtension: 0x1741741c0> {id = com.apple.Health.HealthShareExtension}",
 "<NSExtension: 0x1741744c0> {id = com.apple.mobilenotes.SharingExtension}",
 "<NSExtension: 0x174174640> {id = com.alipay.iphoneclient.ExtensionSchemeShare}",
 "<NSExtension: 0x174174880> {id = com.apple.share.Facebook.post}",
 "<NSExtension: 0x174174a00> {id = com.apple.share.TencentWeibo.post}
 */

/*
 "<NSExtension: 0x174174340> {id = com.tencent.xin.sharetimeline}", //微信
 "<NSExtension: 0x174173d40> {id = com.tencent.mqq.ShareExtension}", //QQ
 "<NSExtension: 0x1741738c0> {id = com.apple.share.SinaWeibo.post}", //微博
 */

@end
