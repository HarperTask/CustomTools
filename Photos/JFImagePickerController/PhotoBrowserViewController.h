//
//  PhotoBrowserViewController.h
//  ImagePickerController
//
//  Created by Johnil on 15-7-3.
//  Copyright (c) 2015年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ImagePickerViewCell.h"
@interface PhotoBrowserViewController : UIViewController
@property (nonatomic, assign) NSInteger maxCount;
- (PhotoBrowserViewController *)initWithPreview;
- (PhotoBrowserViewController *)initWithNormal;
@property (nonatomic, weak) id delegate;

@end

@protocol PhotoBrowserDelegate <NSObject>

- (ALAsset *)assetWithIndex:(NSInteger)index fromPhotoBrowser:(PhotoBrowserViewController *)browser;
- (NSInteger)numOfPhotosFromPhotoBrowser:(PhotoBrowserViewController *)browser;
- (NSInteger)currentIndexFromPhotoBrowser:(PhotoBrowserViewController *)browser;
@optional
- (void)photoBrowser:(PhotoBrowserViewController *)browser didShowPage:(NSInteger)page;
- (ImagePickerViewCell *)cellForRow:(NSInteger)row;

@end
