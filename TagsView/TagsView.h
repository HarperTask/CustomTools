//
//  TagsView.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^BtnBlock)(NSInteger index);

@interface TagsView : UIView

@property (nonatomic,copy) BtnBlock btnBlock;

- (void)btnClickBlock:(BtnBlock)btnBlock;

- (instancetype)initWithFrame:(CGRect)frame dataArr:(NSArray *)array;

@end
