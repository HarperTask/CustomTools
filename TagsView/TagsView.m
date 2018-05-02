//
//  TagsView.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "TagsView.h"


@interface TagsView ()

@property (nonatomic,strong) NSArray *GroupArray;
@property (nonatomic,assign) NSInteger index;

@end

@implementation TagsView

- (instancetype)initWithFrame:(CGRect)frame dataArr:(NSArray *)array {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *backView = [[UIView alloc]init];
        backView.frame = CGRectMake(AUTO_SCALE_W(10), 0, self.frame.size.width-AUTO_SCALE_W(20), 1);
        backView.backgroundColor = [UIColor clearColor];

        [self addSubview:backView];
        
//        UIButton *videoLabel = [[UIButton alloc]init];
//        videoLabel.backgroundColor = [UIColor whiteColor];
//        videoLabel.frame = CGRectMake((self.frame.size.width-100)/2.0, 1, 100, 30);
//        videoLabel.layer.masksToBounds = YES;
//        videoLabel.layer.cornerRadius = 15;
//        [videoLabel setTitle:@"视频标签" forState:UIControlStateNormal];
//        [videoLabel setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0] forState:UIControlStateNormal];
//        videoLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
//        videoLabel.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
//        videoLabel.layer.borderWidth = 1.0f;
//        videoLabel.layer.borderColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0].CGColor;
//        [self addSubview:videoLabel];
        
        self.GroupArray = array;
        
        for (int i = 0; i < array.count; i++) {
            
            NSString *name = array[i];
            
            static UIButton *recordBtn =nil;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
            CGRect rect = [name boundingRectWithSize:CGSizeMake(backView.frame.size.width, AUTO_SCALE_H(30)) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
            
            CGFloat BtnW = rect.size.width + AUTO_SCALE_W(20);
            CGFloat BtnH = rect.size.height + AUTO_SCALE_H(10);
            
            btn.backgroundColor = kWHITE_COLOR;
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = BtnH/2.0;
            btn.layer.borderWidth = 1.0f;
            
            if (i == 0) {
                btn.frame = CGRectMake(0, 0, BtnW, BtnH);
                
            }
            else {
                
                CGFloat yuWidth = backView.frame.size.width - AUTO_SCALE_W(20) - recordBtn.frame.origin.x - recordBtn.frame.size.width;
                
                if (yuWidth >= rect.size.width) {
                    
                    btn.frame = CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + AUTO_SCALE_W(10), recordBtn.frame.origin.y, BtnW, BtnH);
                }
                else {
                    
                    btn.frame = CGRectMake(0, recordBtn.frame.origin.y+recordBtn.frame.size.height+AUTO_SCALE_H(10), BtnW, BtnH);
                }
                
            }
            
            [btn setTitle:name forState:UIControlStateNormal];
           
//            [self addSubview:btn];
            [backView addSubview:btn];
            

            backView.frame = CGRectMake(backView.frame.origin.x, backView.frame.origin.y,backView.frame.size.width,CGRectGetMaxY(btn.frame)+AUTO_SCALE_H(10));
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width,CGRectGetMaxY(btn.frame)+10);
            
            recordBtn = btn;
            
            
            btn.tag = i;
            [btn setTitleColor:k00_COLOR forState:UIControlStateNormal];
            btn.layer.borderColor = [kE5_COLOR CGColor];

            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
        }
    }
    
    
    return self;
    
}

- (void)btnClick:(UIButton *)sender {
    
    
    __weak typeof(self) weakSelf = self;
    
    if (weakSelf.btnBlock) {
        
        if ([sender.backgroundColor isEqual:kMAIN_COLOR]) {
            sender.backgroundColor = kWHITE_COLOR;
        }
        else {
            sender.backgroundColor = kMAIN_COLOR;
        }
        
        weakSelf.btnBlock(sender.tag);
    }
    
}

- (void)btnClickBlock:(BtnBlock)btnBlock{
    
    self.btnBlock = btnBlock;
    
}

@end
