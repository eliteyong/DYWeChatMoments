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
}

#pragma mark --- private actions

- (void)tapImageView:(UITapGestureRecognizer *)tap {
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picPathStringsArray.count;
    browser.delegate = self;
    [browser show];
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
