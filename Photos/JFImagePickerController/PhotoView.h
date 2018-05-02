//
//  PhotoView.h
//  ImagePickerController
//
//  Created by Johnil on 15-7-3.
//  Copyright (c) 2015年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoView : UIScrollView <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, weak) id photoDelegate;

- (void)reloadRotate;
- (void)reset;
- (void)clearMemory;
- (void)loadImage:(ALAsset *)asset;

@end

@protocol PhotoDelegate <NSObject>

- (void)tap;

@end
