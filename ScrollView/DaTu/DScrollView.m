//
//  DScrollView.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "DScrollView.h"

@interface DScrollView ()
<UIGestureRecognizerDelegate>

{
    UIScrollView * _headScroll;
    UIPageControl * _pageControl;
    NSArray * _imagesArray;
    NSTimer *_time;
    UIView *_BGView;
    UIView *_BGImageView;
    UIScrollView *_scrollview;
    
    CGRect _frame;
    UIView *_view;
    UITapGestureRecognizer *Tap;
    
}

@end

@implementation DScrollView


- (id)initWithFrame:(CGRect)frame withImagesArray:(NSArray *)images {
    if (self = [super initWithFrame:frame]) {
        _imagesArray = images;
        _frame       = frame;
        _view        = self;
        [self setupScrollView];
        
    }
    return self;
}

//添加UISrollView
- (void)setupScrollView {
    // 添加UISrollView
    _headScroll = [[UIScrollView alloc] init];
//    _headScroll.frame = CGRectMake(0, 0, self.bounds.size.width, 300);
    _headScroll.frame = _frame;
    _headScroll.tag = 20001;
    _headScroll.bounces = NO;
    _headScroll.delegate = self;
    _headScroll.pagingEnabled = YES;
    _headScroll.showsHorizontalScrollIndicator = NO;
//    _headScroll.contentSize = CGSizeMake(_imagesArray.count*self.bounds.size.width, 300);
    _headScroll.contentSize = CGSizeMake(_imagesArray.count*_frame.size.width, _frame.size.height);
    //水平垂直方向的滚动条
    _headScroll.showsHorizontalScrollIndicator =NO;
    _headScroll.showsVerticalScrollIndicator  = NO;
    
    // 添加图片
    for (int i = 0; i < _imagesArray.count; i++) {
        // 创建UIImageView
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100 + i;
        
//        imageView.frame = CGRectMake(i * _headScroll.bounds.size.width, 0, self.bounds.size.width, 300);
        imageView.frame = CGRectMake(i * _headScroll.bounds.size.width, 0, _frame.size.width, _frame.size.height);
        imageView.image = [UIImage imageNamed:_imagesArray[i]];
        [_headScroll addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapAction:)];
        [imageView addGestureRecognizer:tap];
    }
    [_view addSubview:_headScroll];
    
    // 3.设置分页属性

    
    //添加定时器
    [self addTimer];
}

#pragma mark - 定时器

//添加定时器
- (void)addTimer {
//        _time = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}

//关闭定时器
- (void)removeTimer {
    [_time invalidate];
}


#pragma mark - 滚动代理。。pageControl方法

- (void)changePage:(UIPageControl *)page {
    [_headScroll setContentOffset:CGPointMake(self.bounds.size.width * page.currentPage, 0) animated:YES];
}

//到下一个图片
- (void)nextImage {

    //当前image的点点
    int page = (int)_pageControl.currentPage;
    if (page == _imagesArray.count-1) {
        page = 0;
    }
    else {
        
        page++;
        
    }
    
    //scrollView滚动到下一张图片
    [UIView animateWithDuration:1.0 animations:^{
        CGFloat x = page *_headScroll.frame.size.width;
        _headScroll.contentOffset = CGPointMake(x, 0);
    }];
}


#pragma mark - UIScrollViewDelegate

// scrollview滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    页码 = (contentoffset.x + scrollView一半宽度)/scrollView宽度
    CGFloat scrollW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x +scrollW /2.0) /scrollW;
    
    _pageControl.currentPage = page;
    
    if (scrollView.tag == 20002) {
        UIScrollView *view = [self viewWithTag:20001];
        [view setContentOffset:CGPointMake(x, 0) animated:YES];
    }
}

// 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.tag == 20001) {
        //关闭定时器
        [self removeTimer];
    }
}

//停止拖拽时调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.tag == 20001) {
        [self addTimer];
    }
}

#pragma mark --图片的点击手势--

- (void)TapAction:(UITapGestureRecognizer *)sender {

    //关闭定时器
    [self removeTimer];
    UIGestureRecognizer *gesture = (UIGestureRecognizer *)sender;
    UIImageView * imageView = (UIImageView *)gesture.view;
    
    // ------- 获得当前点击图片在图片数组中的下标 -------
    NSArray *imageArr1 = [[imageView superview] subviews];
    NSUInteger index = [imageArr1 indexOfObject:imageView];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _BGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [UIScreen mainScreen].bounds.size.height)];;
        _BGView.backgroundColor = [UIColor blackColor];
        
        _BGImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _BGView.frame.size.width, _BGView.frame.size.height)];
        _BGImageView.userInteractionEnabled = YES;
        [_BGView addSubview:_BGImageView];
        
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height-_BGImageView.frame.size.height)/2, _BGImageView.frame.size.width, _BGImageView.frame.size.height)];
        _scrollview.tag = 20002;
        _scrollview.contentOffset = CGPointMake(_BGImageView.frame.size.width*index, 0);
        _scrollview.contentSize = CGSizeMake(_BGImageView.frame.size.width*_imagesArray.count, _BGImageView.frame.size.height);
        _scrollview.delegate = self;
        _scrollview.pagingEnabled = YES;
        _scrollview.showsHorizontalScrollIndicator = NO;
        
        [_BGImageView addSubview:_scrollview];
        [_view addSubview:_BGView];
        
        //单击背景
        UITapGestureRecognizer *_BGTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapBGviewAction:)];
        
        [_BGView addGestureRecognizer:_BGTap];


        
    } completion:^(BOOL finished) {
        
        
        for (int i = 0; i < _imagesArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_imagesArray objectAtIndex:i]]];
            imageView.tag = 100+i;
            imageView.frame = CGRectMake(_scrollview.frame.size.width*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [_scrollview addSubview:imageView];
            
            imageView.userInteractionEnabled = YES;
            
            //单击图片
            Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapBGviewAction:)];
            
//            [imageView addGestureRecognizer:Tap];

            //双击放大
            UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doDoubleTap)];
            doubleTap.numberOfTapsRequired = 2;
            doubleTap.numberOfTouchesRequired = 1;
            [imageView addGestureRecognizer:doubleTap];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width/2+_scrollview.frame.size.width*i, _scrollview.frame.size.height-60, 100, 40)];
            label.text = [NSString stringWithFormat:@"%d/%ld", i+1,(unsigned long)_imagesArray.count];
            label.tag = 1000+i;
            label.textColor = [UIColor redColor];
            [_scrollview addSubview:label];
        }
    }];
}


- (void)TapBGviewAction:(UITapGestureRecognizer *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        
        _BGView.frame = CGRectZero;
        
//        _view.frame = CGRectZero;
    } completion:^(BOOL finished) {
        
        [_BGView removeFromSuperview];
//        [_view removeFromSuperview];
        
        [self addTimer];
    }];
}



- (void)doDoubleTap {
    XHBLOG(@"e3ee");
    
}


@end
