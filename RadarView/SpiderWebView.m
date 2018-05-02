//
//  SpiderWebView.m
//  LffSpiderWebView
//
//  Created by tianNanYiHao on 2017/7/20.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SpiderWebView.h"
#import "DimensModel.h"


#define StrokeColor RGBA(180, 180, 180, 1).CGColor


//注意,此处一定要为float cos/sin 求正余弦均错误
#define radian(degress) (M_PI * (degress/180.f))

#define  itemScaleLineLenth(value,count) (value * radius)
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
@interface SpiderWebView ()
{
    
    //保存的frame
    CGRect rectSize;
    //前景网状View
    UIView *spiderWebView;
    //前景网状layer
    CAShapeLayer *spiderWebLayer;
    //中心点
    CGPoint centrePoint;
    //半径
    CGFloat radius;
    //边宽
    CGFloat strokeLineWith;
    
    float seconds;
    NSTimer *timer;
    NSArray *titleArray;
    NSArray *valueArray;
    
    UIColor *fillColor;
    
    //前景网状Layer路径
    UIBezierPath *path;
    
    //背景图 顺时针 六个点
    CGPoint point0;
    CGPoint point1;
    CGPoint point2;
    CGPoint point3;
    CGPoint point4;
    CGPoint point5;
    
    UILabel *valueA;
    UILabel *valueB;
    UILabel *valueC;
    UILabel *valueD;
    UILabel *valueE;
    UILabel *valueF;
    
    UILabel *titleA;
    UILabel *titleB;
    UILabel *titleC;
    UILabel *titleD;
    UILabel *titleE;
    UILabel *titleF;
}

/**
 前景网状layer所显示的最小阀值数组 固定值(0.1)
 */
@property (nonatomic, strong)NSArray *itemArray;
@end


@implementation SpiderWebView

//SingletonM(SpiderWebView)

#pragma mark - 实例化
//类方法实例化
+ (instancetype)createSpideWebViewWith:(CGRect)frame{
    
    SpiderWebView *spiderView = [[SpiderWebView alloc] initWithFrame:frame];
    return spiderView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor orangeColor];
        
        //1初始化属性
        [self setInfo:frame];
        
        //2创建蜘蛛网背景layer
        [self buildBackgroundSpiderLayer];
        
        //3创建网状View 及 layer
        [self buildForwardsSpiderView];
        
    }
    
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)array {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor orangeColor];
        

        titleArray = array;
      
        
        //1初始化属性
        [self setInfo:frame];
        
        //2创建蜘蛛网背景layer
        [self buildBackgroundSpiderLayer];
        
        //3创建网状View 及 layer
        [self buildForwardsSpiderView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)array fillColor:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //        self.backgroundColor = [UIColor orangeColor];
        
        
        titleArray = array;
        fillColor = color;
        
        //1初始化属性
        [self setInfo:frame];
        
        //2创建蜘蛛网背景layer
        [self buildBackgroundSpiderLayer];
        
        //3创建网状View 及 layer
        [self buildForwardsSpiderView];
    }
    
    return self;
}

- (void)updateValueArray:(NSArray *)array {
    
}

- (void)start {
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
    seconds = 1;
}
// 秒数 //xhb
- (void)timerChange {
    if (seconds >= 0.01 ) {
        seconds  = seconds - 0.010000;
        
        float n = 1 - seconds / 1.0;

        for (int i = 0; i < titleArray.count; i++) {
            DimensModel *dimendModel = titleArray[i];
            
            float value;
            // xhbtest
            if (dimendModel.score == 0) {
                value = n * 60 / 100.0;
            }
            else {
                value = n * dimendModel.score / 100.0;
            }
            
//                value = n * 60 / 100.0;
     
            
            switch (i) {
                case 0:
                    [self spiderWebViewChangeValue:value type:SpiderWebPower];
                    break;
                case 1:
                    [self spiderWebViewChangeValue:value type:SpiderWebAgile];
                    break;
                case 2:
                    [self spiderWebViewChangeValue:value type:SpiderWebWisdom];
                    break;
                case 3:
                    [self spiderWebViewChangeValue:value type:SpiderWebEnergy];
                    break;
                case 4:
                    [self spiderWebViewChangeValue:value type:SpiderWebSpeed];
                    break;
                case 5:
                    [self spiderWebViewChangeValue:value type:SpiderWebLucky];
                    break;
                    
                default:
                    break;
            }
        }

    }
    else {
        // 停止解释器
        [self timerStop];
        
    }
}


// 计时器结束 //xhb
- (void)timerStop {
    [timer invalidate];
    timer = nil;
}

- (void)stop {
    [self spiderWebViewChangeValue:0.1 type:SpiderWebPower];
    [self spiderWebViewChangeValue:0.1 type:SpiderWebAgile];
    [self spiderWebViewChangeValue:0.1 type:SpiderWebWisdom];
    [self spiderWebViewChangeValue:0.1 type:SpiderWebEnergy];
    [self spiderWebViewChangeValue:0.1 type:SpiderWebSpeed];
    [self spiderWebViewChangeValue:0.1 type:SpiderWebLucky];
}

/**
 属性初始化赋值
 */
- (void)setInfo:(CGRect)frame{
    rectSize = frame;
    //    rectSize = CGRectMake(frame.size.width / 2.0, frame.size.width / 2.0, 200, 200);
    
    strokeLineWith = 1.0f;
    _itemArray = @[@0.1,@0.1,@0.1,@0.1,@0.1,@0.1];
    radius = frame.size.height / 3.5 - strokeLineWith;
    centrePoint = CGPointMake(frame.size.width/(2 + 2.5), frame.size.height/(2 + 3) - AUTO_SCALE_H(15));
//    centrePoint = self.center;
    path = [UIBezierPath bezierPath];
    
}

/**
 绘制背景  // xhb 网状图
 */
- (void)buildBackgroundSpiderLayer{
    for (int i = ((int)_itemArray.count-1); i>0; i--) {
        CAShapeLayer *backGroundSpiderLayer = [CAShapeLayer layer];
        //        backGroundSpiderLayer.frame = CGRectMake(100, 100, rectSize.size.width, rectSize.size.height);
        
        backGroundSpiderLayer.frame = CGRectMake(centrePoint.x, centrePoint.y, rectSize.size.width, rectSize.size.width);
//        backGroundSpiderLayer.backgroundColor = [UIColor blueColor].CGColor; // xhb
        
        [self.layer addSublayer:backGroundSpiderLayer];
        //        backGroundSpiderLayer.backgroundColor = [UIColor blueColor].CGColor;
        [self backgroundSpiderLayer:backGroundSpiderLayer value:(i*0.2f) count:i];
        
    }
    titleA = [[UILabel alloc]init];
    titleB = [[UILabel alloc]init];
    titleC = [[UILabel alloc]init];
    titleD = [[UILabel alloc]init];
    titleE = [[UILabel alloc]init];
    titleF = [[UILabel alloc]init];
    valueA = [[UILabel alloc]init];
    valueB = [[UILabel alloc]init];
    valueC = [[UILabel alloc]init];
    valueD = [[UILabel alloc]init];
    valueE = [[UILabel alloc]init];
    valueF = [[UILabel alloc]init];
    
    NSArray *titleLabelArray = @[titleA, titleB, titleC, titleD, titleE, titleF];
    NSArray *valueLabelArray = @[valueA, valueB, valueC, valueD, valueE, valueF];
    
    [self allinitLabel:titleLabelArray titleArray:titleArray];
    [self allinitLabel:valueLabelArray titleArray:nil];
    
}

- (void)allinitLabel:(NSArray *)array  titleArray:(NSArray *)titleArray {
    for (int i = 0 ; i < array.count; i++) {
        UILabel *la = array[i];
        [self addSubview:la];
        
        la.font = [UIFont systemFontOfSize:11];
        la.textColor = [UIColor whiteColor];
        if (titleArray.count != 0) {
            if (titleArray.count == 0) {
               NSArray *tempArray = @[@"颜值",@"穿搭",@"形象",@"声音",@"谈吐",@"视觉魅力"];
                la.text = tempArray[i];
            }
            else {
                DimensModel *dimendModel = titleArray[i];
                la.text = dimendModel.name;
            }
            
            la.textColor = [UIColor whiteColor];

            la.font = [UIFont systemFontOfSize:AUTO_SCALE_F(11)];
        }
        else {
//            [la mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.centerX.equalTo(self);
//                make.centerY.equalTo(self.mas_centerY);
//            }];
        }
        
        if (i == 0 || i == 3) {
            la.textAlignment = NSTextAlignmentCenter;
        }
        else if (i == 1 || i == 2){
            la.textAlignment = NSTextAlignmentLeft;
        }
        else {
            la.textAlignment = NSTextAlignmentRight;
        }
        
        
    }
}

/**
 绘制前景
 */
- (void)buildForwardsSpiderView{
    
    spiderWebView = [[UIView alloc] initWithFrame:CGRectMake(centrePoint.x, centrePoint.y, rectSize.size.width, rectSize.size.width)];
    spiderWebView.alpha = 0.6f;
//    spiderWebView.backgroundColor = [UIColor redColor]; //xhb
    //    spiderWebView.center = centrePoint;
    [self addSubview:spiderWebView];
    
    spiderWebLayer = [CAShapeLayer layer];
    //    spiderWebLayer.frame = CGRectMake(100, 100, rectSize.size.width, rectSize.size.height);
    spiderWebLayer.frame = spiderWebView.bounds;
    //    spiderWebLayer.backgroundColor = [UIColor greenColor].CGColor; //
    //    spiderWebLayer.contentsCenter = spiderWebView.center;
    [spiderWebView.layer addSublayer:spiderWebLayer];
    //初始的spiderLayer
    //(目的: 计算出 point0 - 1 的初始值)
    for (int i = 0; i<_itemArray.count; i++) {
        [self spiderWebViewChangeValue:[_itemArray[i] floatValue] type:i];
    }
    
    
}

#pragma mark -  背景SpiderLayer绘制方法
- (void)backgroundSpiderLayer:(CAShapeLayer*)layer value:(CGFloat)value count:(int)count{
    
    /*
     sin(弧度)=对边/斜边
     cos(弧度)=邻边/斜边
     所用到的三角形均为直角, C = 90 = > cline
     A = 30 = > a
     B = 60 = > b
     */
    
    CGFloat realRadius = strokeLineWith + radius;
    
    CGPoint pointA;
    CGPoint pointB;
    CGPoint pointC;
    CGPoint pointD;
    CGPoint pointE;
    CGPoint pointF;
    
    //pointA
    CGFloat point0X = realRadius;
    CGFloat point0Y = realRadius - itemScaleLineLenth(value,nil);
    //    CGFloat point0X = centrePoint.x;
    //    CGFloat point0Y = realRadius - itemScaleLineLenth(value,nil);
    pointA = CGPointMake(point0X, point0Y);
    
    //pointB
    CGFloat alina1 = itemScaleLineLenth(value,nil) *sin(radian(30.f));
    CGFloat blina1 = itemScaleLineLenth(value,nil) *cos(radian(30.f));
    CGFloat point1X = realRadius + blina1;
    CGFloat point1Y = realRadius - alina1;
    pointB = CGPointMake(point1X, point1Y);
    
    //pointC
    CGFloat alina2 = itemScaleLineLenth(value,nil) *sin(radian(30.f));
    CGFloat blina2 = itemScaleLineLenth(value,nil) *cos(radian(30.f));
    CGFloat point2X = realRadius + blina2;
    CGFloat point2Y = realRadius + alina2;
    pointC = CGPointMake(point2X, point2Y);
    
    //pointD
    CGFloat point3X = realRadius;
    CGFloat point3Y = realRadius + itemScaleLineLenth(value,nil);
    pointD = CGPointMake(point3X, point3Y);
    
    //pointE
    CGFloat alina4 = itemScaleLineLenth(value,nil) *sin(radian(30.f));
    CGFloat blina4 = itemScaleLineLenth(value,nil) *cos(radian(30.f));
    CGFloat point4X = realRadius - blina4;
    CGFloat point4Y = realRadius + alina4;
    pointE = CGPointMake(point4X, point4Y);
    
    //pointF
    CGFloat alina5 = itemScaleLineLenth(value,nil) *sin(radian(30.f));
    CGFloat blina5 = itemScaleLineLenth(value,nil) *cos(radian(30.f));
    CGFloat point5X = realRadius - blina5;
    CGFloat point5Y = realRadius - alina5;
    pointF = CGPointMake(point5X, point5Y);
    
    //绘制网状路径
    UIBezierPath *backGroundSpiderLayerPath = [UIBezierPath bezierPath];
    [backGroundSpiderLayerPath moveToPoint:pointA];
    [backGroundSpiderLayerPath addLineToPoint:pointB];
    [backGroundSpiderLayerPath addLineToPoint:pointC];
    [backGroundSpiderLayerPath addLineToPoint:pointD];
    [backGroundSpiderLayerPath addLineToPoint:pointE];
    [backGroundSpiderLayerPath addLineToPoint:pointF];
    [backGroundSpiderLayerPath closePath];
    
    layer.path = backGroundSpiderLayerPath.CGPath;
    layer.strokeColor = StrokeColor;
//    if (count%2 == 0) {
//        layer.fillColor = RGBA(216, 216, 216, 1).CGColor;
//
//    }
//    if (count%2 == 1) {
//        layer.fillColor = RGBA(255, 255, 255, 1).CGColor;
//
//    }
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 0.8f;
//    layer.lineWidth = 1 - 0.2125f;
    
    //绘制line
    //pointA-D
    [self addLineWihtpointStart:pointA pointEnd:pointD inLayer:layer];
    //pointE-B
    [self addLineWihtpointStart:pointE pointEnd:pointB inLayer:layer];
    //pointF-C
    [self addLineWihtpointStart:pointF pointEnd:pointC inLayer:layer];
    
    
}

/**
 绘制线段
 
 @param pointStart 起点
 @param pointEnd 重点
 @param layer 加载的layer
 */
- (void)addLineWihtpointStart:(CGPoint)pointStart pointEnd:(CGPoint)pointEnd inLayer:(CAShapeLayer*)layer{
    
    UIBezierPath *lineStartEndPaht = [UIBezierPath bezierPath];
    [lineStartEndPaht moveToPoint:pointStart];
    [lineStartEndPaht addLineToPoint:pointEnd];
    [lineStartEndPaht closePath];
    
    CAShapeLayer *lineStartEndlayer = [CAShapeLayer layer];
    lineStartEndlayer.path = lineStartEndPaht.CGPath;
    lineStartEndlayer.lineWidth = 0.8f;
    lineStartEndlayer.fillColor = [UIColor clearColor].CGColor;
    lineStartEndlayer.strokeColor = StrokeColor;
    [layer addSublayer:lineStartEndlayer];
    
}


#pragma mark -  前景SpiderLayer绘制方法
- (void)spiderWebViewChangeValue:(CGFloat)value type:(SpiderWebItemType)type{
    
    [path removeAllPoints];
    
    /*
     sin(弧度)=对边/斜边
     cos(弧度)=邻边/斜边
     所用到的三角形均为直角, C = 90 = > cline
     A = 30 = > a
     B = 60 = > b
     */
    
    CGFloat realRadius = strokeLineWith + radius;
    
//    NSLog(@"value = %f", value);
    
    if (type == SpiderWebPower) {
        //point0
        CGFloat point0X = realRadius;
        CGFloat point0Y = realRadius - itemScaleLineLenth(value,0);
        point0 = CGPointMake(point0X, point0Y);
        
        valueA.frame = CGRectMake(centrePoint.x+point0X-20, centrePoint.y+point0Y-20, 40, 20);
        valueA.text = [NSString stringWithFormat:@"%0.1lf", value * 100];
        if ([valueA.text isEqualToString:@"60.0"]) {
            valueA.text = @"???";
        }

//        [valueA mas_updateConstraints:^(MASConstraintMaker *make) {
////            make.centerX.equalTo(self);
//            make.centerY.equalTo(self.mas_centerY).offset(point0Y);
//        }];
        
//        titleA.frame = CGRectMake(centrePoint.x+point0X-40, centrePoint.y-20, 80, 20);
        //        NSLog(@"centrePoint.x = %f", centrePoint.x);
        //        NSLog(@"centrePoint.y = %f", centrePoint.y);
        //        NSLog(@"point0X = %f", point0X);
        //        NSLog(@"point0Y = %f", point0Y);
        
        [titleA mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(-radius - 10 - AUTO_SCALE_H(20));
        }];
    }
    
    if (type == SpiderWebAgile) {
        //point1
        CGFloat alina1 = itemScaleLineLenth(value,1) *sin(radian(30.f));
        CGFloat blina1 = itemScaleLineLenth(value,1) *cos(radian(30.f));
        CGFloat point1X = realRadius + blina1;
        CGFloat point1Y = realRadius - alina1;
        point1 = CGPointMake(point1X, point1Y);
        
        valueB.frame = CGRectMake(centrePoint.x+point1X+5, centrePoint.y+point1Y-10, 40, 20);
        valueB.text = [NSString stringWithFormat:@"%0.1lf", value * 100];
        if ([valueB.text isEqualToString:@"60.0"]) {
            valueB.text = @"???";
        }
        
//        titleB.frame = CGRectMake(centrePoint.x+radius*2, centrePoint.y+radius/2-10,80, 20);
        [titleB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(centrePoint.y-radius-20);
            make.left.equalTo(self.mas_centerX).offset(radius+5);
        }];
    }
    
    if (type == SpiderWebWisdom) {
        //point2
        CGFloat alina2 = itemScaleLineLenth(value,2) *sin(radian(30.f));
        CGFloat blina2 = itemScaleLineLenth(value,2) *cos(radian(30.f));
        CGFloat point2X = realRadius + blina2;
        CGFloat point2Y = realRadius + alina2;
        point2 = CGPointMake(point2X, point2Y);
        
        valueC.frame = CGRectMake(centrePoint.x+point2X+5, centrePoint.y+point2Y-10, 40, 20);
        valueC.text = [NSString stringWithFormat:@"%0.1lf", value * 100];
        if ([valueC.text isEqualToString:@"60.0"]) {
            valueC.text = @"???";
        }
//        titleC.frame = CGRectMake(centrePoint.x+radius*2, centrePoint.y+radius+20, 80, 20);
        [titleC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(centrePoint.y-20);
            make.left.equalTo(self.mas_centerX).offset(radius+5);
        }];
    }
    
    
    if (type == SpiderWebEnergy) {
        //point3
        CGFloat point3X = realRadius;
        CGFloat point3Y = realRadius + itemScaleLineLenth(value,3);
        point3 = CGPointMake(point3X, point3Y);
        
        valueD.frame = CGRectMake(centrePoint.x+point3X-20, centrePoint.y+point3Y, 40, 20);
        valueD.text = [NSString stringWithFormat:@"%0.1lf", value * 100];
        if ([valueD.text isEqualToString:@"60.0"]) {
            valueD.text = @"???";
        }
//        [valueD mas_updateConstraints:^(MASConstraintMaker *make) {
//            //            make.centerX.equalTo(self);
////            make.centerY.equalTo(self.mas_centerY).offset(point3Y);
//            make.centerY.mas_equalTo(centrePoint.y+point3Y);
//        }];
        
//        titleD.frame = CGRectMake(centrePoint.x+point3X-40, centrePoint.y+radius*2+10, 80, 20);
        [titleD mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_centerY).offset(radius + 10 - AUTO_SCALE_H(20));
        }];
    }
    
    
    if (type == SpiderWebSpeed) {
        //point4
        CGFloat alina4 = itemScaleLineLenth(value,4) *sin(radian(30.f));
        CGFloat blina4 = itemScaleLineLenth(value,4) *cos(radian(30.f));
        CGFloat point4X = realRadius - blina4;
        CGFloat point4Y = realRadius + alina4;
        point4 = CGPointMake(point4X, point4Y);
        
        valueE.frame = CGRectMake(centrePoint.x+point4X-40, centrePoint.y+point4Y-10, 40, 20);
        valueE.text = [NSString stringWithFormat:@"%0.1lf", value * 100];
        if ([valueE.text isEqualToString:@"60.0"]) {
            valueE.text = @"???";
        }
//        titleE.frame = CGRectMake(centrePoint.x-radius/2.0, centrePoint.y+radius+20, 80, 20);
        [titleE mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(centrePoint.y-20);
            make.right.equalTo(self.mas_centerX).offset(-radius+5);
        }];
    }
    
    if (type == SpiderWebLucky) {
        //point5
        CGFloat alina5 = itemScaleLineLenth(value,5) *sin(radian(30.f));
        CGFloat blina5 = itemScaleLineLenth(value,5) *cos(radian(30.f));
        CGFloat point5X = realRadius - blina5;
        CGFloat point5Y = realRadius - alina5;
        point5 = CGPointMake(point5X, point5Y);
        
        valueF.frame = CGRectMake(centrePoint.x+point5X-40, centrePoint.y+point5Y-10, 40, 20);
        valueF.text = [NSString stringWithFormat:@"%0.1lf", value * 100];
        if ([valueF.text isEqualToString:@"60.0"]) {
            valueF.text = @"???";
        }
//        titleF.frame = CGRectMake(centrePoint.x-radius/2.0, centrePoint.y+radius/2.0-10, 80, 20);
        [titleF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(centrePoint.y-radius-20);
            make.right.equalTo(self.mas_centerX).offset(-radius+5);
        }];
    }
    
    
    [path moveToPoint:point0];
    [path addLineToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path closePath];
    
    
    spiderWebLayer.path = path.CGPath;
//    spiderWebLayer.strokeColor = RGBA(140, 144, 157, 1).CGColor;
    spiderWebLayer.strokeColor = UI_COLOR_FROM_RGB(0x58cbc4).CGColor;  // 选中区域的边框颜色
//    spiderWebLayer.fillColor = RGBA(29, 204, 140, 1).CGColor;
    spiderWebLayer.fillColor = UI_COLOR_FROM_RGB(0x58cbc4).CGColor; // 选中区域的填充颜色
    spiderWebLayer.lineWidth = 1.f;
    
//    // xhbtest
//    spiderWebLayer.path = path.CGPath;
//    //    spiderWebLayer.strokeColor = RGBA(140, 144, 157, 1).CGColor;
//    spiderWebLayer.strokeColor = fillColor.CGColor;  // 选中区域的边框颜色
//    //    spiderWebLayer.fillColor = RGBA(29, 204, 140, 1).CGColor;
////    spiderWebLayer.fillColor = fillColor.CGColor; // 选中区域的填充颜色
//    spiderWebLayer.fillColor = [UIColor clearColor].CGColor;
//    spiderWebLayer.lineWidth = 1.f;
//
}



//path必须在drawRect方法执行 否则报错
/*
 <Error>: CGContextRestoreGState: invalid context 0x0. If you want to see the backtrace, please set CG_CONTEXT_SHOW_BACKTRACE environmental variable.
 */
-(void)drawRect:(CGRect)rect{
    //    [path stroke];
    //    [path fill];
}

- (void)dealloc {
    XHBLOG(@"雷达图释放");
//    [self stop];
    [self clearView];
    
//    self = NULL;
}


@end

