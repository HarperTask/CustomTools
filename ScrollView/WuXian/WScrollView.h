//
//  WScrollView.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@class WScrollView;
@protocol WScrollViewDelegate <NSObject>

@optional
- (void)scrollImage:(WScrollView *)WScrollView clickedAtIndex:(NSInteger)index;

@end

@interface WScrollView : UIViewController

@property (nonatomic, weak) id<WScrollViewDelegate> delegate;

@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong) UIPageControl  *pageControl;
@property (nonatomic, strong) UIImage        *placeholderImage;

- (instancetype)initWithCurrentController:(UIViewController *)viewcontroller urlString:(NSArray *)urls viewFrame:(CGRect)frame placeholderImage:(UIImage *)image;

@end



