//
//  CropImageViewController.h
//  ImageTailor
//
//  Created by yinyu on 15/10/10.
//  Copyright © 2015年 yinyu. All rights reserved.
//

//#import <UIKit/UIKit.h>
//
//@interface CropImageViewController : UIViewController
//
//@property (strong, nonatomic) UIImage *image;
//@property (nonatomic, strong) UIViewController *vc;
//
//@end

#import "BaseViewController.h"

typedef void(^CropImageBlock)(UIImage *cropimage);

@interface CropImageViewController : BaseViewController

@property (strong, nonatomic) UIImage *image;

@property (nonatomic, assign) float scale;
@property (nonatomic, copy) CropImageBlock block;

@end
