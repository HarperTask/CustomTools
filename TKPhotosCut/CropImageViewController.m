//
//  CropImageViewController.m
//  ImageTailor
//
//  Created by yinyu on 15/10/10.
//  Copyright © 2015年 yinyu. All rights reserved.
//

#import "CropImageViewController.h"
#import "TKImageView.h"


#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define CROP_PROPORTION_IMAGE_WIDTH 30.0f
#define CROP_PROPORTION_IMAGE_SPACE 48.0f
#define CROP_PROPORTION_IMAGE_PADDING 20.0f

@interface CropImageViewController () {
    
    NSArray *proportionImageNameArr;
    NSArray *proportionImageNameHLArr;
    NSArray *proportionArr;
    NSMutableArray *proportionBtnArr;
    CGFloat currentProportion;

}

@property (strong, nonatomic) TKImageView *tkImageView;

@end

@implementation CropImageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = kGROUP_COLOR;
    
    self.title = @"图片剪裁";
    
    [self createView];
    
    [self setUpTKImageView];
    
     _tkImageView.cropAspectRatio = _scale;
}


- (void)createView {
    UIView *footView = [[UIView alloc]init];
    [Controls viewWith:footView frame:KFRAME backColor:kWHITE_COLOR alpha:1 cornerRadius:0];
    [self.view addSubview:footView];
    
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(AUTO_SCALE_W(60));
    }];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [Controls buttonWith:cancelBtn frame:KFRAME backImageName:@"" title:@"取消" titleColor:k00_COLOR backColor:nil font:0 target:self action:@selector(cancelClick) cornerRadius:0];
    cancelBtn.contentMode = UIViewContentModeScaleAspectFit;
    [footView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(AUTO_SCALE_W(10));
        make.left.mas_equalTo(AUTO_SCALE_W(10));
//        make.size.mas_equalTo(AUTO_SCALE_W(40));
    }];
    
    UIButton *deterBtn = [[UIButton alloc]init];
    [Controls buttonWith:deterBtn frame:KFRAME backImageName:@"" title:@"使用图片" titleColor:k00_COLOR backColor:nil font:0 target:self action:@selector(deterClick) cornerRadius:0];
    deterBtn.contentMode = UIViewContentModeScaleAspectFit;
    [footView addSubview:deterBtn];
    
    [deterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cancelBtn);
        make.right.mas_equalTo(-AUTO_SCALE_W(10));
//        make.size.equalTo(cancelBtn);
    }];
    
    self.tkImageView = [[TKImageView alloc]init];
    [self.view addSubview:self.tkImageView];
    
    [self.tkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_HEIGHT);
        make.left.equalTo(self.view);
        make.bottom.equalTo(footView.mas_top);
        make.right.equalTo(self.view);
    }];
    
}

//
- (void)setUpTKImageView {
    
    _tkImageView.toCropImage = _image;
    _tkImageView.showMidLines = YES;
    _tkImageView.needScaleCrop = YES;
    _tkImageView.showCrossLines = YES;
    _tkImageView.cornerBorderInImage = NO;
    _tkImageView.cropAreaCornerWidth = 44;
    _tkImageView.cropAreaCornerHeight = 44;
    _tkImageView.minSpace = 30;
    
    // 图片四个顶点线
    _tkImageView.cropAreaCornerLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaCornerLineWidth = 4;
    
    // 图片四个边界线
    _tkImageView.cropAreaBorderLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaBorderLineWidth = 2;
    
    // 图片
    _tkImageView.cropAreaMidLineWidth = 20;
    _tkImageView.cropAreaMidLineHeight = 6;
    _tkImageView.cropAreaMidLineColor = [UIColor redColor];
    
    // 图片分割线---"#"
    _tkImageView.cropAreaCrossLineColor = [UIColor whiteColor];
    _tkImageView.cropAreaCrossLineWidth = 2;
    
    // 图片选择框默认缩放比
    _tkImageView.initialScaleFactor = .8f;
    
}

/** 取消剪裁 */
- (void)cancelClick {
    [self.navigationController popViewControllerAnimated: YES];
}

/** 确定剪裁 */
- (void)deterClick {
    if (self.block) {
        self.block([_tkImageView currentCroppedImage]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

@end
