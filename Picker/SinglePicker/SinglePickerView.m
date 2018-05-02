//
//  PickerView.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "SinglePickerView.h"

@interface SinglePickerView ()
<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger currentRow;
}

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *btnView;
@property (nonatomic, strong) UILabel *selectLabel;

@end

@implementation SinglePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate {
    if (frame.size.width>frame.size.height) {
        float a = frame.size.height;
        frame.size.height = frame.size.width;
        frame.size.height = a;
    }
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        currentRow = self.dataArray.count/2.0;
        
        self.bounds = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
        self.layer.opacity = 0.0;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
        [self createTap];
        [self createView];
        [self creaeButton];
    }
    
    return self;
}

// view
- (void)createView {
    
    // 内容背景
    self.contentView = [[UIView alloc] init]; // CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, AUTO_SCALE_H(240))
    [Controls viewWith:self.contentView frame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, AUTO_SCALE_H(240)) backColor:kWHITE_COLOR alpha:1 cornerRadius:0];
    [self addSubview:self.contentView];
    
    // 按钮背景
    self.btnView = [[UIView alloc] init];
    [Controls viewWith:self.btnView frame:CGRectMake(0, 0, SCREEN_WIDTH, AUTO_SCALE_H(46)) backColor:kWHITE_COLOR alpha:1.0 cornerRadius:0];
    [self.contentView addSubview:self.btnView];
    
    // 标题
    self.selectLabel = [[UILabel alloc]init];
    [Controls labelWith:self.selectLabel frame:CGRectMake(0, 0, SCREEN_WIDTH-AUTO_SCALE_W(200), FUNC_H(self.btnView)) title:@"请选择" titleColor:k1D_COLOR backColor:nil font:17 bold:NO cornerRadius:0];
    self.selectLabel.textAlignment = NSTextAlignmentCenter;
    self.selectLabel.center = self.btnView.center;
    [self.btnView addSubview:self.selectLabel];
    
    // 选择器
    self.picker = [[UIPickerView alloc]init];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.picker.backgroundColor = kWHITE_COLOR;
    self.picker.frame = CGRectMake(0, FUNC_Y(self.btnView)+FUNC_H(self.btnView), SCREEN_WIDTH, AUTO_SCALE_H(180));
    [self.contentView addSubview:self.picker];
    

}

// button
- (void)creaeButton {
    UIColor *color = [UIColor colorWithRed:205.0/255 green:205.0/255 blue:205.0/255 alpha:1];
    
    UIButton *cancleButton = [[UIButton alloc]init];// CGRectMake(16, 0, AUTO_SCALE_H(64), AUTO_SCALE_H(36))
    [Controls buttonWith:cancleButton frame:KFRAME backImageName:nil title:@"取消" titleColor:[UIColor lightGrayColor] backColor:nil font:15.0 target:self action:@selector(cancelClick) cornerRadius:4];
    [cancleButton.layer setBorderColor:color.CGColor];
    [cancleButton.layer setBorderWidth:0.5];
    [self.btnView addSubview:cancleButton];
    
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnView).offset(AUTO_SCALE_H(5));
        make.left.equalTo(self.btnView).offset(MARGIN_W_15);
        make.width.mas_equalTo(AUTO_SCALE_W(64));
        make.height.mas_equalTo(AUTO_SCALE_H(36));
    }];
    
    UIButton *determineButton = [[UIButton alloc]init];// CGRectMake(SCREEN_WIDTH/2.0, 0, AUTO_SCALE_H(64), AUTO_SCALE_H(36))
    [Controls buttonWith:determineButton frame:KFRAME backImageName:nil title:@"确定" titleColor:k1D_COLOR backColor:nil font:15.0 target:self action:@selector(determineClick) cornerRadius:4];
    [determineButton.layer setBorderColor:color.CGColor];
    [determineButton.layer setBorderWidth:0.5];
    [self.btnView addSubview:determineButton];
    
    [determineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnView).offset(AUTO_SCALE_H(5));
        make.right.equalTo(self.btnView).offset(-MARGIN_W_15);
        make.width.mas_equalTo(AUTO_SCALE_W(64));
        make.height.mas_equalTo(AUTO_SCALE_H(36));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = color;
    [self.btnView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnView);
        make.bottom.equalTo(self.btnView);
        make.right.equalTo(self.btnView);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)createTap {
    UITapGestureRecognizer *blackTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenSinglePickerView)];
    
    [self addGestureRecognizer:blackTap];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    
//    UIView *vi = [[UIView alloc]init];
//    vi.backgroundColor  = kMAIN_COLOR;
//    
//    return vi;
//}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([self.delegate respondsToSelector:@selector(changeSinglePickerView:selectStr:)]) {
        [self.delegate changeSinglePickerView:self selectStr:self.dataArray[row]];
    }
    currentRow = row;
    
    self.selectLabel.text = self.dataArray[row];
}

//
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSDictionary *attriDic = @{NSForegroundColorAttributeName:k1D_COLOR,
                               NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0]};
    NSAttributedString *attriStr = [[NSAttributedString alloc]initWithString:self.dataArray[row] attributes:attriDic];
    
    return attriStr;
}

// 取消
- (void)cancelClick {
    [self hiddenSinglePickerView];
}

// 确定
- (void)determineClick {
    [self hiddenSinglePickerView];
    
    if ([self.delegate respondsToSelector:@selector(determinSinglePickerView:selectStr:)]) {
        [self.delegate determinSinglePickerView:self selectStr:self.dataArray[currentRow]];
    }
}

// 显示选择器
- (void)showSinglePickerView {
//    [[UIApplication sharedApplication].keyWindow addSubview:self];
//
//
//    [UIView animateWithDuration:0.5 animations:^{
//        self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT-FUNC_H(self.contentView), FUNC_W(self.contentView), FUNC_H(self.contentView));
//    }];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    [self.picker selectRow:currentRow inComponent:0 animated:NO];
    
    CGRect frameContent =  self.contentView.frame;
    frameContent.origin.y -= self.contentView.frame.size.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.layer setOpacity:1.0];
        self.contentView.frame = frameContent;
    } completion:^(BOOL finished) {
        
    }];
}

// 隐藏选择器
- (void)hiddenSinglePickerView {
    
//    [UIView animateWithDuration:0.5 animations:^{
//        self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT, FUNC_W(self.contentView), FUNC_H(self.contentView));
//        self.alpha = 0;
//    } completion:^(BOOL finished) {
//
//        self.delegate = nil;
//
//        [self.contentView clearView];
//        [self.contentView removeFromSuperview];
//
//        [self clearView];
//        [self removeFromSuperview];
//    }];
    
    CGRect frameContent =  self.contentView.frame;
    frameContent.origin.y += self.contentView.frame.size.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.layer setOpacity:0.0];
        self.contentView.frame = frameContent;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
