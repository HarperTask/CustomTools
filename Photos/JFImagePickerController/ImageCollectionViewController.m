//
//  ImageCollectionViewController.m
//  ImagePickerController
//
//  Created by Johnil on 15-7-3.
//  Copyright (c) 2015年 Johnil. All rights reserved.
//

#import "ImageCollectionViewController.h"
#import "ImagePickerViewCell.h"
#import "PhotoBrowserViewController.h"
#import "ImagePickerController.h"
#import "AssetHelper.h"
#import "ImageManager.h"
#import <ImageIO/ImageIO.h>

@interface ImageCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, PhotoBrowserDelegate>

@end

@implementation ImageCollectionViewController {
	UICollectionView *photosList;
	NSInteger currentIndex;
    BOOL scrollToToping;
    NSTimer *timer;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//	self.navigationItem.title = [[ASSETHELPER.assetGroups objectAtIndex:ASSETHELPER.currentGroupIndex] valueForProperty:ALAssetsGroupPropertyName];
    self.navigationItem.title = @"照片库";
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.text = @"照片库";
    label.font = [UIFont systemFontOfSize:17];
    [label sizeToFit];
    self.navigationItem.titleView = label;
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
	UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
	self.navigationItem.rightBarButtonItem = cancel;
    
    UIButton *leftBtn = [[UIButton alloc]init];
    [Controls buttonWith:leftBtn frame:CGRectMake(0, 0, 12, 20) backImageName:@"goback" title:nil titleColor:kWHITE_COLOR backColor:nil font:14.0 target:self action:@selector(cancel) cornerRadius:0];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;


    
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNormalPhotoBrowser:) name:@"showNormalPhotoBrowser" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
	self.navigationItem.title = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)cancel {
	[(ImagePickerController *)self.navigationController cancel];
}

- (UICollectionView *)collectionView{
	return photosList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 3;
    NSInteger size = [UIScreen mainScreen].bounds.size.width/4-1;
    if (size%2!=0) {
        size-=1;
    }
    flowLayout.itemSize = CGSizeMake(size, size);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

	photosList = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    photosList.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    photosList.scrollIndicatorInsets = photosList.contentInset;
	photosList.delegate = self;
	photosList.dataSource = self;
	photosList.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:photosList];
	[photosList registerClass:[ImagePickerViewCell class] forCellWithReuseIdentifier:@"imagePickerCell"];
	[ASSETHELPER getPhotoListOfGroupByIndex:ASSETHELPER.currentGroupIndex result:^(NSArray *r) {
        [[ImageManager sharedManager] startCahcePhotoThumbWithSize:CGSizeMake(size, size)];
		[photosList reloadData];
		if (ASSETHELPER.previewIndex>=0) {
			PhotoBrowserViewController *photoBrowser = [[PhotoBrowserViewController alloc] initWithPreview];
			photoBrowser.delegate = self.navigationController;
			[self.navigationController pushViewController:photoBrowser animated:YES];
        }

        for (NSDictionary *dict in ASSETHELPER.selectdPhotos) {
            NSArray *temp = [[[dict allKeys] firstObject] componentsSeparatedByString:@"-"];
            NSInteger row = [temp[0] integerValue];
            NSInteger group = [temp[1] integerValue];
            if (group==ASSETHELPER.currentGroupIndex) {
                [photosList scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
                break;
            }
        }
	}];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return [ASSETHELPER getPhotoCountOfCurrentGroup];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	ImagePickerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imagePickerCell" forIndexPath:indexPath];
	cell.indexPath = indexPath;
    cell.tag = indexPath.item;
    ALAsset *asset = [ASSETHELPER getAssetAtIndex:indexPath.row];
    [[ImageManager sharedManager] thumbWithAsset:asset resultHandler:^(UIImage *result) {
        if (cell.tag==indexPath.item) {
            cell.imageView.image = result;
        }
    }];
	BOOL hasItem = NO;
	int num = 0;
	for (NSDictionary *temp in ASSETHELPER.selectdPhotos) {
		if ([[[temp allKeys] firstObject] isEqualToString:[NSString stringWithFormat:@"%ld-%ld",(long)indexPath.row, (long)ASSETHELPER.currentGroupIndex]]) {
			num = [[[temp allValues] firstObject] intValue];
			hasItem = YES;
		}
	}
	if (hasItem) {
		[cell selectOfNum:num];
	} else {
		[cell selectOfNum:-1];
	}
	return cell;
}

- (void)showNormalPhotoBrowser:(NSNotification *)notifi{
	currentIndex = [notifi.object row];
	PhotoBrowserViewController *photoBrowser = [[PhotoBrowserViewController alloc] initWithNormal];
	photoBrowser.delegate = self;
	[self.navigationController pushViewController:photoBrowser animated:YES];
}

- (NSInteger)numOfPhotosFromPhotoBrowser:(PhotoBrowserViewController *)browser{
	return [ASSETHELPER getPhotoCountOfCurrentGroup];
}

- (NSInteger)currentIndexFromPhotoBrowser:(PhotoBrowserViewController *)browser{
	return currentIndex;
}

- (ALAsset *)assetWithIndex:(NSInteger)index fromPhotoBrowser:(PhotoBrowserViewController *)browser{
    return [ASSETHELPER getAssetAtIndex:index];
}

- (void)photoBrowser:(PhotoBrowserViewController *)browser didShowPage:(NSInteger)page{
    [photosList scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
}

- (ImagePickerViewCell *)cellForRow:(NSInteger)row{
	return (ImagePickerViewCell *)[photosList cellForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
}

@end
