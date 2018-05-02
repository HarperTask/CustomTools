//
//  GoodsImageBroseVC.m
//  doucui
//
//  Created by 吴振松 on 16/10/12.
//  Copyright © 2016年 lootai. All rights reserved.
//

typedef enum {
    NavigationBarItemTypeBack,
    NavigationBarItemTypeLeft,
    NavigationBarItemTypeRight,
} NavigationBarItemType;

#import "WSPhotosBroseVC.h"

@implementation WSPhotosBroseVC

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)initializeView {
    [super initializeView];
    
    //自定义返回按钮
    UIButton *leftBtn = [[UIButton alloc]init];
    [Controls buttonWith:leftBtn frame:CGRectMake(0, 0, 12, 20) backImageName:@"back" title:nil titleColor:kWHITE_COLOR backColor:nil font:14.0 target:self action:@selector(onClickBack) cornerRadius:0];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer,leftItem];
//    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 删除
    UIButton *rightBtn = [[UIButton alloc]init];
    [Controls buttonWith:rightBtn frame:CGRectMake(0, 0, 40, 20) backImageName:nil title:@"删除" titleColor:k1D_COLOR backColor:nil font:14.0 target:self action:@selector(onClickDel) cornerRadius:0];
    UIBarButtonItem *righttem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = righttem;

    
    
//    [self setBarButtonWithText:@"删除" target:self action:@selector(onClickDel) type:NavigationBarItemTypeRight];
//    [self setBarButtonWithText:@"返回" target:self action:@selector(onClickBack) type:NavigationBarItemTypeLeft];
}

-(UIBarButtonItem *)setBarButtonWithText:(NSString*)text
                                  target:(id)target
                                  action:(SEL)action
                                    type:(NavigationBarItemType)type {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [button setTitle:text forState:UIControlStateNormal];
    [button sizeToFit];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -8;
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (type == NavigationBarItemTypeLeft) {
        self.navigationItem.leftBarButtonItems = @[space,buttonItem];
    }
    else if(type == NavigationBarItemTypeRight) {
        self.navigationItem.rightBarButtonItems = @[space,buttonItem];
    }
    else {
        self.navigationItem.backBarButtonItem = buttonItem;
    }
    
    return buttonItem;
}


- (void)onClickDel {
    if(self.showIndex >= 0 && self.showIndex < self.imageArray.count) {
        [self.imageArray removeObjectAtIndex:self.showIndex];
        [self.collectionView reloadData];
    }
    [self refreshTitle];
    if(self.imageArray.count == 0) {
        [self onClickBack];
    }
}

- (void)onClickBack {
    if(self.completion) {
        NSMutableArray *array = [NSMutableArray new];
        for (WSImageModel *model in self.imageArray) {
            [array addObject:model.image];
        }
        self.completion(array);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
