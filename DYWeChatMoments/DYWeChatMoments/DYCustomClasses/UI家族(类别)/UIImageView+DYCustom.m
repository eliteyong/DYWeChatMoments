//
//  UIImageView+DYCustom.m
//  DYCustomClasses
//
//  Created by admin on 2018/4/13.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "UIImageView+DYCustom.h"

@implementation UIImageView (DYCustom)

+ (instancetype)imageViewWithFrame:(CGRect)frame image:(UIImage *)image {    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];

    imageView.image = image;
    
    return imageView;
}

+ (instancetype)imageViewWithFrame:(CGRect)frame image:(UIImage *)image backgroundColor:(UIColor *)backgroundColor {
    UIImageView *imageView = [self imageViewWithFrame:frame image:image];
    
    if (backgroundColor) {
        imageView.backgroundColor = backgroundColor;
    }
    
    return imageView;
}

+ (instancetype)imageViewWithFrame:(CGRect)frame image:(UIImage *)image backgroundColor:(UIColor *)backgroundColor roundedCornersSize:(CGFloat)cornersSize {
    UIImageView *imageView = [self imageViewWithFrame:frame image:image backgroundColor:backgroundColor];
    
    [imageView setGraphicsCutCircularWithRoundedCornersSize:cornersSize];
    
    return imageView;
}

- (void)setGraphicsCutCircularWithRoundedCornersSize:(CGFloat)cornersSize {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornersSize] addClip];
    
    [self drawRect:self.bounds];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束
    UIGraphicsEndImageContext();
}



@end
