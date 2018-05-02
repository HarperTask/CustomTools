//
//  DragDropView.m
//  CMe
//
//  Created by OS X on 2018/4/24.
//  Copyright © 2018年 杭州石匍丁科技公司. All rights reserved.
//

#import "DragDropView.h"

@interface DragDropView ()

@property (nonatomic, assign) DragDropViewTouchType touchType;
@property (nonatomic, assign) DragDropViewAsideType asideType;
@end

@implementation DragDropView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame touchType:(DragDropViewTouchType)touchType asideType:(DragDropViewAsideType)asideType {
    self = [super initWithFrame:frame];
    if (self) {
        _touchType = touchType;
        _asideType = asideType;
        
        //添加拖拽手势-改变控件的位置
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePostion:)];
        [self addGestureRecognizer:pan];
        
        [self createView];
    }
    
    return self;
}


- (void)createView {
    
}


- (void)changePostion:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self];
    
    CGRect originalFrame = self.frame;
    switch (_touchType) {
        case DragDropViewTouchTypeNone: {
            originalFrame = [self changeXWithFrame:originalFrame point:point];
            originalFrame = [self changeYWithFrame:originalFrame point:point];
           
        }
            break;
            
        case DragDropViewTouchTypeVerticalScroll:{
            originalFrame = [self changeYWithFrame:originalFrame point:point];
            
        }
            break;
            
        case DragDropViewTouchTypeHorizontalScroll:{
            originalFrame = [self changeXWithFrame:originalFrame point:point];
            
        }
            break;
        
    }
    
    // 移动的时候修改坐标
    self.frame = originalFrame;
    
    [pan setTranslation:CGPointZero inView:self];
    

    if (pan.state == UIGestureRecognizerStateBegan) {
        XHBLOG(@"开始");
    }
    else if (pan.state == UIGestureRecognizerStateChanged) {
//        XHBLOG(@"改变");
    }
    else {
        XHBLOG(@"结束");
        
        CGRect frame = self.frame;
        
        // 移动结束后，看是否超出指定范围，超出就移回来
//        BOOL isOver = NO;
        
        // 超出屏幕左侧范围
        if (frame.origin.x < MARGIN_W_15) {
            frame.origin.x = MARGIN_W_15;
//            isOver = YES;
            
        }
        // 超出屏幕右侧范围
        else if (frame.origin.x + frame.size.width > SCREEN_WIDTH - MARGIN_W_15) {
            frame.origin.x = SCREEN_WIDTH - frame.size.width - MARGIN_W_15;
//            isOver = YES;
        }
        
//        // 超出屏幕上侧范围
//        if (frame.origin.y < 0) {
//            frame.origin.y = 0;
//            isOver = YES;
//
//        }
//        // 超出屏幕下侧范围
//        else if (frame.origin.y+frame.size.height > SCREEN_HEIGHT) {
//            frame.origin.y = SCREEN_HEIGHT - frame.size.height - NAVIGATION_HEIGHT;
//            isOver = YES;
//        }

        
        // 超出上侧导航范围
        if (frame.origin.y < NAVIGATION_HEIGHT) {
            frame.origin.y = NAVIGATION_HEIGHT + MARGIN_W_15;
//            isOver = YES;
            
        }
        // 超出下侧导航范围
        else if (frame.origin.y+frame.size.height > SCREEN_HEIGHT-TABBAR_HEIGHT-BOTTOM_HEIGHT) {
            frame.origin.y = SCREEN_HEIGHT - frame.size.height - TABBAR_HEIGHT - BOTTOM_HEIGHT - MARGIN_W_15;
//            isOver = YES;
        }
        
        
        // 自动靠边
        switch (_asideType) {
            case DragDropViewAsideTypeNone:
                
                break;
                
            case DragDropViewAsideTypeLeft:
                frame.origin.x = MARGIN_W_15;
                
                break;
                
            case DragDropViewAsideTypeRight:
                frame.origin.x = frame.origin.x = SCREEN_WIDTH - frame.size.width - MARGIN_W_15;
                
                break;
                
            case DragDropViewAsideTypeLeftRight:
                if (frame.origin.x + frame.size.width/2 < SCREEN_WIDTH/2) {
                    frame.origin.x = MARGIN_W_15;
                }
                else {
                     frame.origin.x = frame.origin.x = SCREEN_WIDTH - frame.size.width - MARGIN_W_15;
                }
                
                break;

            default:
                break;
        }
        
    
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = frame;
        }];

    }
}

// 拖动改变控件的水平方向x值
- (CGRect)changeXWithFrame:(CGRect)originalFrame point:(CGPoint)point {
    BOOL q1 = originalFrame.origin.x >= 0;
    BOOL q2 = originalFrame.origin.x + originalFrame.size.width <= SCREEN_WIDTH;
    
    if (q1 && q2) {
        originalFrame.origin.x += point.x;
    }
    
    return originalFrame;
}

// 拖动改变控件的竖直方向y值
- (CGRect)changeYWithFrame:(CGRect)originalFrame point:(CGPoint)point {
    
    BOOL q1 = originalFrame.origin.y >= 0;
    BOOL q2 = originalFrame.origin.y + originalFrame.size.height <= SCREEN_HEIGHT;
    if (q1 && q2) {
        originalFrame.origin.y += point.y;
    }
    
    return originalFrame;
}

@end
