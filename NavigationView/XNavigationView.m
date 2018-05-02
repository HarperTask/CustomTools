//
//  XNavigationView.m
//  CMe
//
//  Created by OS X on 2018/3/6.
//  Copyright © 2018年 杭州石匍丁科技公司. All rights reserved.
//

#import "XNavigationView.h"

@implementation XNavigationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithTitle:(NSString *)titleStr {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_HEIGHT);
        
        [self createViewWithTitle:titleStr];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)titleStr {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_HEIGHT);
        
        [self createViewWithTitle:titleStr];
    }
    
    return self;
}

- (void)createViewWithTitle:(NSString *)titleStr {
    
    [self clearView];
    self.backgroundColor = kMAIN_COLOR;
    
//    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_HEIGHT)];
//    tempView.backgroundColor = kWHITE_COLOR;
//    [self.view addSubview:tempView];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = kE5_COLOR;
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [Controls labelWith:titleLabel frame:KFRAME title:titleStr titleColor:kBLACK_COLOR backColor:nil font:0 bold:NO cornerRadius:0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:AUTO_SCALE_F(19)];
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line);
        make.bottom.equalTo(line.mas_top);
        make.right.equalTo(line);
        make.height.mas_equalTo(44);
    }];
    
    
//    UIImageView *leftImageView = [[UIImageView alloc]init];
//    leftImageView.image = [UIImage imageNamed:@"back"];
    UIButton *leftImageView = [[UIButton alloc]init];
    
    [leftImageView setImage:IMAGE(@"back") forState:UIControlStateNormal];
    leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:leftImageView];
    
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(UIBarButtonSystemItemFixedSpace+10);
        make.bottom.equalTo(line);
        make.size.mas_equalTo(44);
    }];
    
    //    leftImageView.contentMode = UIViewContentModeScaleAspectFit;
//    leftImageView.frame = CGRectMake(0, DIANCHILAN_HEIGHT, 44, 44);
    
    //    [tempView addSubview:leftImageView];
    
    //    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(x)
    //    }]
}

@end
