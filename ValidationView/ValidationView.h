//
//  GraphicsValidationView.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ValidationViewBlock)(NSString *codeStr);

@interface ValidationView : UIView

@property (nonatomic, copy) NSString *imageCodeStr;
@property (nonatomic, assign) BOOL isRotation;
@property (nonatomic, copy) ValidationViewBlock bolck;

- (void)freshVerCode;


@end
