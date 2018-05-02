//
//  ImagePickerController.h
//  ImagePickerController
//
//  Created by Johnil on 15-7-3.
//  Copyright (c) 2015年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetHelper.h"
#import "ImageManager.h"

@interface ImagePickerController : UINavigationController

- (ImagePickerController *)initWithPreviewIndex:(NSInteger)index ;

@property (nonatomic, weak) id pickerDelegate;
@property (nonatomic ,strong) NSMutableArray *arr;
/**
 当退出编辑模式时需调用clear，用来清理内存，已选择照片的缓存
 **/
+ (void)clear;
+ (void)setMaxCount:(NSInteger)maxCount;
- (UIToolbar *)customToolbar;
- (void)setLeftTitle:(NSString *)title;
- (void)cancel;

- (NSArray *)imagesWithType:(NSInteger)type;
- (NSArray *)assets;

@end

@protocol ImagePickerDelegate <NSObject>

- (void)imagePickerDidFinished:(ImagePickerController *)picker;
- (void)imagePickerDidCancel:(ImagePickerController *)picker;

@end
