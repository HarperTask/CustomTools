//
//  StarView.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "StarView.h"
#define SCREEN_WIDTH       [UIScreen mainScreen].bounds.size.width      /* 屏幕宽度 */
#define SCREEN_HEIGHT      [UIScreen mainScreen].bounds.size.height     /* 屏幕高度 */


@interface StarView ()
{
//    int totalNum;
//    float scoreNum;
//    CGSize starSize;
    
}

@end

@implementation StarView

- (id)initWithFrame:(CGRect)frame StarSize:(CGSize)starSize {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.totalNum = self.totalNum ?: 5;
        self.scoreNum = self.scoreNum ?: 0;
        self.starWidth = starSize.width ?: SCREEN_WIDTH*0.035;
        self.starHeight = starSize.height ?: SCREEN_WIDTH*0.035;
        self.starSpace = self.starSpace ?: 3;

        [self setStar];

    }
    return self;

}


- (void)setStar {
    
    UIImage *selectedImage = [UIImage imageNamed:@"star_select"];
    UIImage *unSelectedImage = [UIImage imageNamed:@"star_unselect"];
    UIImage *halfSelectedImage = [UIImage imageNamed:@"star_select"];
    
    //创建星星 imageview
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < self.totalNum; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithImage:unSelectedImage];
        imgView.frame = CGRectMake((self.starWidth + self.starSpace)*i, 0, self.starWidth, self.starHeight);
        imgView.tag = i;
        
        [imageArray addObject:imgView];
        [self addSubview:imgView];
    }

    
    //取整,先设置完整的星星
    int a = (int)self.scoreNum;
    for (int i = 1; i <= a; i++) {
        UIImageView *current = [imageArray objectAtIndex:(i-1)];
        
        UIImageView *lastimgView = [imageArray objectAtIndex:a];
        
        if(current.tag == i){
            current.image = selectedImage;
        }
        
        //有不满一个的星星
        if (self.scoreNum>a && self.scoreNum<a+1) {
            lastimgView.image = halfSelectedImage;
        }
        
    }
    
}


@end
