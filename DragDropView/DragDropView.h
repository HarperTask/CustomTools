//
//  DragDropView.h
//  CMe
//
//  Created by OS X on 2018/4/24.
//  Copyright © 2018年 杭州石匍丁科技公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DragDropViewTouchType) {
    /** 随便移动，修改中心点 (x,y) */
    DragDropViewTouchTypeNone = 0,
    /** 垂直移动，修改纵坐标 y */
    DragDropViewTouchTypeVerticalScroll,
    /** 水平移动，修改横坐标 x */
    DragDropViewTouchTypeHorizontalScroll,
    
};


typedef NS_ENUM(NSInteger, DragDropViewAsideType) {
    /** 随便移动，不自动靠边 */
    DragDropViewAsideTypeNone = 0,
    /** 随便移动，自动左边靠边 */
    DragDropViewAsideTypeLeft,
    /** 随便移动，自动右靠边 */
    DragDropViewAsideTypeRight,
    /** 随便移动，中心分割，左边或者右边 */
    DragDropViewAsideTypeLeftRight,
    
};


@interface DragDropView : UIView

/**
 创建一个可拖动按钮

 @param frame frame
 @param touchType 滑动类型
 @param asideType 靠边类型
 @return 可拖动试图
 */
- (instancetype)initWithFrame:(CGRect)frame touchType:(DragDropViewTouchType)touchType asideType:(DragDropViewAsideType)asideType;

//title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage;


@end
