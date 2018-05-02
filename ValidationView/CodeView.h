//
//  CodeView.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CodeViewBlock)(NSString *codeStr);

@interface CodeView : UIView

@property (nonatomic, copy) CodeViewBlock codeBlock;

@property (nonatomic, assign) NSInteger codeNum;
@property (nonatomic, assign) CGFloat codeWidth;
@property (nonatomic, assign) CGFloat codeSpace;

@end
