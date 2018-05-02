//
//  RadarView.m
//  LQRadarChart
//
//  Created by OS X on 2018/2/8.
//  Copyright © 2018年 LiQuan. All rights reserved.
//

#import "RadarView.h"

@implementation RadarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _baseConfig];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self _baseConfig];
    }
    return self;
}

- (CGRect)frame {
    CGRect frame = [super frame];
    if (self.autoCenterPoint) {
//        self.centerPoint = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
//        self.centerPoint = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
//        self.centerPoint = self.center;
    }
//    _centerPoint = self.center;
    
    if (MIN(frame.size.width, frame.size.height) < self.radius * 2) {
        self.radius = MIN(frame.size.width, frame.size.height)/2.0;
    }
    
    [self reloadData];
    
    return frame;
}

- (void)_baseConfig {
    _radius = 80;
    _minValue = 0;
    _maxValue = 5;
    _numOfSetp = 2;
    _numOfRow = 3;
    _numOfSection = 1;
    
    _titleArray = @[@"1", @"2", @"3"];
    _valueArray = @[@"3", @"3", @"3"];
    
    _titleFont = 14;
    _borderColor = [UIColor redColor];
    _titleColor = [UIColor redColor];
    _fillStepColor = [UIColor clearColor];
    _fillBorderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    _fillColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
    
    _showPoint = true;
    _showBorder = true;
    _fillArea = true;
    _clockwise = false;
    _autoCenterPoint = true;
//    _centerPoint = self.center;
    _centerPoint = CGPointMake(self.center.x, self.center.y - AUTO_SCALE_H(20));
    
    [self reloadData];
    self.backgroundColor = [UIColor clearColor];
}

//
- (void)reloadData {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    UIFont *textFont = [UIFont boldSystemFontOfSize:_titleFont];
    CGFloat perAngle = (CGFloat)(M_PI * 2) / (CGFloat)(_numOfRow) * (CGFloat)(self.clockwise ? 1 : -1);
    CGFloat padding = (CGFloat)(2);
    CGFloat height = textFont.lineHeight;
    
    
    // 创建顶点
    for (NSInteger index = 0; index<_numOfRow; index ++) {
        NSInteger i = (CGFloat)index;
        NSString * title = _titleArray[index];
        CGPoint pointOnEdge = CGPointMake(_centerPoint.x - _radius * sin(i * perAngle),
                                          _centerPoint.y - _radius * cos(i * perAngle));
        CGSize attributeTextSize = [title sizeWithAttributes:@{NSFontAttributeName:textFont}];
        
        CGFloat width = attributeTextSize.width;
        CGFloat xOffset = pointOnEdge.x >=  _centerPoint .x ? width / 2.0 + padding : -width / 2.0 - padding;
        CGFloat yOffset = pointOnEdge.y >=  _centerPoint .y ? height / 2.0 + padding : -height / 2.0 - padding;
        CGPoint legendCenter = CGPointMake(pointOnEdge.x + xOffset,
                                           pointOnEdge.y + yOffset);
        
        NSMutableParagraphStyle *paragraphStyle = [NSParagraphStyle defaultParagraphStyle].mutableCopy;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        paragraphStyle.lineBreakMode = NSLineBreakByClipping;
        NSDictionary * attributes = @{NSFontAttributeName: textFont,
                                      NSParagraphStyleAttributeName: paragraphStyle,
                                      NSForegroundColorAttributeName:_titleColor};
        
        if (index == 0 || (_numOfRow % 2 == 0 && index == _numOfRow / 2.0)) {
            legendCenter.x = _centerPoint.x;
            legendCenter.y = _centerPoint.y + (_radius + padding + height) * (CGFloat)(index == 0 ? -1 : 1);
        }
     
//        CGRect rect = CGRectMake(legendCenter.x - width / 2.0, legendCenter.y - height/2.0, width, height);
        
        CGRect rect = CGRectMake(legendCenter.x - width / 2.0, legendCenter.y - height / 2.0, width, height);
        
        [title drawInRect:rect withAttributes:attributes];
    }
    
    /// Draw the background rectangle
    CGContextSaveGState(context);
    [self.borderColor setStroke];
    
    // 多边形填充颜色
    for (NSInteger stepTemp = 1; stepTemp <= _numOfSetp; stepTemp ++) {
        NSInteger step = _numOfSetp - stepTemp + 1;
        //        UIColor * fillColor = [_delegate colorOfFillStepForRadarChart:self step:step];
        UIColor *fillColor = self.fillStepColor;
        CGFloat scale = (CGFloat)((CGFloat)step / (CGFloat)_numOfSetp);
        CGFloat innserRadius = scale * _radius;
        UIBezierPath * path = [UIBezierPath bezierPath];
        for (NSInteger index = 0; index < _numOfRow; index ++) {
            CGFloat i = (CGFloat)index;
            if (index == 0) {
                CGFloat x = _centerPoint.x;
                CGFloat y = _centerPoint.y -  innserRadius ;
                [path moveToPoint:CGPointMake(x, y)];
            }else{
                CGFloat x = _centerPoint.x - innserRadius * sin(i * perAngle);
                CGFloat y = _centerPoint.y - innserRadius * cos(i * perAngle);
                [path addLineToPoint:CGPointMake(x, y)];
            }
        }
        CGFloat x = _centerPoint.x;
        CGFloat y = _centerPoint.y - innserRadius;
        [path addLineToPoint:CGPointMake(x, y)];
        
        
        [fillColor setFill];
        
        path.lineWidth = 1;
        [path  fill];
        [path stroke];
        
    }
    CGContextRestoreGState(context);
    
    [_borderColor setStroke];
    for (NSInteger index = 0; index < _numOfRow; index ++) {
        CGFloat i = (CGFloat)(index);
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:_centerPoint];
        CGFloat x = _centerPoint.x - _radius * sin(i * perAngle);
        CGFloat y = _centerPoint.y - _radius * cos(i * perAngle);
        [path addLineToPoint:CGPointMake(x, y)];
        [path stroke];
        
    }
    
    // 选定区域
    if (_numOfRow > 0) {
        for (NSInteger section = 0;section < _numOfSection; section ++) {
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            for (NSInteger index = 0; index < _numOfRow; index ++) {
                CGFloat i = (CGFloat)(index);
                CGFloat value = [_valueArray[index] floatValue];
                CGFloat scale = (value - _minValue)/(_maxValue - _minValue);
                CGFloat innserRadius = scale * _radius;
                
                // 选定区域顶点坐标
                CGFloat x;
                CGFloat y;
                if (index == 0 ){
                    x = _centerPoint.x;
                    y = _centerPoint.y -  innserRadius;
                    [path moveToPoint:CGPointMake(x, y)];
                } else {
                    x = _centerPoint.x - innserRadius * sin(i * perAngle);
                    y = _centerPoint.y - innserRadius * cos(i * perAngle);
                    [path addLineToPoint:CGPointMake(x, y)];
                }
                
                //////
                
                NSMutableParagraphStyle *paragraphStyle = [NSParagraphStyle defaultParagraphStyle].mutableCopy;
                paragraphStyle.alignment = NSTextAlignmentCenter;
                paragraphStyle.lineBreakMode = NSLineBreakByClipping;
                NSDictionary * attributes = @{NSFontAttributeName: textFont, NSParagraphStyleAttributeName: paragraphStyle,  NSForegroundColorAttributeName: _titleColor};
                
                NSString *title = [NSString stringWithFormat:@"%0.1f", value];
                CGSize attributeTextSize = [title sizeWithAttributes:@{NSFontAttributeName:textFont}];
                CGFloat width = attributeTextSize.width;
                CGPoint legendCenter;
                
                // 上顶点，和下顶点
                if (index == 0 || (_numOfRow % 2 == 0 && index == _numOfRow / 2.0)) {
                    legendCenter.x = x;
                    legendCenter.y = y + (padding + height / 2.0) *(CGFloat)(index == 0 ? -1 : 1);
                }
                // 左侧顶点
                else if (index > 0 && index >= _numOfRow / 2.0) {
                    legendCenter.x = x - (padding + width / 2.0) ;
                    legendCenter.y = y;
                }
                // 右侧顶点
                else {
                    legendCenter.x = x + (padding + width / 2.0);
                    legendCenter.y = y;
                }
                
                
                CGRect rect = CGRectMake(legendCenter.x - width / 2.0, legendCenter.y - height/2.0, width, height);
                [title drawInRect:rect withAttributes:attributes];
                
                //////
            }
            
            CGFloat value = [_valueArray[0] floatValue];
            CGFloat x = _centerPoint.x;
            CGFloat y = _centerPoint.y - (value - _minValue) / (_maxValue - _minValue) * _radius;
            [path addLineToPoint:CGPointMake(x, y)];
            
        
            [_fillColor setFill];
            [_fillBorderColor setStroke];
            
            path.lineWidth = 2;
            [path fill];
            [path stroke];
            
            
            
            if (self.showPoint) {
                
                for (NSInteger i = 0; i < _numOfRow; i ++) {
                    CGFloat value = [_valueArray[i] floatValue];
                    CGFloat xVal = _centerPoint.x - (value - _minValue) / (_maxValue - _minValue) * _radius * sin((CGFloat)(i) * perAngle);
                    CGFloat yVal = _centerPoint.y - (value - _minValue) / (_maxValue - _minValue) * _radius * cos((CGFloat)(i) * perAngle);
                    [_fillBorderColor setFill];
                    CGContextFillEllipseInRect(context, CGRectMake(xVal-3, yVal-3, 6, 6));
                    
                }
            }
        }
    }
    
}



@end
