//
//  WScrollView.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "WScrollView.h"


@interface WScrollView ()<UIScrollViewDelegate>
{

    NSMutableArray        *_urlArray;
    /**图片总数**/
    NSInteger             _imageCount;
//    CGRect                _frame;
    CGFloat               _imageWidth;
    CGFloat               _imageHeight;
    NSInteger             _scrollIndex;
    NSTimer              *_timer;
}

@property (nonatomic, strong) UIScrollView *scrollview;

@end

@implementation WScrollView


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 先刷新一次，把占位图放上
    [self scrollViewLoadImages];
    
    [self startTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 初始化
- (instancetype)initWithCurrentController:(UIViewController *)viewcontroller urlString:(NSArray *)urls viewFrame:(CGRect)frame placeholderImage:(UIImage *)image {
    if (self = [super init]) {
        [viewcontroller addChildViewController:self];
        _urlArray = [[NSMutableArray alloc]initWithArray:urls];
        _imageCount       = urls.count;
//        _frame           = frame;
        _imageWidth       = frame.size.width;
        _imageHeight      = frame.size.height;
        _placeholderImage  = image;
        
//        self.view.frame   = CGRectMake(0, 0, SCREEN_WIDTH, _imageHeight);
//        self.view.center = CGPointMake(viewcontroller.view.center.x, _imageHeight/2.0);
        
        self.view.frame = frame;
        
        _scrollview = [[UIScrollView alloc]init];
        [Controls scrollViewWith:_scrollview frame:frame contentSize:CGSizeMake(_imageWidth*(_imageCount+2), _imageHeight) delegate:self bounces:NO pagingEnabled:YES showsHorizontal:NO showsVertical:NO];
        _scrollview.contentOffset = CGPointMake(_imageWidth, 0);
        [self.view addSubview:self.scrollview];
        
        _pageControl = [[UIPageControl alloc]init];
        [Controls pageControlWith:_pageControl frame:CGRectMake(0, _imageHeight-20, _imageWidth, 20) numberOfPages:_imageCount currentPage:0 backgroundColor:nil pageTintColor:nil currentTintColor:kMAIN_COLOR action:nil];
//        _pageControl.center = CGPointMake(viewcontroller.view.center.x, _imageHeight-10);
        [self.view addSubview:self.pageControl];
        
        
        [self loadImageViews];


    }
    return self;
}

#pragma mark - 创建控件
//懒加载 pageControl
//- (UIPageControl *)pageControl {
//    if (_pageControl == nil) {
//        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _imageHeight-20, _imageWidth, 20)];
////        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _imageHeight-20, 320, 20)];
//
//        _pageControl.numberOfPages = _imageCount;
//        _pageControl.currentPage = 0;
//        _pageControl.currentPageIndicatorTintColor = kMAIN_COLOR;
//
//    }
//    return _pageControl;
//}
//
////懒加载 scrollview
//- (UIScrollView *)scrollview {
//    if (!_scrollview) {
//        _scrollview = [[UIScrollView alloc] initWithFrame:_frame];
//        _scrollview.contentSize = CGSizeMake(_imageWidth*(_imageCount+2), _imageHeight);
//        _scrollview.contentOffset = CGPointMake(_imageWidth, 0);
//        _scrollview.showsHorizontalScrollIndicator = NO;//水平滚动轴
//        _scrollview.showsVerticalScrollIndicator = NO;//垂直滚动轴
//        _scrollview.pagingEnabled = YES;
//        _scrollview.delegate = self;
//        _scrollIndex = 1;
//
//        [self loadImageViews];
//    }
//    
//    return _scrollview;
//}

//创建相框
- (void)loadImageViews {
    for (int i = 0; i < _urlArray.count+2; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = _placeholderImage;
        imgView.userInteractionEnabled = YES;
        imgView.tag = i + 10000;
        
        if (i == 0) {
            imgView.frame = CGRectMake(0, 0, _imageWidth, _imageHeight);
            
        }else if (i == _urlArray.count+1){
            imgView.frame = CGRectMake((_urlArray.count+1)*_imageWidth, 0, _imageWidth, _imageHeight);
            
        }else{
            imgView.frame = CGRectMake(i*_imageWidth, 0, _imageWidth, _imageHeight);
            
        }
        
        [_scrollview addSubview:imgView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        [imgView addGestureRecognizer:tap];
    }
}

//加载图片
- (void)scrollViewLoadImages {
//    for (int i = 0; i < _urlArray.count+2; i++) {

//        UIImageView *imgView = (UIImageView *)[_scrollview viewWithTag:i+10000];
        
        //////xhb
//        if (i == 0) {
//            [imgView sd_setImageWithURL:[_urlArray[_urlArray.count-1] urlFromStringWithToken:NO] placeholderImage:_placeholderImage options:0];
//
//        }
//        else if (i == _urlArray.count+1){
//            [imgView sd_setImageWithURL:[_urlArray[0] urlFromStringWithToken:NO] placeholderImage:_placeholderImage options:0];
//
//        }else{
//            [imgView sd_setImageWithURL:[_urlArray[i-1] urlFromStringWithToken:NO] placeholderImage:_placeholderImage options:0];
//
//        }

//    }
}

#pragma mark - Timer
- (void)nextPage {
    [self.scrollview setContentOffset:CGPointMake((_scrollIndex+1)*_imageWidth, 0) animated:YES];
}

- (void)startTimer {
//    _timer = [NSTimer timerWithTimeInterval:self.timeInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
}

- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - TapGesture
- (void)tapImage:(UITapGestureRecognizer *)gesture {
    if (gesture.view.tag == _imageCount+1) {
        gesture.view.tag = 1;
    }
    if ([self.delegate respondsToSelector:@selector(scrollImage:clickedAtIndex:)]) {
        [self.delegate scrollImage:self clickedAtIndex:gesture.view.tag];
    }
}
///Users/Admin/Desktop/9F0B53B5-799E-43FE-A762-4A07E1071892.png
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _scrollIndex = scrollView.contentOffset.x / _imageWidth;
    @try {
        // 开始显示最后一张图片的时候切换到第二个图
        if (scrollView.contentOffset.x > _imageWidth*(_imageCount+1)) {
            [scrollView setContentOffset:CGPointMake(_imageWidth+scrollView.contentOffset.x-_imageWidth*(_imageCount+1), 0) animated:NO];
            if (_timer) {
                [self nextPage];
            }
        }
        // 开始显示第一张图片的时候切换到倒数第二个图
        if (scrollView.contentOffset.x < _imageWidth) {
            [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x+_imageWidth*_imageCount, 0) animated:NO];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = _scrollIndex;
    if (_scrollIndex == _imageCount+1) {
        index = 1;
    }
    _pageControl.currentPage = index-1;
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger index = _scrollIndex;
    if (_scrollIndex == _imageCount+1) {
        index = 1;
    }
    _pageControl.currentPage = index-1;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_timer setFireDate:[NSDate distantPast]];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_timer setFireDate:[NSDate distantFuture]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


