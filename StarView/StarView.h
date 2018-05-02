//
//  StarView.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StarViewConfig;

@interface StarView : UIView

//@property (nonatomic,strong) UIImageView *oneImage;
//@property (nonatomic,strong) UIImageView *twoImage;
//@property (nonatomic,strong) UIImageView *threeImage;
//@property (nonatomic,strong) UIImageView *fourImage;
//@property (nonatomic,strong) UIImageView *fiveImage;

@property (nonatomic, assign) NSInteger totalNum;
@property (nonatomic, assign) CGFloat scoreNum; /* 星星总数,默认是5 */
@property (nonatomic, assign) CGFloat starWidth;
@property (nonatomic, assign) CGFloat starHeight;
@property (nonatomic, assign) CGFloat starSpace;


//- (void)setNumber:(float)number Size:(CGSize)size ;


- (id)initWithFrame:(CGRect)frame StarSize:(CGSize)starSize;


@end




