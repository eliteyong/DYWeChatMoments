//
//  DYComentsPhotoContainerView.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/19.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYComentsPhotoContainerView.h"

@interface DYComentsPhotoContainerView () <SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imageViewsArray;
@end

@implementation DYComentsPhotoContainerView

- (instancetype)init {
    if (self = [super init]) {
        [self createMainView];
    }
    return self;
}

- (void)createMainView {
    NSMutableArray *temp = [NSMutableArray new];

    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        //设置图片的显示格式，填满，居中显示
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        imageView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [temp copy];
}


#pragma mark --- setter

- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray {
    _picPathStringsArray = picPathStringsArray;
    
    //把多余的图片都隐藏
    for (NSInteger i = picPathStringsArray.count; i < self.imageViewsArray.count; i ++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    //如果图片数量为0，直接返回高度0
    if (picPathStringsArray.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:picPathStringsArray];
    CGFloat itemH = 0;
    if (picPathStringsArray.count == 1) {
#warning  这里有个问题暂未解决:现在是本地图片可以这么取；如果是网络图片这里怎么办？
        UIImage *image = [UIImage imageNamed:_picPathStringsArray.firstObject];
        if (image.size.width) {
            itemH = image.size.height / image.size.width * itemW;
        }
    } else {
        itemH = itemW;
    }
    
    NSInteger perRowItemCount = [self perRowItemCountForPicPathArray:picPathStringsArray];
    CGFloat margin = 5;
    
    [picPathStringsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;
        imageView.image = [UIImage imageNamed:obj];
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
    }];
    
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    self.width = w;
    self.height = h;
    
    self.fixedHeight = @(h);
    self.fixedWidth = @(w);
}

#pragma mark --- private actions
//点击图片响应
- (void)tapImageView:(UITapGestureRecognizer *)tap {
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picPathStringsArray.count;
    browser.delegate = self;
    [browser show];
}
//根据数组个数返回itemWidth
- (CGFloat)itemWidthForPicPathArray:(NSArray *)array {
    if (array.count == 1) {
        return 120;
    } else {
        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
        return w;
    }
}
//根据数组个数返回每行的itemCount
- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array {
    if (array.count < 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}

#pragma mark --- SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    NSString *imageName = self.picPathStringsArray[index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}

@end
